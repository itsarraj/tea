use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};
use uuid::Uuid;

#[derive(Debug, Deserialize)]
pub struct RegisterRequest {
    pub name: String,
    pub email: String,
    pub password: String,
    /// YYYY-MM-DD — required for dating (18+)
    pub birthday: Option<String>,
    pub phone: Option<String>,
    pub turnstile_token: Option<String>,
}

#[derive(Debug, Deserialize)]
pub struct LoginRequest {
    pub email: String,
    pub password: String,
    pub turnstile_token: Option<String>,
}

#[derive(Debug, Deserialize)]
pub struct RefreshRequest {
    pub refresh_token: String,
}

#[derive(Debug, Deserialize)]
pub struct PasswordResetRequest {
    pub email: String,
}

#[derive(Debug, Deserialize)]
pub struct PasswordResetConfirmRequest {
    pub token: String,
    pub new_password: String,
}

#[derive(Debug, Deserialize)]
pub struct VerifyEmailRequest {
    pub token: String,
}

#[derive(Debug, Deserialize)]
pub struct GoogleTokenRequest {
    pub id_token: String,
}

#[derive(Debug, Deserialize)]
pub struct PhoneStartRequest {
    pub phone: String,
}

#[derive(Debug, Deserialize)]
pub struct PhoneVerifyRequest {
    pub phone: String,
    pub code: String,
}

#[derive(Debug, Serialize)]
pub struct AuthTokensResponse {
    pub access_token: String,
    pub refresh_token: String,
    pub expires_in: i64,
    pub user: UserPublic,
}

#[derive(Debug, Clone, Serialize)]
pub struct UserPublic {
    pub id: Uuid,
    pub email: String,
    pub name: String,
    pub email_verified: bool,
    pub created_at: DateTime<Utc>,
}

#[derive(Debug, Clone, sqlx::FromRow)]
pub struct UserRow {
    pub id: Uuid,
    pub email: String,
    pub password_hash: Option<String>,
    pub name: String,
    pub email_verified: bool,
    pub google_sub: Option<String>,
    pub created_at: DateTime<Utc>,
}

impl From<UserRow> for UserPublic {
    fn from(u: UserRow) -> Self {
        Self {
            id: u.id,
            email: u.email,
            name: u.name,
            email_verified: u.email_verified,
            created_at: u.created_at,
        }
    }
}

#[derive(Debug, Serialize)]
pub struct MessageResponse {
    pub ok: bool,
    pub message: String,
}
