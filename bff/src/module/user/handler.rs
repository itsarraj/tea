use actix_web::{web, HttpResponse};
use std::sync::Arc;

use crate::error::AppResult;
use crate::middleware::AuthenticatedUser;
use crate::module::user::model::ChangePasswordRequest;
use crate::module::user::service::UserService;

pub async fn me(
    svc: web::Data<Arc<UserService>>,
    user: AuthenticatedUser,
) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(svc.me(user.user_id).await?))
}

pub async fn change_password(
    svc: web::Data<Arc<UserService>>,
    user: AuthenticatedUser,
    body: web::Json<ChangePasswordRequest>,
) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(svc.change_password(user.user_id, body.into_inner()).await?))
}
