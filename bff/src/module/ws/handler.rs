use actix_web::{http::header, web, Error, HttpRequest, HttpResponse};
use actix_ws::Message;
use futures_util::StreamExt;
use jsonwebtoken::{decode, DecodingKey, Validation};
use serde::Deserialize;
use serde_json::json;
use std::sync::Arc;
use std::time::{Duration, Instant};
use tokio::sync::mpsc;
use uuid::Uuid;

use crate::configuration::Settings;
use crate::error::AppError;
use crate::middleware::auth::{Blacklist, Claims};
use crate::module::dating::DatingService;
use crate::module::ws::WsBroadcaster;
use crate::{DbPool, OptionalRedis};

const HEARTBEAT_INTERVAL: Duration = Duration::from_secs(20);
const CLIENT_TIMEOUT: Duration = Duration::from_secs(45);

#[derive(Debug, Deserialize)]
#[serde(tag = "type", rename_all = "snake_case")]
enum ClientFrame {
    Ping,
    Typing {
        conversation_id: String,
        peer_id: String,
    },
    Send {
        conversation_id: String,
        body: String,
    },
}

async fn authenticate_ws(
    req: &HttpRequest,
    settings: &Settings,
    pool: &DbPool,
    redis: &OptionalRedis,
) -> Result<Uuid, AppError> {
    let token = if let Some(auth) = req.headers().get(header::AUTHORIZATION).and_then(|v| v.to_str().ok()) {
        auth.strip_prefix("Bearer ").map(str::to_string)
    } else {
        let query = req.query_string();
        query.split('&').find_map(|pair| {
            let mut parts = pair.split('=');
            if parts.next()? == "token" {
                let v = parts.next()?;
                urlencoding::decode(v).ok().map(|s| s.into_owned())
            } else {
                None
            }
        })
    }
    .ok_or_else(|| AppError::unauthorized("Missing authentication token"))?;

    let data = decode::<Claims>(
        &token,
        &DecodingKey::from_secret(settings.jwt.secret.as_bytes()),
        &Validation::default(),
    )
    .map_err(|_| AppError::unauthorized("Invalid or expired token"))?;

    let user_id = Uuid::parse_str(&data.claims.sub)
        .map_err(|_| AppError::unauthorized("Invalid subject in token"))?;

    if Blacklist::is_revoked(pool, redis, &data.claims.jti).await {
        return Err(AppError::unauthorized("Session revoked"));
    }

    Ok(user_id)
}

pub async fn ws_route(
    req: HttpRequest,
    stream: web::Payload,
    settings: web::Data<Arc<Settings>>,
    pool: web::Data<DbPool>,
    redis: web::Data<OptionalRedis>,
    broadcaster: web::Data<Arc<WsBroadcaster>>,
    dating: web::Data<Arc<DatingService>>,
) -> Result<HttpResponse, Error> {
    let user_id = match authenticate_ws(&req, &settings, &pool, &redis).await {
        Ok(uid) => uid,
        Err(e) => return Ok(HttpResponse::Unauthorized().json(json!({ "error": e.to_string() }))),
    };

    let (response, mut session, mut msg_stream) = actix_ws::handle(&req, stream)?;
    let (tx, mut rx) = mpsc::unbounded_channel::<String>();

    broadcaster.register(user_id, tx);

    let bc = Arc::clone(&broadcaster);
    let dating_svc = Arc::clone(&dating);

    actix_web::rt::spawn(async move {
        let mut last_heartbeat = Instant::now();
        let mut interval = actix_web::rt::time::interval(HEARTBEAT_INTERVAL);

        loop {
            tokio::select! {
                // Outgoing messages from internal queue to client
                Some(payload) = rx.recv() => {
                    if session.text(payload).await.is_err() {
                        break;
                    }
                }

                // Periodic heartbeat ping to verify connection
                _ = interval.tick() => {
                    if Instant::now().duration_since(last_heartbeat) > CLIENT_TIMEOUT {
                        log::debug!("WS client timeout for user {}", user_id);
                        break;
                    }
                    if session.ping(b"").await.is_err() {
                        break;
                    }
                }

                // Incoming frames from client
                Some(msg) = msg_stream.next() => {
                    match msg {
                        Ok(Message::Ping(bytes)) => {
                            last_heartbeat = Instant::now();
                            let _ = session.pong(&bytes).await;
                        }
                        Ok(Message::Pong(_)) => {
                            last_heartbeat = Instant::now();
                        }
                        Ok(Message::Text(text)) => {
                            last_heartbeat = Instant::now();
                            if let Ok(frame) = serde_json::from_str::<ClientFrame>(&text) {
                                match frame {
                                    ClientFrame::Ping => {
                                        let _ = session.text(json!({ "type": "pong" }).to_string()).await;
                                    }
                                    ClientFrame::Typing { conversation_id, peer_id } => {
                                        if let Ok(peer_uid) = Uuid::parse_str(&peer_id) {
                                            bc.send_to_user(peer_uid, &json!({
                                                "type": "typing",
                                                "conversation_id": conversation_id,
                                                "user_id": user_id.to_string(),
                                            }).to_string()).await;
                                        }
                                    }
                                    ClientFrame::Send { conversation_id, body } => {
                                        match dating_svc.send_message(user_id, &conversation_id, &body).await {
                                            Ok(sent_msg) => {
                                                // Confirm to sender
                                                let _ = session.text(json!({
                                                    "type": "sent_ack",
                                                    "conversation_id": conversation_id,
                                                    "message": sent_msg,
                                                }).to_string()).await;
                                            }
                                            Err(e) => {
                                                let _ = session.text(json!({
                                                    "type": "error",
                                                    "message": e.to_string(),
                                                }).to_string()).await;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        Ok(Message::Close(reason)) => {
                            let _ = session.close(reason).await;
                            break;
                        }
                        _ => break,
                    }
                }
                else => break,
            }
        }

        bc.unregister(user_id);
        log::debug!("WS session closed for user {}", user_id);
    });

    Ok(response)
}
