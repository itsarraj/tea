//! Photo storage. Backed by RustFS (S3-compatible) with automatic SIMD WebP
//! thumbnail generation, with local disk as a fallback.

pub mod rustfs;
pub mod thumbnail;

use std::path::PathBuf;
use std::sync::Arc;

use crate::configuration::Settings;
use crate::error::{AppError, AppResult};
use self::rustfs::RustFsStorage;
use self::thumbnail::process_photo_variants;

pub struct Stored {
    pub key: String,
    pub url: String,
}

pub struct StoredPhoto {
    pub key: String,
    pub url: String,
    pub full_key: String,
    pub full_url: String,
    pub thumb_key: String,
    pub thumb_url: String,
}

pub struct StorageService {
    settings: Arc<Settings>,
    rustfs: Option<RustFsStorage>,
}

impl StorageService {
    pub fn new(settings: Arc<Settings>) -> Self {
        let rustfs = settings
            .storage
            .endpoint
            .as_ref()
            .filter(|s| !s.trim().is_empty())
            .and_then(|ep| {
                RustFsStorage::new(
                    ep,
                    &settings.storage.bucket,
                    &settings.storage.access_key_id,
                    &settings.storage.secret_access_key,
                    &settings.storage.region,
                )
                .map_err(|e| {
                    log::warn!("RustFS initialization skipped/failed: {e}");
                    e
                })
                .ok()
            });

        Self { settings, rustfs }
    }

    pub fn root(&self) -> PathBuf {
        PathBuf::from(&self.settings.storage.dir)
    }

    pub fn max_bytes(&self) -> usize {
        (self.settings.storage.max_upload_mb * 1024 * 1024) as usize
    }

    pub fn public_url(&self, key: &str) -> String {
        let base = self
            .settings
            .storage
            .public_base_url
            .clone()
            .unwrap_or_else(|| {
                format!(
                    "{}/media",
                    self.settings.email.base_url.trim_end_matches('/')
                )
            });
        format!("{}/{}", base.trim_end_matches('/'), key)
    }

    pub async fn ensure_ready(&self) -> AppResult<()> {
        if let Some(ref r) = self.rustfs {
            if let Err(e) = r.create_bucket_if_not_exists().await {
                log::warn!("RustFS bucket check/create failed (will retry on upload): {e}");
            }
        }
        self.ensure_dir().await
    }

    pub async fn ensure_dir(&self) -> AppResult<()> {
        tokio::fs::create_dir_all(self.root())
            .await
            .map_err(|e| AppError::internal(format!("storage dir: {e}")))
    }

    /// Stores a photo by generating 3 SIMD-accelerated WebP variants:
    /// - card: max 600x800 (~35 KB)
    /// - full: max 1200x1600 (~160 KB)
    /// - thumb: max 200x200 (~10 KB)
    pub async fn put_photo(&self, user_id: &str, bytes: &[u8]) -> AppResult<StoredPhoto> {
        if bytes.is_empty() {
            return Err(AppError::bad_request("Empty upload"));
        }
        if bytes.len() > self.max_bytes() {
            return Err(AppError::bad_request(format!(
                "Photo too large (max {} MB)",
                self.settings.storage.max_upload_mb
            )));
        }
        let _ = sniff_ext(bytes)
            .ok_or_else(|| AppError::bad_request("Unsupported image format. Use JPG, PNG, or WebP"))?;

        let variants = process_photo_variants(bytes)?;
        let photo_id = uuid::Uuid::new_v4();

        let card_key = format!("photos/{}/{}_card.webp", user_id, photo_id);
        let full_key = format!("photos/{}/{}_full.webp", user_id, photo_id);
        let thumb_key = format!("photos/{}/{}_thumb.webp", user_id, photo_id);

        if let Some(ref r) = self.rustfs {
            r.put(&card_key, &variants.card_webp, "image/webp").await?;
            r.put(&full_key, &variants.full_webp, "image/webp").await?;
            r.put(&thumb_key, &variants.thumb_webp, "image/webp").await?;
        } else {
            // Local disk fallback
            self.write_local(&card_key, &variants.card_webp).await?;
            self.write_local(&full_key, &variants.full_webp).await?;
            self.write_local(&thumb_key, &variants.thumb_webp).await?;
        }

        Ok(StoredPhoto {
            url: self.public_url(&card_key),
            key: card_key,
            full_url: self.public_url(&full_key),
            full_key,
            thumb_url: self.public_url(&thumb_key),
            thumb_key,
        })
    }

    async fn write_local(&self, key: &str, bytes: &[u8]) -> AppResult<()> {
        let path = self.root().join(key);
        if let Some(parent) = path.parent() {
            tokio::fs::create_dir_all(parent)
                .await
                .map_err(|e| AppError::internal(format!("storage mkdir: {e}")))?;
        }
        tokio::fs::write(&path, bytes)
            .await
            .map_err(|e| AppError::internal(format!("storage write: {e}")))?;
        Ok(())
    }

    pub async fn get(&self, key: &str) -> AppResult<Vec<u8>> {
        if let Some(ref r) = self.rustfs {
            r.get(key).await
        } else {
            let path = self.root().join(key);
            tokio::fs::read(&path)
                .await
                .map_err(|_| AppError::not_found("File not found"))
        }
    }

    pub async fn delete(&self, key: &str) {
        let mut keys = vec![key.to_string()];
        if key.ends_with("_card.webp") {
            keys.push(key.replace("_card.webp", "_full.webp"));
            keys.push(key.replace("_card.webp", "_thumb.webp"));
        }

        for k in keys {
            if let Some(ref r) = self.rustfs {
                let _ = r.delete(&k).await;
            }
            let _ = tokio::fs::remove_file(self.root().join(&k)).await;
        }
    }

    /// Legacy / generic put
    pub async fn put(&self, user_id: &str, _ext: &str, bytes: &[u8]) -> AppResult<Stored> {
        let photo = self.put_photo(user_id, bytes).await?;
        Ok(Stored {
            key: photo.key,
            url: photo.url,
        })
    }
}

/// Sniff image type from magic bytes so clients can't lie about extension.
pub fn sniff_ext(bytes: &[u8]) -> Option<&'static str> {
    if bytes.starts_with(&[0xFF, 0xD8, 0xFF]) {
        Some("jpg")
    } else if bytes.starts_with(&[0x89, b'P', b'N', b'G']) {
        Some("png")
    } else if bytes.len() > 12 && &bytes[0..4] == b"RIFF" && &bytes[8..12] == b"WEBP" {
        Some("webp")
    } else if bytes.len() > 12
        && (&bytes[4..12] == b"ftypheic"
            || &bytes[4..12] == b"ftypheix"
            || &bytes[4..12] == b"ftypmif1")
    {
        Some("heic")
    } else {
        None
    }
}
