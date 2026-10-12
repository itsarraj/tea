use actix_web::{web, HttpResponse};

use crate::error::AppResult;
use crate::module::health::service::check;
use crate::{DbPool, OptionalRedis};

pub async fn health_status(
    pool: web::Data<DbPool>,
    redis: web::Data<OptionalRedis>,
) -> AppResult<HttpResponse> {
    let report = check(pool.get_ref(), redis.get_ref()).await;
    let mut status = if report.status == "unhealthy" {
        HttpResponse::ServiceUnavailable()
    } else {
        HttpResponse::Ok()
    };
    Ok(status.json(report))
}
