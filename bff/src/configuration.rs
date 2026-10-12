use serde::Deserialize;
use std::env;

#[derive(Debug, Clone, Deserialize)]
pub struct Settings {
    pub application_host: String,
    pub application_port: u16,
    pub database: DatabaseSettings,
    pub redis: RedisSettings,
    pub jwt: JwtSettings,
    pub email: EmailSettings,
    #[serde(default)]
    pub auth: AuthSettings,
    #[serde(default)]
    pub oauth: OAuthSettings,
    #[serde(default)]
    pub turnstile: TurnstileSettings,
    #[serde(default)]
    pub storage: StorageSettings,
    #[serde(default)]
    pub sms: SmsSettings,
    #[serde(default)]
    pub push: PushSettings,
    #[serde(default)]
    pub rate_limit: RateLimitSettings,
    #[serde(default)]
    pub legal: LegalSettings,
}

/// Where uploaded photos live. Local disk by default (served at /media);
/// set `s3_*` to push to RustFS / S3-compatible storage instead.
#[derive(Debug, Clone, Deserialize)]
pub struct StorageSettings {
    #[serde(default = "default_storage_dir")]
    pub dir: String,
    /// Public base URL that prefixes stored keys, e.g. https://api.example.com/media
    #[serde(default)]
    pub public_base_url: Option<String>,
    #[serde(default = "default_max_upload_mb")]
    pub max_upload_mb: u64,
    /// RustFS / S3 endpoint, e.g. http://127.0.0.1:9000 or http://rustfs:9000
    #[serde(default)]
    pub endpoint: Option<String>,
    #[serde(default = "default_s3_bucket")]
    pub bucket: String,
    #[serde(default = "default_s3_access_key")]
    pub access_key_id: String,
    #[serde(default = "default_s3_secret_key")]
    pub secret_access_key: String,
    #[serde(default = "default_s3_region")]
    pub region: String,
}

fn default_storage_dir() -> String {
    "uploads".into()
}
fn default_max_upload_mb() -> u64 {
    8
}
fn default_s3_bucket() -> String {
    "tea-media".into()
}
fn default_s3_access_key() -> String {
    "rustfsadmin".into()
}
fn default_s3_secret_key() -> String {
    "rustfsadmin".into()
}
fn default_s3_region() -> String {
    "us-east-1".into()
}

impl Default for StorageSettings {
    fn default() -> Self {
        Self {
            dir: default_storage_dir(),
            public_base_url: None,
            max_upload_mb: default_max_upload_mb(),
            endpoint: None,
            bucket: default_s3_bucket(),
            access_key_id: default_s3_access_key(),
            secret_access_key: default_s3_secret_key(),
            region: default_s3_region(),
        }
    }
}

/// SMS OTP provider. `dev` logs the code and accepts 123456.
/// `msg91` needs auth_key + template_id; `twilio` needs account_sid, auth_token, from.
#[derive(Debug, Clone, Deserialize, Default)]
pub struct SmsSettings {
    #[serde(default)]
    pub provider: Option<String>,
    pub msg91_auth_key: Option<String>,
    pub msg91_template_id: Option<String>,
    pub twilio_account_sid: Option<String>,
    pub twilio_auth_token: Option<String>,
    pub twilio_from: Option<String>,
}

impl SmsSettings {
    pub fn provider_name(&self) -> &str {
        self.provider.as_deref().unwrap_or("dev")
    }
}

#[derive(Debug, Clone, Deserialize, Default)]
pub struct PushSettings {
    /// Optional Expo access token (for enhanced push security).
    pub expo_access_token: Option<String>,
    #[serde(default = "default_true")]
    pub enabled: bool,
}

fn default_true() -> bool {
    true
}

#[derive(Debug, Clone, Deserialize)]
pub struct RateLimitSettings {
    #[serde(default = "default_true")]
    pub enabled: bool,
    /// Auth endpoints (login/register/otp): requests per window per IP.
    #[serde(default = "default_auth_limit")]
    pub auth_per_minute: u32,
    /// General API: requests per minute per user/IP.
    #[serde(default = "default_api_limit")]
    pub api_per_minute: u32,
}

fn default_auth_limit() -> u32 {
    10
}
fn default_api_limit() -> u32 {
    240
}

impl Default for RateLimitSettings {
    fn default() -> Self {
        Self {
            enabled: true,
            auth_per_minute: default_auth_limit(),
            api_per_minute: default_api_limit(),
        }
    }
}

#[derive(Debug, Clone, Deserialize, Default)]
pub struct LegalSettings {
    pub app_name: Option<String>,
    pub support_email: Option<String>,
    pub company: Option<String>,
}

#[derive(Debug, Clone, Deserialize)]
pub struct DatabaseSettings {
    pub host: String,
    pub port: u16,
    pub username: String,
    pub password: String,
    pub database_name: String,
}

impl DatabaseSettings {
    pub fn connection_string(&self) -> String {
        format!(
            "postgres://{}:{}@{}:{}/{}",
            self.username, self.password, self.host, self.port, self.database_name
        )
    }
}

#[derive(Debug, Clone, Deserialize)]
pub struct RedisSettings {
    pub host: String,
    pub port: u16,
    pub password: Option<String>,
    pub database: Option<u8>,
}

impl RedisSettings {
    pub fn connection_string(&self) -> String {
        let auth = self
            .password
            .as_ref()
            .filter(|p| !p.is_empty())
            .map(|p| format!(":{p}@"))
            .unwrap_or_default();
        let db = self.database.unwrap_or(0);
        format!("redis://{auth}{}:{}/{}", self.host, self.port, db)
    }
}

#[derive(Debug, Clone, Deserialize)]
pub struct JwtSettings {
    pub secret: String,
    pub access_token_expiration_hours: i64,
    pub refresh_token_expiration_days: i64,
}

#[derive(Debug, Clone, Deserialize)]
pub struct EmailSettings {
    pub api_key: String,
    pub from_email: String,
    pub from_name: String,
    pub base_url: String,
    pub frontend_base_url: Option<String>,
}

/// Email verification is opt-in: the mobile app signs most users up via phone or Google.
#[derive(Debug, Clone, Deserialize, Default)]
pub struct AuthSettings {
    #[serde(default)]
    pub require_email_verification: bool,
}

#[derive(Debug, Clone, Deserialize, Default)]
pub struct OAuthSettings {
    #[serde(default)]
    pub google: GoogleOAuthSettings,
}

#[derive(Debug, Clone, Deserialize, Default)]
pub struct GoogleOAuthSettings {
    pub client_id: Option<String>,
    pub client_secret: Option<String>,
    pub redirect_uri: Option<String>,
}

impl GoogleOAuthSettings {
    pub fn is_configured(&self) -> bool {
        self.client_id.as_ref().is_some_and(|s| !s.is_empty())
            && self.client_secret.as_ref().is_some_and(|s| !s.is_empty())
            && self.redirect_uri.as_ref().is_some_and(|s| !s.is_empty())
    }
}

#[derive(Debug, Clone, Deserialize, Default)]
pub struct TurnstileSettings {
    pub secret_key: Option<String>,
    pub hostnames: Option<String>,
}

impl TurnstileSettings {
    pub fn is_enabled(&self) -> bool {
        self.secret_key.as_ref().is_some_and(|s| !s.is_empty())
    }
}

pub fn get_configuration() -> Result<Settings, config::ConfigError> {
    let base = env::current_dir().map_err(|e| config::ConfigError::Message(e.to_string()))?;
    let settings = config::Config::builder()
        .add_source(config::File::from(base.join("configuration.yaml")).required(false))
        .add_source(config::Environment::with_prefix("BFF").separator("__"))
        .build()?;
    settings.try_deserialize()
}
