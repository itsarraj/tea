use uuid::Uuid;

use crate::error::{AppError, AppResult};
use crate::module::auth::model::{MessageResponse, UserRow};
use crate::module::user::model::*;
use crate::DbPool;

pub struct UserService {
    pool: DbPool,
}

impl UserService {
    pub fn new(pool: DbPool) -> Self {
        Self { pool }
    }

    pub async fn me(&self, user_id: Uuid) -> AppResult<MeResponse> {
        let row = sqlx::query_as::<_, UserRow>(
            r#"
            SELECT id, email, password_hash, name, email_verified, google_sub, created_at
            FROM auth.users WHERE id = $1
            "#,
        )
        .bind(user_id)
        .fetch_optional(&self.pool)
        .await?
        .ok_or_else(|| AppError::not_found("User not found"))?;

        Ok(MeResponse {
            id: row.id,
            email: row.email,
            name: row.name,
            email_verified: row.email_verified,
            created_at: row.created_at,
        })
    }

    pub async fn change_password(
        &self,
        user_id: Uuid,
        req: ChangePasswordRequest,
    ) -> AppResult<MessageResponse> {
        if req.new_password.len() < 8 {
            return Err(AppError::bad_request(
                "Password must be at least 8 characters",
            ));
        }
        let row = sqlx::query_as::<_, UserRow>(
            r#"
            SELECT id, email, password_hash, name, email_verified, google_sub, created_at
            FROM auth.users WHERE id = $1
            "#,
        )
        .bind(user_id)
        .fetch_optional(&self.pool)
        .await?
        .ok_or_else(|| AppError::not_found("User not found"))?;

        let Some(hash) = row.password_hash.as_ref() else {
            return Err(AppError::bad_request(
                "This account uses Google sign-in only",
            ));
        };
        if !bcrypt::verify(&req.current_password, hash)? {
            return Err(AppError::unauthorized("Current password is wrong"));
        }
        let new_hash = bcrypt::hash(&req.new_password, 10)?;
        sqlx::query(
            r#"
            UPDATE auth.users SET password_hash = $1, updated_at = NOW() WHERE id = $2
            "#,
        )
        .bind(&new_hash)
        .bind(user_id)
        .execute(&self.pool)
        .await?;

        Ok(MessageResponse {
            ok: true,
            message: "Password changed".into(),
        })
    }
}
