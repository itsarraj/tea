//! SMS OTP delivery. Provider chosen by `sms.provider`:
//!  - dev    : logs the code; OTP is always 123456 (default when unset)
//!  - msg91  : MSG91 OTP API (India)
//!  - twilio : Twilio Messages API

use std::sync::Arc;

use crate::configuration::Settings;
use crate::error::{AppError, AppResult};

pub struct SmsService {
    settings: Arc<Settings>,
    http: reqwest::Client,
}

pub const DEV_OTP: &str = "123456";

impl SmsService {
    pub fn new(settings: Arc<Settings>) -> Self {
        Self {
            settings,
            http: reqwest::Client::new(),
        }
    }

    pub fn is_dev(&self) -> bool {
        self.settings.sms.provider_name() == "dev"
    }

    /// Returns the OTP to store. In dev mode this is the fixed dev code.
    pub fn generate_code(&self) -> String {
        if self.is_dev() {
            return DEV_OTP.to_string();
        }
        use rand::Rng;
        format!("{:06}", rand::thread_rng().gen_range(0..1_000_000))
    }

    pub async fn send_otp(&self, phone: &str, code: &str) -> AppResult<()> {
        match self.settings.sms.provider_name() {
            "msg91" => self.send_msg91(phone, code).await,
            "twilio" => self.send_twilio(phone, code).await,
            _ => {
                log::info!("[sms:dev] OTP for {phone} is {code}");
                Ok(())
            }
        }
    }

    async fn send_msg91(&self, phone: &str, code: &str) -> AppResult<()> {
        let s = &self.settings.sms;
        let (Some(key), Some(template)) = (&s.msg91_auth_key, &s.msg91_template_id) else {
            return Err(AppError::internal("MSG91 not configured"));
        };
        let mobile = phone.trim_start_matches('+');
        let res = self
            .http
            .post("https://control.msg91.com/api/v5/otp")
            .header("authkey", key)
            .json(&serde_json::json!({
                "template_id": template,
                "mobile": mobile,
                "otp": code,
                "otp_expiry": 10
            }))
            .send()
            .await
            .map_err(|e| AppError::internal(format!("msg91: {e}")))?;
        if !res.status().is_success() {
            let body = res.text().await.unwrap_or_default();
            log::warn!("msg91 failed: {body}");
            return Err(AppError::internal("Could not send SMS"));
        }
        Ok(())
    }

    async fn send_twilio(&self, phone: &str, code: &str) -> AppResult<()> {
        let s = &self.settings.sms;
        let (Some(sid), Some(token), Some(from)) =
            (&s.twilio_account_sid, &s.twilio_auth_token, &s.twilio_from)
        else {
            return Err(AppError::internal("Twilio not configured"));
        };
        let app = self
            .settings
            .legal
            .app_name
            .clone()
            .unwrap_or_else(|| "Tea".into());
        let res = self
            .http
            .post(format!(
                "https://api.twilio.com/2010-04-01/Accounts/{sid}/Messages.json"
            ))
            .basic_auth(sid, Some(token))
            .form(&[
                ("To", phone),
                ("From", from.as_str()),
                (
                    "Body",
                    &format!("Your {app} code is {code}. It expires in 10 minutes."),
                ),
            ])
            .send()
            .await
            .map_err(|e| AppError::internal(format!("twilio: {e}")))?;
        if !res.status().is_success() {
            let body = res.text().await.unwrap_or_default();
            log::warn!("twilio failed: {body}");
            return Err(AppError::internal("Could not send SMS"));
        }
        Ok(())
    }
}
