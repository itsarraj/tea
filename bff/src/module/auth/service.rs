use chrono::{Duration, Utc};
use jsonwebtoken::{encode, EncodingKey, Header};
use rand::{distributions::Alphanumeric, Rng};
use sha2::{Digest, Sha256};
use std::sync::Arc;
use uuid::Uuid;

use crate::configuration::Settings;
use crate::error::{AppError, AppResult};
use crate::middleware::auth::Claims;
use crate::middleware::Blacklist;
use crate::module::auth::google::{GoogleOAuthClient, GoogleUserInfo};
use crate::module::auth::model::*;
use crate::module::email::EmailService;
use crate::module::sms::SmsService;
use crate::module::turnstile::TurnstileService;
use crate::{DbPool, OptionalRedis};

pub struct AuthService {
    pool: DbPool,
    redis: OptionalRedis,
    settings: Arc<Settings>,
    email: Arc<EmailService>,
    turnstile: Arc<TurnstileService>,
    sms: Arc<SmsService>,
    google_oauth: Option<GoogleOAuthClient>,
}

impl AuthService {
    pub fn new(
        pool: DbPool,
        redis: OptionalRedis,
        settings: Arc<Settings>,
        email: Arc<EmailService>,
        turnstile: Arc<TurnstileService>,
        sms: Arc<SmsService>,
        google_oauth: Option<GoogleOAuthClient>,
    ) -> Self {
        Self {
            pool,
            redis,
            settings,
            email,
            turnstile,
            sms,
            google_oauth,
        }
    }

    fn google_client(&self) -> AppResult<&GoogleOAuthClient> {
        self.google_oauth
            .as_ref()
            .ok_or_else(|| AppError::bad_request("Google OAuth is not configured"))
    }

    pub fn google_authorization_url(&self, redirect_to: &str) -> AppResult<String> {
        let client = self.google_client()?;
        let state = client.encode_state(redirect_to);
        Ok(client.authorization_url(&state))
    }

    pub fn decode_google_oauth_state(&self, state: &str) -> AppResult<String> {
        self.google_client()?
            .decode_state(state)
            .map_err(|_| AppError::unauthorized("Invalid OAuth state"))
    }

    pub async fn google_oauth_callback(
        &self,
        code: &str,
        state: &str,
    ) -> AppResult<(AuthTokensResponse, String)> {
        let client = self.google_client()?;
        let redirect_to = client
            .decode_state(state)
            .map_err(|_| AppError::unauthorized("Invalid OAuth state"))?;
        let google_user = client.exchange_code(code).await.map_err(|e| {
            log::warn!("Google code exchange failed: {e}");
            AppError::unauthorized("Google sign-in failed")
        })?;
        let tokens = self.find_or_create_google_user(&google_user).await?;
        Ok((tokens, redirect_to))
    }

    pub async fn register(&self, req: RegisterRequest) -> AppResult<AuthTokensResponse> {
        self.turnstile
            .verify(req.turnstile_token.as_deref())
            .await?;

        let email = req.email.trim().to_lowercase();
        let name = req.name.trim().to_string();
        if email.is_empty() || name.is_empty() || req.password.len() < 8 {
            return Err(AppError::bad_request(
                "name, email, and password (min 8) required",
            ));
        }

        let birthday = match req
            .birthday
            .as_deref()
            .map(str::trim)
            .filter(|s| !s.is_empty())
        {
            Some(s) => {
                let d = chrono::NaiveDate::parse_from_str(s, "%Y-%m-%d")
                    .map_err(|_| AppError::bad_request("birthday must be YYYY-MM-DD"))?;
                let age = Utc::now().date_naive().years_since(d).unwrap_or(0);
                if age < 18 {
                    return Err(AppError::bad_request("You must be 18 or older"));
                }
                Some(d)
            }
            None => None,
        };
        let phone = req
            .phone
            .as_deref()
            .map(str::trim)
            .filter(|s| !s.is_empty())
            .map(str::to_string);

        let hash = bcrypt::hash(&req.password, 10)?;
        let verify_token = random_token();
        let verify_expires = Utc::now() + Duration::days(2);

        let row = sqlx::query_as::<_, UserRow>(
            r#"
            INSERT INTO auth.users (
                email, password_hash, name, email_verified,
                email_verify_token, email_verify_expires_at, birthday, phone
            )
            VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
            RETURNING id, email, password_hash, name, email_verified, google_sub, created_at
            "#,
        )
        .bind(&email)
        .bind(&hash)
        .bind(&name)
        .bind(!self.settings.auth.require_email_verification)
        .bind(&verify_token)
        .bind(verify_expires)
        .bind(birthday)
        .bind(phone)
        .fetch_one(&self.pool)
        .await
        .map_err(|e| match e {
            sqlx::Error::Database(db) if db.constraint().is_some_and(|c| c.contains("email")) => {
                AppError::conflict("Email already registered")
            }
            other => other.into(),
        })?;

        let link = format!(
            "{}/api/v1/auth/verify-email/{}",
            self.settings.email.base_url.trim_end_matches('/'),
            verify_token
        );
        self.email
            .send_verify_email(&email, &name, &link)
            .await
            .ok();

        if self.settings.auth.require_email_verification {
            return Err(AppError::forbidden(
                "Check your email to activate your account",
            ));
        }

        self.issue_tokens(row).await
    }

    pub async fn login(&self, req: LoginRequest) -> AppResult<AuthTokensResponse> {
        self.turnstile
            .verify(req.turnstile_token.as_deref())
            .await?;

        let email = req.email.trim().to_lowercase();
        let row = sqlx::query_as::<_, UserRow>(
            r#"
            SELECT id, email, password_hash, name, email_verified, google_sub, created_at
            FROM auth.users WHERE email = $1
            "#,
        )
        .bind(&email)
        .fetch_optional(&self.pool)
        .await?
        .ok_or_else(|| AppError::unauthorized("Invalid email or password"))?;

        let Some(hash) = row.password_hash.as_ref() else {
            return Err(AppError::unauthorized(
                "Use Google sign-in for this account",
            ));
        };
        if !bcrypt::verify(&req.password, hash)? {
            return Err(AppError::unauthorized("Invalid email or password"));
        }
        if self.settings.auth.require_email_verification && !row.email_verified {
            return Err(AppError::forbidden("Email not verified"));
        }

        self.issue_tokens(row).await
    }

    pub async fn refresh(&self, refresh_token: &str) -> AppResult<AuthTokensResponse> {
        let hash = hash_token(refresh_token);
        let user_id: Option<Uuid> = sqlx::query_scalar(
            r#"
            SELECT user_id FROM auth.refresh_tokens
            WHERE token_hash = $1 AND expires_at > NOW()
            "#,
        )
        .bind(&hash)
        .fetch_optional(&self.pool)
        .await?;

        let user_id = user_id.ok_or_else(|| AppError::unauthorized("Invalid refresh token"))?;

        sqlx::query("DELETE FROM auth.refresh_tokens WHERE token_hash = $1")
            .bind(&hash)
            .execute(&self.pool)
            .await?;

        let row = sqlx::query_as::<_, UserRow>(
            r#"
            SELECT id, email, password_hash, name, email_verified, google_sub, created_at
            FROM auth.users WHERE id = $1
            "#,
        )
        .bind(user_id)
        .fetch_one(&self.pool)
        .await?;

        self.issue_tokens(row).await
    }

    pub async fn logout(
        &self,
        jti: &str,
        refresh_token: Option<&str>,
    ) -> AppResult<MessageResponse> {
        let ttl = self.settings.jwt.access_token_expiration_hours * 3600;
        Blacklist::revoke(&self.pool, &self.redis, jti, ttl).await?;

        if let Some(rt) = refresh_token {
            let hash = hash_token(rt);
            sqlx::query("DELETE FROM auth.refresh_tokens WHERE token_hash = $1")
                .bind(&hash)
                .execute(&self.pool)
                .await?;
        }

        Ok(MessageResponse {
            ok: true,
            message: "Logged out".into(),
        })
    }

    pub async fn request_password_reset(&self, email: &str) -> AppResult<MessageResponse> {
        let email = email.trim().to_lowercase();
        let row = sqlx::query_as::<_, UserRow>(
            r#"
            SELECT id, email, password_hash, name, email_verified, google_sub, created_at
            FROM auth.users WHERE email = $1
            "#,
        )
        .bind(&email)
        .fetch_optional(&self.pool)
        .await?;

        if let Some(user) = row {
            let token = random_token();
            let exp = Utc::now() + Duration::hours(2);
            sqlx::query(
                r#"
                UPDATE auth.users
                SET password_reset_token = $1, password_reset_expires_at = $2, updated_at = NOW()
                WHERE id = $3
                "#,
            )
            .bind(&token)
            .bind(exp)
            .bind(user.id)
            .execute(&self.pool)
            .await?;

            let frontend = self
                .settings
                .email
                .frontend_base_url
                .clone()
                .unwrap_or_else(|| self.settings.email.base_url.clone());
            let link = format!(
                "{}/reset-password?token={}",
                frontend.trim_end_matches('/'),
                token
            );
            self.email
                .send_password_reset(&user.email, &user.name, &link)
                .await
                .ok();
        }

        Ok(MessageResponse {
            ok: true,
            message: "If that email exists, a reset link was sent".into(),
        })
    }

    pub async fn confirm_password_reset(
        &self,
        token: &str,
        new_password: &str,
    ) -> AppResult<MessageResponse> {
        if new_password.len() < 8 {
            return Err(AppError::bad_request(
                "Password must be at least 8 characters",
            ));
        }
        let hash = bcrypt::hash(new_password, 10)?;
        let updated = sqlx::query(
            r#"
            UPDATE auth.users
            SET password_hash = $1,
                password_reset_token = NULL,
                password_reset_expires_at = NULL,
                updated_at = NOW()
            WHERE password_reset_token = $2
              AND password_reset_expires_at > NOW()
            "#,
        )
        .bind(&hash)
        .bind(token)
        .execute(&self.pool)
        .await?
        .rows_affected();

        if updated == 0 {
            return Err(AppError::bad_request("Invalid or expired reset token"));
        }
        Ok(MessageResponse {
            ok: true,
            message: "Password updated".into(),
        })
    }

    pub async fn verify_email_token(&self, token: &str) -> AppResult<MessageResponse> {
        let updated = sqlx::query(
            r#"
            UPDATE auth.users
            SET email_verified = TRUE,
                email_verify_token = NULL,
                email_verify_expires_at = NULL,
                updated_at = NOW()
            WHERE email_verify_token = $1
              AND email_verify_expires_at > NOW()
            "#,
        )
        .bind(token)
        .execute(&self.pool)
        .await?
        .rows_affected();

        if updated == 0 {
            return Err(AppError::bad_request(
                "Invalid or expired verification token",
            ));
        }
        Ok(MessageResponse {
            ok: true,
            message: "Email verified".into(),
        })
    }

    pub async fn google_id_token_login(&self, id_token: &str) -> AppResult<AuthTokensResponse> {
        let client = self.google_client()?;
        let google_user = client.verify_id_token(id_token).await.map_err(|e| {
            log::warn!("Google ID token verification failed: {e}");
            AppError::unauthorized("Invalid Google token")
        })?;
        self.find_or_create_google_user(&google_user).await
    }

    async fn find_or_create_google_user(
        &self,
        google_user: &GoogleUserInfo,
    ) -> AppResult<AuthTokensResponse> {
        let email = google_user.email.trim().to_lowercase();
        let existing = sqlx::query_as::<_, UserRow>(
            r#"
            SELECT id, email, password_hash, name, email_verified, google_sub, created_at
            FROM auth.users
            WHERE google_sub = $1 OR email = $2
            LIMIT 1
            "#,
        )
        .bind(&google_user.sub)
        .bind(&email)
        .fetch_optional(&self.pool)
        .await?;

        let row = if let Some(user) = existing {
            sqlx::query(
                r#"
                UPDATE auth.users
                SET google_sub = COALESCE(google_sub, $1),
                    email_verified = email_verified OR $2,
                    updated_at = NOW()
                WHERE id = $3
                "#,
            )
            .bind(&google_user.sub)
            .bind(google_user.email_verified)
            .bind(user.id)
            .execute(&self.pool)
            .await?;

            sqlx::query_as::<_, UserRow>(
                r#"
                SELECT id, email, password_hash, name, email_verified, google_sub, created_at
                FROM auth.users WHERE id = $1
                "#,
            )
            .bind(user.id)
            .fetch_one(&self.pool)
            .await?
        } else {
            sqlx::query_as::<_, UserRow>(
                r#"
                INSERT INTO auth.users (email, password_hash, name, email_verified, google_sub)
                VALUES ($1, NULL, $2, $3, $4)
                RETURNING id, email, password_hash, name, email_verified, google_sub, created_at
                "#,
            )
            .bind(&email)
            .bind(&google_user.name)
            .bind(google_user.email_verified)
            .bind(&google_user.sub)
            .fetch_one(&self.pool)
            .await?
        };

        self.issue_tokens(row).await
    }

    /// Phone OTP start. Code is delivered by `SmsService` (dev provider logs it
    /// and always uses 123456). Resend is throttled to once per 30 seconds.
    pub async fn phone_start(&self, phone: &str) -> AppResult<MessageResponse> {
        let phone = normalize_phone(phone)?;

        let recent: bool = sqlx::query_scalar(
            r#"SELECT EXISTS(SELECT 1 FROM dating.phone_otps
                             WHERE phone = $1 AND created_at > NOW() - interval '30 seconds')"#,
        )
        .bind(&phone)
        .fetch_one(&self.pool)
        .await?;
        if recent {
            return Err(AppError::bad_request(
                "Please wait 30 seconds before requesting a new code",
            ));
        }

        let code = self.sms.generate_code();
        let code_hash = hash_token(&code);
        let expires = Utc::now() + Duration::minutes(10);
        sqlx::query(
            r#"
            INSERT INTO dating.phone_otps (phone, code_hash, expires_at, attempts, created_at)
            VALUES ($1, $2, $3, 0, NOW())
            ON CONFLICT (phone) DO UPDATE
              SET code_hash = EXCLUDED.code_hash,
                  expires_at = EXCLUDED.expires_at,
                  attempts = 0,
                  created_at = NOW()
            "#,
        )
        .bind(&phone)
        .bind(&code_hash)
        .bind(expires)
        .execute(&self.pool)
        .await?;

        self.sms.send_otp(&phone, &code).await?;

        Ok(MessageResponse {
            ok: true,
            message: if self.sms.is_dev() {
                "OTP sent (dev code 123456)".into()
            } else {
                "OTP sent".into()
            },
        })
    }

    pub async fn phone_verify(&self, phone: &str, code: &str) -> AppResult<AuthTokensResponse> {
        let phone = normalize_phone(phone)?;
        let code = code.trim();
        if code.is_empty() {
            return Err(AppError::bad_request("Code required"));
        }

        let row = sqlx::query_as::<_, (String, i32, chrono::DateTime<Utc>)>(
            r#"SELECT code_hash, attempts, expires_at FROM dating.phone_otps WHERE phone = $1"#,
        )
        .bind(&phone)
        .fetch_optional(&self.pool)
        .await?
        .ok_or_else(|| AppError::unauthorized("No OTP for this phone — request a new code"))?;

        let (code_hash, attempts, expires_at) = row;
        if attempts >= 5 {
            return Err(AppError::unauthorized(
                "Too many attempts — request a new code",
            ));
        }
        if expires_at < Utc::now() {
            return Err(AppError::unauthorized("OTP expired — request a new code"));
        }
        if hash_token(code) != code_hash {
            sqlx::query(r#"UPDATE dating.phone_otps SET attempts = attempts + 1 WHERE phone = $1"#)
                .bind(&phone)
                .execute(&self.pool)
                .await?;
            return Err(AppError::unauthorized("Invalid code"));
        }

        sqlx::query(r#"DELETE FROM dating.phone_otps WHERE phone = $1"#)
            .bind(&phone)
            .execute(&self.pool)
            .await?;

        let existing = sqlx::query_as::<_, UserRow>(
            r#"
            SELECT id, email, password_hash, name, email_verified, google_sub, created_at
            FROM auth.users WHERE phone = $1
            "#,
        )
        .bind(&phone)
        .fetch_optional(&self.pool)
        .await?;

        let user = if let Some(u) = existing {
            sqlx::query(r#"UPDATE auth.users SET phone_verified = TRUE WHERE id = $1"#)
                .bind(u.id)
                .execute(&self.pool)
                .await?;
            u
        } else {
            let email = format!(
                "phone_{}@teadating.local",
                phone
                    .chars()
                    .filter(|c| c.is_ascii_digit())
                    .collect::<String>()
            );
            let name = format!("User {}", &phone[phone.len().saturating_sub(4)..]);
            sqlx::query_as::<_, UserRow>(
                r#"
                INSERT INTO auth.users (email, password_hash, name, email_verified, phone, phone_verified)
                VALUES ($1, NULL, $2, TRUE, $3, TRUE)
                RETURNING id, email, password_hash, name, email_verified, google_sub, created_at
                "#,
            )
            .bind(&email)
            .bind(&name)
            .bind(&phone)
            .fetch_one(&self.pool)
            .await?
        };

        self.issue_tokens(user).await
    }

    /// Every signup path gets a dating profile row immediately so onboarding
    /// and discover never hit a missing-profile edge.
    async fn create_profile(&self, user_id: Uuid) -> AppResult<()> {
        sqlx::query(
            r#"
            INSERT INTO dating.profiles (user_id, display_name, birthday)
            SELECT u.id, u.name, u.birthday FROM auth.users u WHERE u.id = $1
            ON CONFLICT (user_id) DO NOTHING
            "#,
        )
        .bind(user_id)
        .execute(&self.pool)
        .await?;
        Ok(())
    }

    async fn issue_tokens(&self, user: UserRow) -> AppResult<AuthTokensResponse> {
        self.create_profile(user.id).await?;
        let now = Utc::now();
        let exp = now + Duration::hours(self.settings.jwt.access_token_expiration_hours);
        let jti = Uuid::new_v4().to_string();
        let claims = Claims {
            sub: user.id.to_string(),
            email: user.email.clone(),
            jti,
            exp: exp.timestamp() as usize,
            iat: now.timestamp() as usize,
        };
        let access_token = encode(
            &Header::default(),
            &claims,
            &EncodingKey::from_secret(self.settings.jwt.secret.as_bytes()),
        )?;

        let refresh_token = random_token();
        let refresh_hash = hash_token(&refresh_token);
        let refresh_exp = now + Duration::days(self.settings.jwt.refresh_token_expiration_days);
        sqlx::query(
            r#"
            INSERT INTO auth.refresh_tokens (user_id, token_hash, expires_at)
            VALUES ($1, $2, $3)
            "#,
        )
        .bind(user.id)
        .bind(&refresh_hash)
        .bind(refresh_exp)
        .execute(&self.pool)
        .await?;

        Ok(AuthTokensResponse {
            access_token,
            refresh_token,
            expires_in: self.settings.jwt.access_token_expiration_hours * 3600,
            user: user.into(),
        })
    }
}

fn random_token() -> String {
    rand::thread_rng()
        .sample_iter(&Alphanumeric)
        .take(48)
        .map(char::from)
        .collect()
}

fn hash_token(token: &str) -> String {
    let mut hasher = Sha256::new();
    hasher.update(token.as_bytes());
    hex::encode(hasher.finalize())
}

/// E.164-ish normalisation: keep a single leading `+`, digits only after it.
/// Bare 10-digit numbers are assumed Indian (+91) — the app's default region.
fn normalize_phone(phone: &str) -> AppResult<String> {
    let trimmed = phone.trim();
    let has_plus = trimmed.starts_with('+');
    let digits: String = trimmed.chars().filter(|c| c.is_ascii_digit()).collect();
    if digits.len() < 8 || digits.len() > 15 {
        return Err(AppError::bad_request("Enter a valid phone number"));
    }
    // Bare 10-digit numbers are Indian mobiles; anything else already carries a country code.
    let normalized = if !has_plus && digits.len() == 10 {
        format!("+91{digits}")
    } else {
        format!("+{digits}")
    };
    Ok(normalized)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn normalizes_indian_numbers() {
        assert_eq!(normalize_phone("98765 43210").unwrap(), "+919876543210");
        assert_eq!(normalize_phone("+91 98765-43210").unwrap(), "+919876543210");
        assert_eq!(normalize_phone("919876543210").unwrap(), "+919876543210");
        assert_eq!(
            normalize_phone("+1 (415) 555-2671").unwrap(),
            "+14155552671"
        );
        assert!(normalize_phone("12345").is_err());
    }

    #[test]
    fn token_hash_is_stable() {
        assert_eq!(hash_token("abc"), hash_token("abc"));
        assert_ne!(hash_token("abc"), hash_token("abd"));
        assert_eq!(random_token().len(), 48);
    }
}
