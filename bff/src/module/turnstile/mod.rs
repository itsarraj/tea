use std::sync::Arc;

use crate::configuration::Settings;
use crate::error::{AppError, AppResult};

pub struct TurnstileService {
    settings: Arc<Settings>,
}

impl TurnstileService {
    pub fn new(settings: Arc<Settings>) -> Self {
        Self { settings }
    }

    /// No-op when turnstile.secret_key is unset (local default).
    pub async fn verify(&self, token: Option<&str>) -> AppResult<()> {
        if !self.settings.turnstile.is_enabled() {
            return Ok(());
        }
        let token = token
            .filter(|t| !t.is_empty())
            .ok_or_else(|| AppError::bad_request("turnstile_token required"))?;

        let secret = self.settings.turnstile.secret_key.as_ref().unwrap();
        let client = reqwest::Client::new();
        let resp: serde_json::Value = client
            .post("https://challenges.cloudflare.com/turnstile/v0/siteverify")
            .form(&[("secret", secret.as_str()), ("response", token)])
            .send()
            .await
            .map_err(|e| AppError::internal(e.to_string()))?
            .json()
            .await
            .map_err(|e| AppError::internal(e.to_string()))?;

        let ok = resp
            .get("success")
            .and_then(|v| v.as_bool())
            .unwrap_or(false);
        if !ok {
            return Err(AppError::bad_request("Turnstile verification failed"));
        }

        if let Some(allowed) = self.settings.turnstile.hostnames.as_ref() {
            if let Some(hostname) = resp.get("hostname").and_then(|v| v.as_str()) {
                let ok_host = allowed
                    .split(',')
                    .map(str::trim)
                    .any(|h| h.eq_ignore_ascii_case(hostname));
                if !ok_host {
                    return Err(AppError::bad_request("Turnstile hostname not allowed"));
                }
            }
        }
        Ok(())
    }
}
