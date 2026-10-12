use actix_web::{web, HttpResponse};
use serde::Deserialize;
use std::sync::Arc;

use crate::error::AppResult;
use crate::middleware::AuthenticatedUser;
use crate::module::auth::model::*;
use crate::module::auth::service::AuthService;

fn is_web_redirect(redirect_to: &str) -> bool {
    redirect_to.starts_with("http://") || redirect_to.starts_with("https://")
}

fn build_oauth_redirect(
    redirect_to: &str,
    login: &AuthTokensResponse,
    embed_tokens: bool,
) -> String {
    if !embed_tokens {
        return format!("{redirect_to}?auth=success");
    }
    let user_json = serde_json::to_string(&login.user).unwrap_or_default();
    let encoded_user = urlencoding::encode(&user_json);
    format!(
        "{redirect_to}?access_token={}&refresh_token={}&expires_in={}&user={encoded_user}",
        urlencoding::encode(&login.access_token),
        urlencoding::encode(&login.refresh_token),
        login.expires_in,
    )
}

fn oauth_error_redirect(redirect_to: &str, message: &str) -> String {
    let use_fragment = is_web_redirect(redirect_to);
    let encoded = urlencoding::encode(message);
    if use_fragment {
        format!("{redirect_to}#error={encoded}")
    } else {
        format!("{redirect_to}?error={encoded}")
    }
}

pub async fn register(
    svc: web::Data<Arc<AuthService>>,
    body: web::Json<RegisterRequest>,
) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(svc.register(body.into_inner()).await?))
}

pub async fn login(
    svc: web::Data<Arc<AuthService>>,
    body: web::Json<LoginRequest>,
) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(svc.login(body.into_inner()).await?))
}

pub async fn refresh(
    svc: web::Data<Arc<AuthService>>,
    body: web::Json<RefreshRequest>,
) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(svc.refresh(&body.refresh_token).await?))
}

#[derive(Debug, Deserialize)]
pub struct LogoutBody {
    pub refresh_token: Option<String>,
}

pub async fn logout(
    svc: web::Data<Arc<AuthService>>,
    user: AuthenticatedUser,
    body: Option<web::Json<LogoutBody>>,
) -> AppResult<HttpResponse> {
    let rt = body.and_then(|b| b.refresh_token.clone());
    Ok(HttpResponse::Ok().json(svc.logout(&user.jti, rt.as_deref()).await?))
}

pub async fn request_password_reset(
    svc: web::Data<Arc<AuthService>>,
    body: web::Json<PasswordResetRequest>,
) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(svc.request_password_reset(&body.email).await?))
}

pub async fn confirm_password_reset(
    svc: web::Data<Arc<AuthService>>,
    body: web::Json<PasswordResetConfirmRequest>,
) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(
        svc.confirm_password_reset(&body.token, &body.new_password)
            .await?,
    ))
}

pub async fn verify_email_post(
    svc: web::Data<Arc<AuthService>>,
    body: web::Json<VerifyEmailRequest>,
) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(svc.verify_email_token(&body.token).await?))
}

pub async fn verify_email_get(
    svc: web::Data<Arc<AuthService>>,
    path: web::Path<String>,
) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(svc.verify_email_token(&path.into_inner()).await?))
}

pub async fn google_token(
    svc: web::Data<Arc<AuthService>>,
    body: web::Json<GoogleTokenRequest>,
) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(svc.google_id_token_login(&body.id_token).await?))
}

pub async fn phone_start(
    svc: web::Data<Arc<AuthService>>,
    body: web::Json<PhoneStartRequest>,
) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(svc.phone_start(&body.phone).await?))
}

pub async fn phone_verify(
    svc: web::Data<Arc<AuthService>>,
    body: web::Json<PhoneVerifyRequest>,
) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(svc.phone_verify(&body.phone, &body.code).await?))
}

/// GET /api/v1/auth/google — start Google OAuth (BFF redirects to Google)
pub async fn google_start(
    svc: web::Data<Arc<AuthService>>,
    query: web::Query<std::collections::HashMap<String, String>>,
) -> HttpResponse {
    let redirect_to = match query.get("redirect_to") {
        Some(v) if !v.trim().is_empty() => v.clone(),
        _ => {
            return HttpResponse::BadRequest().json(serde_json::json!({
                "error": "bad_request",
                "message": "redirect_to query parameter is required",
            }));
        }
    };

    match svc.google_authorization_url(&redirect_to) {
        Ok(url) => HttpResponse::Found()
            .append_header(("Location", url))
            .finish(),
        Err(e) => {
            let msg = e.to_string();
            HttpResponse::ServiceUnavailable().json(serde_json::json!({
                "error": "oauth_not_configured",
                "message": msg,
            }))
        }
    }
}

/// GET /api/v1/auth/google/callback — Google redirects here; BFF issues JWT and redirects client
pub async fn google_callback(
    svc: web::Data<Arc<AuthService>>,
    query: web::Query<std::collections::HashMap<String, String>>,
) -> HttpResponse {
    if let Some(error) = query.get("error") {
        let description = query
            .get("error_description")
            .map(|s| s.as_str())
            .unwrap_or(error);
        return HttpResponse::BadRequest().json(serde_json::json!({
            "error": "google_auth_denied",
            "message": description,
        }));
    }

    let code = match query.get("code") {
        Some(v) if !v.trim().is_empty() => v.clone(),
        _ => {
            return HttpResponse::BadRequest().json(serde_json::json!({
                "error": "bad_request",
                "message": "Authorization code is missing",
            }));
        }
    };

    let state = match query.get("state") {
        Some(v) if !v.trim().is_empty() => v.clone(),
        _ => {
            return HttpResponse::BadRequest().json(serde_json::json!({
                "error": "bad_request",
                "message": "OAuth state is missing",
            }));
        }
    };

    match svc.google_oauth_callback(&code, &state).await {
        Ok((login, redirect_to)) => {
            let web_flow = is_web_redirect(&redirect_to);
            let location = build_oauth_redirect(&redirect_to, &login, !web_flow);
            HttpResponse::Found()
                .append_header(("Location", location))
                .finish()
        }
        Err(_) => {
            if let Ok(redirect_to) = svc.decode_google_oauth_state(&state) {
                HttpResponse::Found()
                    .append_header((
                        "Location",
                        oauth_error_redirect(&redirect_to, "Google sign-in failed"),
                    ))
                    .finish()
            } else {
                HttpResponse::BadRequest().json(serde_json::json!({
                    "error": "google_auth_failed",
                    "message": "Google sign-in failed",
                }))
            }
        }
    }
}
