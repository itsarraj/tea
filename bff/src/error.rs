use actix_web::{http::StatusCode, HttpResponse, ResponseError};
use serde::Serialize;
use thiserror::Error;

#[derive(Debug, Error)]
pub enum AppError {
    #[error("{0}")]
    BadRequest(String),
    #[error("{0}")]
    Unauthorized(String),
    #[error("{0}")]
    Forbidden(String),
    #[error("{0}")]
    NotFound(String),
    #[error("{0}")]
    Conflict(String),
    #[error(transparent)]
    Sqlx(#[from] sqlx::Error),
    #[error(transparent)]
    Jwt(#[from] jsonwebtoken::errors::Error),
    #[error(transparent)]
    Bcrypt(#[from] bcrypt::BcryptError),
    #[error("{0}")]
    Internal(String),
}

impl AppError {
    pub fn bad_request(msg: impl Into<String>) -> Self {
        Self::BadRequest(msg.into())
    }
    pub fn unauthorized(msg: impl Into<String>) -> Self {
        Self::Unauthorized(msg.into())
    }
    pub fn forbidden(msg: impl Into<String>) -> Self {
        Self::Forbidden(msg.into())
    }
    pub fn not_found(msg: impl Into<String>) -> Self {
        Self::NotFound(msg.into())
    }
    pub fn conflict(msg: impl Into<String>) -> Self {
        Self::Conflict(msg.into())
    }
    pub fn internal(msg: impl Into<String>) -> Self {
        Self::Internal(msg.into())
    }
}

#[derive(Serialize)]
struct ErrorBody {
    error: String,
    message: String,
}

impl ResponseError for AppError {
    fn status_code(&self) -> StatusCode {
        match self {
            Self::BadRequest(_) => StatusCode::BAD_REQUEST,
            Self::Unauthorized(_) => StatusCode::UNAUTHORIZED,
            Self::Forbidden(_) => StatusCode::FORBIDDEN,
            Self::NotFound(_) => StatusCode::NOT_FOUND,
            Self::Conflict(_) => StatusCode::CONFLICT,
            Self::Sqlx(_) | Self::Jwt(_) | Self::Bcrypt(_) | Self::Internal(_) => {
                StatusCode::INTERNAL_SERVER_ERROR
            }
        }
    }

    fn error_response(&self) -> HttpResponse {
        let (error, message) = match self {
            Self::BadRequest(m) => ("bad_request", m.clone()),
            Self::Unauthorized(m) => ("unauthorized", m.clone()),
            Self::Forbidden(m) => ("forbidden", m.clone()),
            Self::NotFound(m) => ("not_found", m.clone()),
            Self::Conflict(m) => ("conflict", m.clone()),
            Self::Sqlx(e) => {
                log::error!("sqlx: {e}");
                ("internal", "Database error".into())
            }
            Self::Jwt(e) => {
                log::error!("jwt: {e}");
                ("unauthorized", "Invalid token".into())
            }
            Self::Bcrypt(e) => {
                log::error!("bcrypt: {e}");
                ("internal", "Hashing error".into())
            }
            Self::Internal(m) => {
                log::error!("internal: {m}");
                ("internal", m.clone())
            }
        };
        HttpResponse::build(self.status_code()).json(ErrorBody {
            error: error.into(),
            message,
        })
    }
}

pub type AppResult<T> = Result<T, AppError>;
