//! Transactional email via Resend. Falls back to logging when `email.api_key`
//! is empty so local dev never needs credentials.

use std::sync::Arc;

use crate::configuration::Settings;
use crate::error::{AppError, AppResult};

pub struct EmailService {
    settings: Arc<Settings>,
    http: reqwest::Client,
}

impl EmailService {
    pub fn new(settings: Arc<Settings>) -> Self {
        Self {
            settings,
            http: reqwest::Client::new(),
        }
    }

    fn app_name(&self) -> String {
        self.settings
            .legal
            .app_name
            .clone()
            .unwrap_or_else(|| self.settings.email.from_name.clone())
    }

    pub async fn send_verify_email(&self, to: &str, name: &str, link: &str) -> AppResult<()> {
        let app = self.app_name();
        let html = format!(
            r#"<p>Hi {name},</p><p>Confirm your email for {app}:</p>
<p><a href="{link}" style="background:#73BDA8;color:#020202;padding:12px 20px;border-radius:4px;border:2px solid #000000;font-weight:800;text-decoration:none;display:inline-block">Verify email</a></p>
<p>Or open: {link}</p><p>This link expires in 48 hours.</p>"#
        );
        self.dispatch(to, &format!("Verify your {app} email"), &html)
            .await
    }

    pub async fn send_password_reset(&self, to: &str, name: &str, link: &str) -> AppResult<()> {
        let app = self.app_name();
        let html = format!(
            r#"<p>Hi {name},</p><p>Reset your {app} password:</p>
<p><a href="{link}" style="background:#73BDA8;color:#020202;padding:12px 20px;border-radius:4px;border:2px solid #000000;font-weight:800;text-decoration:none;display:inline-block">Reset password</a></p>
<p>Or open: {link}</p><p>If you did not request this, ignore this email. The link expires in 2 hours.</p>"#
        );
        self.dispatch(to, &format!("Reset your {app} password"), &html)
            .await
    }

    async fn dispatch(&self, to: &str, subject: &str, html: &str) -> AppResult<()> {
        let key = self.settings.email.api_key.trim();
        if key.is_empty() {
            log::info!("[email:dev] to={to} subject={subject}\n{html}");
            return Ok(());
        }
        let from = format!(
            "{} <{}>",
            self.settings.email.from_name, self.settings.email.from_email
        );
        let res = self
            .http
            .post("https://api.resend.com/emails")
            .bearer_auth(key)
            .json(&serde_json::json!({
                "from": from,
                "to": [to],
                "subject": subject,
                "html": html,
            }))
            .send()
            .await
            .map_err(|e| AppError::internal(format!("resend: {e}")))?;
        if !res.status().is_success() {
            let body = res.text().await.unwrap_or_default();
            log::warn!("resend failed: {body}");
            return Err(AppError::internal("Could not send email"));
        }
        Ok(())
    }
}
