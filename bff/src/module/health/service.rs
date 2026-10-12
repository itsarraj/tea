use chrono::Utc;

use crate::module::health::model::*;
use crate::{DbPool, OptionalRedis};

pub async fn check(pool: &DbPool, redis: &OptionalRedis) -> HealthResponse {
    let mut components = Vec::new();
    let mut overall = "healthy";

    match sqlx::query_scalar::<_, i32>("SELECT 1")
        .fetch_one(pool)
        .await
    {
        Ok(_) => components.push(ComponentHealth {
            name: "database".into(),
            status: "healthy".into(),
            message: None,
        }),
        Err(e) => {
            overall = "unhealthy";
            components.push(ComponentHealth {
                name: "database".into(),
                status: "unhealthy".into(),
                message: Some(e.to_string()),
            });
        }
    }

    match redis {
        Some(r) => {
            let mut conn = r.clone();
            match redis::cmd("PING").query_async::<String>(&mut conn).await {
                Ok(_) => components.push(ComponentHealth {
                    name: "redis".into(),
                    status: "healthy".into(),
                    message: None,
                }),
                Err(e) => {
                    if overall == "healthy" {
                        overall = "degraded";
                    }
                    components.push(ComponentHealth {
                        name: "redis".into(),
                        status: "degraded".into(),
                        message: Some(e.to_string()),
                    });
                }
            }
        }
        None => components.push(ComponentHealth {
            name: "redis".into(),
            status: "degraded".into(),
            message: Some("not connected".into()),
        }),
    }

    HealthResponse {
        status: overall.into(),
        timestamp: Utc::now(),
        version: env!("CARGO_PKG_VERSION").into(),
        components,
    }
}
