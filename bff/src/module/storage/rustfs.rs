use bytes::Bytes;
use chrono::Utc;
use hmac::{Hmac, Mac};
use object_store::aws::AmazonS3Builder;
use object_store::path::Path;
use object_store::{
    Attribute, Attributes, ObjectStore, ObjectStoreExt, PutMode, PutOptions, PutPayload,
};
use sha2::{Digest, Sha256};
use std::sync::Arc;

use crate::error::{AppError, AppResult};

type HmacSha256 = Hmac<Sha256>;

const EMPTY_PAYLOAD_SHA256: &str =
    "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855";

pub struct RustFsStorage {
    store: Arc<dyn ObjectStore>,
    endpoint: String,
    bucket: String,
    access_key_id: String,
    secret_access_key: String,
    region: String,
    http: reqwest::Client,
}

impl RustFsStorage {
    pub fn new(
        endpoint: &str,
        bucket: &str,
        access_key_id: &str,
        secret_access_key: &str,
        region: &str,
    ) -> Result<Self, AppError> {
        let mut builder = AmazonS3Builder::new()
            .with_bucket_name(bucket)
            .with_region(region)
            .with_endpoint(endpoint)
            .with_access_key_id(access_key_id)
            .with_secret_access_key(secret_access_key)
            .with_virtual_hosted_style_request(false);
        if endpoint.starts_with("http://") {
            builder = builder.with_allow_http(true);
        }
        let store = builder
            .build()
            .map_err(|e| AppError::internal(format!("RustFS / S3 config error: {e}")))?;

        Ok(Self {
            store: Arc::new(store),
            endpoint: endpoint.to_string(),
            bucket: bucket.to_string(),
            access_key_id: access_key_id.to_string(),
            secret_access_key: secret_access_key.to_string(),
            region: region.to_string(),
            http: reqwest::Client::new(),
        })
    }

    /// Issues a SigV4-signed PUT /{bucket} (S3 CreateBucket) so a fresh RustFS
    /// instance doesn't need manual provisioning. Already existing bucket is treated as success.
    async fn ensure_bucket_exists(&self) -> AppResult<()> {
        let host = self
            .endpoint
            .split("://")
            .nth(1)
            .unwrap_or(&self.endpoint)
            .trim_end_matches('/');
        let url = format!("{}/{}", self.endpoint.trim_end_matches('/'), self.bucket);

        let now = Utc::now();
        let amz_date = now.format("%Y%m%dT%H%M%SZ").to_string();
        let date_stamp = now.format("%Y%m%d").to_string();
        let canonical_uri = format!("/{}", self.bucket);
        let canonical_headers = format!(
            "host:{host}\nx-amz-content-sha256:{EMPTY_PAYLOAD_SHA256}\nx-amz-date:{amz_date}\n"
        );
        let signed_headers = "host;x-amz-content-sha256;x-amz-date";
        let canonical_request = format!(
            "PUT\n{canonical_uri}\n\n{canonical_headers}\n{signed_headers}\n{EMPTY_PAYLOAD_SHA256}"
        );
        let credential_scope = format!("{date_stamp}/{}/s3/aws4_request", self.region);
        let string_to_sign = format!(
            "AWS4-HMAC-SHA256\n{amz_date}\n{credential_scope}\n{}",
            hex::encode(Sha256::digest(canonical_request.as_bytes()))
        );

        let sign = |key: &[u8], msg: &str| -> Vec<u8> {
            let mut mac = HmacSha256::new_from_slice(key).expect("HMAC accepts any key length");
            mac.update(msg.as_bytes());
            mac.finalize().into_bytes().to_vec()
        };
        let k_date = sign(format!("AWS4{}", self.secret_access_key).as_bytes(), &date_stamp);
        let k_region = sign(&k_date, &self.region);
        let k_service = sign(&k_region, "s3");
        let k_signing = sign(&k_service, "aws4_request");
        let signature = hex::encode(sign(&k_signing, &string_to_sign));

        let authorization = format!(
            "AWS4-HMAC-SHA256 Credential={}/{credential_scope}, SignedHeaders={signed_headers}, Signature={signature}",
            self.access_key_id
        );

        let response = self
            .http
            .put(&url)
            .header("Host", host)
            .header("x-amz-content-sha256", EMPTY_PAYLOAD_SHA256)
            .header("x-amz-date", &amz_date)
            .header("Authorization", authorization)
            .send()
            .await
            .map_err(|e| AppError::internal(format!("RustFS CreateBucket failed: {e}")))?;

        // 409 covers BucketAlreadyOwnedByYou / BucketAlreadyExists
        if response.status().is_success() || response.status().as_u16() == 409 {
            Ok(())
        } else {
            let status = response.status();
            let body = response.text().await.unwrap_or_default();
            Err(AppError::internal(format!(
                "RustFS CreateBucket failed ({status}): {body}"
            )))
        }
    }

    pub async fn create_bucket_if_not_exists(&self) -> AppResult<()> {
        self.ensure_bucket_exists().await?;

        let probe = Path::from("__tea_bucket_init__");
        let _ = self.store.delete(&probe).await;
        match self
            .store
            .put(&probe, PutPayload::from_bytes(Bytes::new()))
            .await
        {
            Ok(_) => {
                let _ = self.store.delete(&probe).await;
                Ok(())
            }
            Err(e) => Err(AppError::internal(format!("RustFS probe write error: {e:?}"))),
        }
    }

    pub async fn put(&self, path: &str, data: &[u8], content_type: &str) -> AppResult<()> {
        let path = Path::from(path);
        let mut attrs = Attributes::new();
        attrs.insert(Attribute::ContentType, content_type.to_string().into());
        let opts = PutOptions {
            mode: PutMode::Overwrite,
            attributes: attrs,
            ..Default::default()
        };
        self.store
            .put_opts(&path, PutPayload::from_bytes(Bytes::copy_from_slice(data)), opts)
            .await
            .map_err(|e| AppError::internal(format!("RustFS put error: {e:?}")))?;
        Ok(())
    }

    pub async fn get(&self, path: &str) -> AppResult<Vec<u8>> {
        let path = Path::from(path);
        let result = self
            .store
            .get(&path)
            .await
            .map_err(|e| AppError::not_found(format!("RustFS get error: {e:?}")))?;
        let bytes = result
            .bytes()
            .await
            .map_err(|e| AppError::internal(format!("RustFS bytes error: {e:?}")))?;
        Ok(bytes.to_vec())
    }

    pub async fn delete(&self, path: &str) -> AppResult<()> {
        let path = Path::from(path);
        self.store
            .delete(&path)
            .await
            .map_err(|e| AppError::internal(format!("RustFS delete error: {e:?}")))?;
        Ok(())
    }
}
