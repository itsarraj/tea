//! Expo push notifications. Tokens are registered by the app at
//! `POST /user/devices`; we fan out through Expo's push API.

use std::sync::Arc;
use uuid::Uuid;

use crate::configuration::Settings;
use crate::DbPool;

pub struct PushService {
    settings: Arc<Settings>,
    pool: DbPool,
    http: reqwest::Client,
}

impl PushService {
    pub fn new(settings: Arc<Settings>, pool: DbPool) -> Self {
        Self {
            settings,
            pool,
            http: reqwest::Client::new(),
        }
    }

    pub async fn register(
        &self,
        user_id: Uuid,
        token: &str,
        platform: Option<&str>,
    ) -> Result<(), sqlx::Error> {
        sqlx::query(
            r#"
            INSERT INTO dating.devices (expo_push_token, user_id, platform, updated_at)
            VALUES ($1, $2, $3, NOW())
            ON CONFLICT (expo_push_token) DO UPDATE
              SET user_id = EXCLUDED.user_id, platform = EXCLUDED.platform, updated_at = NOW()
            "#,
        )
        .bind(token)
        .bind(user_id)
        .bind(platform)
        .execute(&self.pool)
        .await?;
        Ok(())
    }

    pub async fn unregister(&self, token: &str) {
        let _ = sqlx::query("DELETE FROM dating.devices WHERE expo_push_token = $1")
            .bind(token)
            .execute(&self.pool)
            .await;
    }

    /// Fire-and-forget. Never fails the caller.
    pub fn notify(
        self: &Arc<Self>,
        user_id: Uuid,
        title: String,
        body: String,
        data: serde_json::Value,
    ) {
        if !self.settings.push.enabled {
            return;
        }
        let me = Arc::clone(self);
        actix_web::rt::spawn(async move {
            if let Err(e) = me.send(user_id, &title, &body, data).await {
                log::warn!("push to {user_id} failed: {e}");
            }
        });
    }

    async fn send(
        &self,
        user_id: Uuid,
        title: &str,
        body: &str,
        data: serde_json::Value,
    ) -> Result<(), String> {
        let tokens: Vec<String> =
            sqlx::query_scalar("SELECT expo_push_token FROM dating.devices WHERE user_id = $1")
                .bind(user_id)
                .fetch_all(&self.pool)
                .await
                .map_err(|e| e.to_string())?;
        if tokens.is_empty() {
            return Ok(());
        }
        let messages: Vec<serde_json::Value> = tokens
            .iter()
            .map(|t| {
                serde_json::json!({
                    "to": t,
                    "title": title,
                    "body": body,
                    "sound": "default",
                    "data": data,
                })
            })
            .collect();

        let mut req = self
            .http
            .post("https://exp.host/--/api/v2/push/send")
            .json(&messages);
        if let Some(tok) = &self.settings.push.expo_access_token {
            req = req.bearer_auth(tok);
        }
        let res = req.send().await.map_err(|e| e.to_string())?;
        if !res.status().is_success() {
            return Err(format!("expo push status {}", res.status()));
        }
        // Drop tokens Expo says are dead.
        if let Ok(v) = res.json::<serde_json::Value>().await {
            if let Some(arr) = v.get("data").and_then(|d| d.as_array()) {
                for (i, item) in arr.iter().enumerate() {
                    let err = item.pointer("/details/error").and_then(|e| e.as_str());
                    if err == Some("DeviceNotRegistered") {
                        if let Some(t) = tokens.get(i) {
                            self.unregister(t).await;
                        }
                    }
                }
            }
        }
        Ok(())
    }
}
