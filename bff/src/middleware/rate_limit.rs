//! Fixed-window rate limiting per client. Redis-backed when available so limits
//! hold across BFF replicas; in-memory fallback otherwise.

use actix_web::{
    body::EitherBody,
    dev::{forward_ready, Service, ServiceRequest, ServiceResponse, Transform},
    http::header,
    Error, HttpResponse,
};
use futures_util::future::{ready, LocalBoxFuture, Ready};
use std::collections::HashMap;
use std::rc::Rc;
use std::sync::{Arc, Mutex};
use std::time::{Duration, Instant};

use crate::OptionalRedis;

#[derive(Clone)]
pub struct RateLimiter {
    inner: Arc<Inner>,
}

struct Inner {
    redis: OptionalRedis,
    auth_per_minute: u32,
    api_per_minute: u32,
    enabled: bool,
    memory: Mutex<HashMap<String, (u32, Instant)>>,
}

const WINDOW: Duration = Duration::from_secs(60);

impl RateLimiter {
    pub fn new(
        redis: OptionalRedis,
        auth_per_minute: u32,
        api_per_minute: u32,
        enabled: bool,
    ) -> Self {
        Self {
            inner: Arc::new(Inner {
                redis,
                auth_per_minute,
                api_per_minute,
                enabled,
                memory: Mutex::new(HashMap::new()),
            }),
        }
    }

    fn is_auth_path(path: &str) -> bool {
        path.contains("/auth/login")
            || path.contains("/auth/register")
            || path.contains("/auth/phone/")
            || path.contains("/auth/password-reset")
    }

    fn client_key(req: &ServiceRequest) -> String {
        // Prefer the authenticated subject when present, else the client IP.
        if let Some(auth) = req
            .headers()
            .get(header::AUTHORIZATION)
            .and_then(|v| v.to_str().ok())
        {
            if let Some(token) = auth.strip_prefix("Bearer ") {
                // The token's middle segment is the payload; cheap stable identifier.
                if let Some(mid) = token.split('.').nth(1) {
                    return format!("tok:{}", &mid[..mid.len().min(48)]);
                }
            }
        }
        let ip = req
            .headers()
            .get("x-forwarded-for")
            .and_then(|v| v.to_str().ok())
            .and_then(|v| v.split(',').next())
            .map(|s| s.trim().to_string())
            .or_else(|| req.peer_addr().map(|a| a.ip().to_string()))
            .unwrap_or_else(|| "unknown".into());
        format!("ip:{ip}")
    }

    async fn hit(&self, key: &str, limit: u32) -> Result<u32, ()> {
        if let Some(r) = &self.inner.redis {
            let mut conn = r.clone();
            let rkey = format!("rl:{key}");
            let count: Result<i64, _> = redis::cmd("INCR").arg(&rkey).query_async(&mut conn).await;
            if let Ok(count) = count {
                if count == 1 {
                    let _: Result<(), _> = redis::cmd("EXPIRE")
                        .arg(&rkey)
                        .arg(WINDOW.as_secs())
                        .query_async(&mut conn)
                        .await;
                }
                return if count as u32 > limit {
                    Err(())
                } else {
                    Ok(count as u32)
                };
            }
        }
        let mut map = self.inner.memory.lock().unwrap_or_else(|e| e.into_inner());
        let now = Instant::now();
        if map.len() > 50_000 {
            map.retain(|_, (_, t)| now.duration_since(*t) < WINDOW);
        }
        let entry = map.entry(key.to_string()).or_insert((0, now));
        if now.duration_since(entry.1) >= WINDOW {
            *entry = (0, now);
        }
        entry.0 += 1;
        if entry.0 > limit {
            Err(())
        } else {
            Ok(entry.0)
        }
    }
}

impl<S, B> Transform<S, ServiceRequest> for RateLimiter
where
    S: Service<ServiceRequest, Response = ServiceResponse<B>, Error = Error> + 'static,
    B: 'static,
{
    type Response = ServiceResponse<EitherBody<B>>;
    type Error = Error;
    type Transform = RateLimitMiddleware<S>;
    type InitError = ();
    type Future = Ready<Result<Self::Transform, Self::InitError>>;

    fn new_transform(&self, service: S) -> Self::Future {
        ready(Ok(RateLimitMiddleware {
            service: Rc::new(service),
            limiter: self.clone(),
        }))
    }
}

pub struct RateLimitMiddleware<S> {
    service: Rc<S>,
    limiter: RateLimiter,
}

impl<S, B> Service<ServiceRequest> for RateLimitMiddleware<S>
where
    S: Service<ServiceRequest, Response = ServiceResponse<B>, Error = Error> + 'static,
    B: 'static,
{
    type Response = ServiceResponse<EitherBody<B>>;
    type Error = Error;
    type Future = LocalBoxFuture<'static, Result<Self::Response, Self::Error>>;

    forward_ready!(service);

    fn call(&self, req: ServiceRequest) -> Self::Future {
        let service = Rc::clone(&self.service);
        let limiter = self.limiter.clone();

        Box::pin(async move {
            if !limiter.inner.enabled
                || req.path().ends_with("/health")
                || req.path().starts_with("/media")
            {
                return service.call(req).await.map(|r| r.map_into_left_body());
            }
            let path = req.path().to_string();
            let is_auth = RateLimiter::is_auth_path(&path);
            let limit = if is_auth {
                limiter.inner.auth_per_minute
            } else {
                limiter.inner.api_per_minute
            };
            let key = format!(
                "{}:{}",
                if is_auth { "auth" } else { "api" },
                RateLimiter::client_key(&req)
            );

            match limiter.hit(&key, limit).await {
                Ok(_) => service.call(req).await.map(|r| r.map_into_left_body()),
                Err(()) => {
                    let (http_req, _) = req.into_parts();
                    let res = HttpResponse::TooManyRequests()
                        .insert_header(("Retry-After", "60"))
                        .json(serde_json::json!({
                            "error": "rate_limited",
                            "message": "Too many requests. Try again in a minute."
                        }));
                    Ok(ServiceResponse::new(http_req, res).map_into_right_body())
                }
            }
        })
    }
}
