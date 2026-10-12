use actix_web::{web, App, HttpResponse, HttpServer};
use redis::aio::ConnectionManager;
use std::net::IpAddr;
use std::sync::Arc;

pub mod configuration;
pub mod error;
pub mod middleware;
pub mod module;
pub mod routes;

use dotenvy::dotenv;

pub type DbPool = sqlx::PgPool;
pub type RedisPool = ConnectionManager;
pub type OptionalRedis = Option<RedisPool>;

async fn serve_media(
    storage: web::Data<Arc<module::storage::StorageService>>,
    path: web::Path<String>,
) -> Result<HttpResponse, error::AppError> {
    let key = path.into_inner();
    let bytes = storage.get(&key).await?;
    let content_type = if key.ends_with(".webp") {
        "image/webp"
    } else if key.ends_with(".png") {
        "image/png"
    } else {
        "image/jpeg"
    };

    Ok(HttpResponse::Ok()
        .insert_header(("Cache-Control", "public, max-age=31536000, immutable"))
        .content_type(content_type)
        .body(bytes))
}

pub async fn run() -> Result<(), Box<dyn std::error::Error>> {
    println!("Starting Tea BFF...");
    dotenv().ok();
    env_logger::init_from_env(env_logger::Env::new().default_filter_or("info"));

    let configuration =
        configuration::get_configuration().expect("Failed to load configuration.yaml");
    let database_url = configuration.database.connection_string();
    let redis_url = configuration.redis.connection_string();

    if configuration.jwt.secret.contains("change-this")
        || configuration.jwt.secret.contains("change-me")
        || configuration.jwt.secret.len() < 32
    {
        log::warn!("BFF__JWT__SECRET is weak or default — set a strong random secret (openssl rand -hex 32) before exposing this server.");
    }

    println!(
        "Connecting to database at {}:{}",
        configuration.database.host, configuration.database.port
    );

    let pool = sqlx::postgres::PgPoolOptions::new()
        .max_connections(10)
        .min_connections(1)
        .connect(&database_url)
        .await?;

    println!("Database connected");
    println!("Running migrations...");
    sqlx::migrate!("./migrations").run(&pool).await?;
    println!("Migrations applied");

    let redis_pool: OptionalRedis = match redis::Client::open(redis_url) {
        Ok(client) => match ConnectionManager::new(client).await {
            Ok(mgr) => {
                println!(
                    "Redis connected at {}:{}",
                    configuration.redis.host, configuration.redis.port
                );
                Some(mgr)
            }
            Err(e) => {
                log::warn!("Redis unavailable (continuing): {e}");
                None
            }
        },
        Err(e) => {
            log::warn!("Redis client open failed (continuing): {e}");
            None
        }
    };

    let settings = Arc::new(configuration.clone());
    let email = Arc::new(module::email::EmailService::new(Arc::clone(&settings)));
    let turnstile = Arc::new(module::turnstile::TurnstileService::new(Arc::clone(
        &settings,
    )));
    let sms = Arc::new(module::sms::SmsService::new(Arc::clone(&settings)));
    log::info!("SMS provider: {}", configuration.sms.provider_name());

    let google_oauth = {
        let g = &configuration.oauth.google;
        if g.is_configured() {
            log::info!(
                "Google OAuth configured (redirect {})",
                g.redirect_uri.as_deref().unwrap_or("")
            );
            Some(module::auth::google::GoogleOAuthClient::new(
                module::auth::google::GoogleOAuthConfig {
                    client_id: g.client_id.clone().unwrap(),
                    client_secret: g.client_secret.clone().unwrap(),
                    redirect_uri: g.redirect_uri.clone().unwrap(),
                    signing_key: configuration.jwt.secret.clone(),
                },
            ))
        } else {
            log::warn!("Google OAuth not configured — set BFF__OAUTH__GOOGLE__* in .env");
            None
        }
    };

    let auth_service = Arc::new(module::auth::service::AuthService::new(
        pool.clone(),
        redis_pool.clone(),
        Arc::clone(&settings),
        Arc::clone(&email),
        Arc::clone(&turnstile),
        Arc::clone(&sms),
        google_oauth,
    ));
    let user_service = Arc::new(module::user::service::UserService::new(pool.clone()));

    let storage = Arc::new(module::storage::StorageService::new(Arc::clone(&settings)));
    storage.ensure_ready().await?;
    log::info!(
        "Photo storage ready (public base {})",
        storage.public_url("")
    );

    let push = Arc::new(module::push::PushService::new(
        Arc::clone(&settings),
        pool.clone(),
    ));
    let ws_broadcaster = Arc::new(module::ws::WsBroadcaster::new(redis_pool.clone()));
    let dating_service = Arc::new(module::dating::DatingService::new(
        pool.clone(),
        Arc::clone(&storage),
        Arc::clone(&push),
        Some(Arc::clone(&ws_broadcaster)),
    ));

    let rate_limiter = middleware::RateLimiter::new(
        redis_pool.clone(),
        configuration.rate_limit.auth_per_minute,
        configuration.rate_limit.api_per_minute,
        configuration.rate_limit.enabled,
    );

    let cors_frontend = configuration
        .email
        .frontend_base_url
        .clone()
        .unwrap_or_else(|| configuration.email.base_url.clone());

    let server_host = configuration.application_host.trim().to_string();
    let server_port = configuration.application_port;
    let max_upload = (configuration.storage.max_upload_mb as usize + 4) * 1024 * 1024;

    log::info!("Starting Tea BFF on {server_host}:{server_port}");

    let server = HttpServer::new(move || {
        App::new()
            .wrap(actix_web::middleware::Compress::default())
            .wrap(middleware::cors::configure_cors(cors_frontend.clone()))
            .wrap(rate_limiter.clone())
            .app_data(web::Data::new(pool.clone()))
            .app_data(web::Data::new(redis_pool.clone()))
            .app_data(web::Data::new(Arc::clone(&settings)))
            .app_data(web::Data::new(Arc::clone(&auth_service)))
            .app_data(web::Data::new(Arc::clone(&user_service)))
            .app_data(web::Data::new(Arc::clone(&dating_service)))
            .app_data(web::Data::new(Arc::clone(&storage)))
            .app_data(web::Data::new(Arc::clone(&push)))
            .app_data(web::Data::new(Arc::clone(&ws_broadcaster)))
            .app_data(web::PayloadConfig::new(max_upload))
            .app_data(actix_multipart::form::MultipartFormConfig::default().total_limit(max_upload))
            .configure(routes::config)
            .service(
                web::resource("/media/{path:.*}")
                    .route(web::get().to(serve_media))
                    .route(web::head().to(serve_media)),
            )
    })
    .workers(
        std::thread::available_parallelism()
            .map(|n| n.get().min(4))
            .unwrap_or(2),
    );

    let server = match server_host.parse::<IpAddr>() {
        Ok(ip) => server.bind((ip, server_port))?,
        Err(_) => server.bind((server_host.as_str(), server_port))?,
    };

    server.run().await?;
    Ok(())
}
