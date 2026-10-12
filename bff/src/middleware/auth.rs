use actix_web::{dev::Payload, http::header, web, Error, FromRequest, HttpRequest};
use futures_util::future::LocalBoxFuture;
use jsonwebtoken::{decode, DecodingKey, Validation};
use serde::{Deserialize, Serialize};
use std::sync::Arc;
use uuid::Uuid;

use crate::configuration::Settings;
use crate::error::AppError;
use crate::{DbPool, OptionalRedis};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Claims {
    pub sub: String,
    pub email: String,
    pub jti: String,
    pub exp: usize,
    pub iat: usize,
}

#[derive(Debug, Clone)]
pub struct AuthenticatedUser {
    pub user_id: Uuid,
    pub email: String,
    pub jti: String,
}

/// Revoked access tokens. Redis when available (fast path), Postgres otherwise.
pub struct Blacklist;

impl Blacklist {
    pub async fn revoke(
        pool: &DbPool,
        redis: &OptionalRedis,
        jti: &str,
        ttl_secs: i64,
    ) -> Result<(), AppError> {
        let exp = chrono::Utc::now() + chrono::Duration::seconds(ttl_secs.max(1));
        sqlx::query(
            r#"INSERT INTO auth.token_blacklist (jti, expires_at) VALUES ($1, $2)
               ON CONFLICT (jti) DO NOTHING"#,
        )
        .bind(jti)
        .bind(exp)
        .execute(pool)
        .await?;
        if let Some(r) = redis {
            let mut conn = r.clone();
            let _: Result<(), _> = redis::cmd("SET")
                .arg(format!("bl:{jti}"))
                .arg("1")
                .arg("EX")
                .arg(ttl_secs.max(1))
                .query_async(&mut conn)
                .await;
        }
        Ok(())
    }

    pub async fn is_revoked(pool: &DbPool, redis: &OptionalRedis, jti: &str) -> bool {
        if let Some(r) = redis {
            let mut conn = r.clone();
            if let Ok(v) = redis::cmd("EXISTS")
                .arg(format!("bl:{jti}"))
                .query_async::<i64>(&mut conn)
                .await
            {
                return v > 0;
            }
        }
        sqlx::query_scalar::<_, bool>(
            r#"SELECT EXISTS(SELECT 1 FROM auth.token_blacklist WHERE jti = $1 AND expires_at > NOW())"#,
        )
        .bind(jti)
        .fetch_one(pool)
        .await
        .unwrap_or(false)
    }
}

fn decode_claims(req: &HttpRequest) -> Result<Claims, AppError> {
    let settings = req
        .app_data::<web::Data<Arc<Settings>>>()
        .ok_or_else(|| AppError::internal("Missing settings"))?;

    let auth = req
        .headers()
        .get(header::AUTHORIZATION)
        .and_then(|v| v.to_str().ok())
        .ok_or_else(|| AppError::unauthorized("Missing Authorization header"))?;

    let token = auth
        .strip_prefix("Bearer ")
        .ok_or_else(|| AppError::unauthorized("Expected Bearer token"))?;

    let data = decode::<Claims>(
        token,
        &DecodingKey::from_secret(settings.jwt.secret.as_bytes()),
        &Validation::default(),
    )
    .map_err(|_| AppError::unauthorized("Invalid or expired token"))?;

    Ok(data.claims)
}

impl FromRequest for AuthenticatedUser {
    type Error = Error;
    type Future = LocalBoxFuture<'static, Result<Self, Self::Error>>;

    fn from_request(req: &HttpRequest, _: &mut Payload) -> Self::Future {
        let claims = decode_claims(req);
        let pool = req.app_data::<web::Data<DbPool>>().cloned();
        let redis = req.app_data::<web::Data<OptionalRedis>>().cloned();

        Box::pin(async move {
            let claims = claims?;
            let user_id = Uuid::parse_str(&claims.sub)
                .map_err(|_| AppError::unauthorized("Invalid subject"))?;

            if let Some(pool) = pool {
                let redis: OptionalRedis = redis.map(|r| r.get_ref().clone()).unwrap_or(None);
                if Blacklist::is_revoked(pool.get_ref(), &redis, &claims.jti).await {
                    return Err(AppError::unauthorized("Session revoked").into());
                }
            }

            Ok(AuthenticatedUser {
                user_id,
                email: claims.email,
                jti: claims.jti,
            })
        })
    }
}
