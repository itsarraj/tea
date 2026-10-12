use actix_multipart::Multipart;
use actix_web::{web, HttpResponse};
use futures_util::StreamExt;
use std::sync::Arc;

use crate::error::{AppError, AppResult};
use crate::middleware::AuthenticatedUser;
use crate::module::dating::model::*;
use crate::module::dating::service::DatingService;
use crate::module::push::PushService;

type Svc = web::Data<Arc<DatingService>>;

// ---- profile ---------------------------------------------------------------

pub async fn get_profile(svc: Svc, user: AuthenticatedUser) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(svc.get_profile(user.user_id).await?))
}

pub async fn patch_profile(
    svc: Svc,
    user: AuthenticatedUser,
    body: web::Json<PatchProfileRequest>,
) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(svc.patch_profile(user.user_id, body.into_inner()).await?))
}

pub async fn set_location(
    svc: Svc,
    user: AuthenticatedUser,
    body: web::Json<LocationRequest>,
) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(svc.set_location(user.user_id, body.into_inner()).await?))
}

pub async fn upload_photo(
    svc: Svc,
    user: AuthenticatedUser,
    mut payload: Multipart,
) -> AppResult<HttpResponse> {
    let mut bytes: Vec<u8> = Vec::new();
    let max = 12 * 1024 * 1024;
    while let Some(field) = payload.next().await {
        let mut field = field.map_err(|e| AppError::bad_request(format!("multipart: {e}")))?;
        let name = field.name().unwrap_or("").to_string();
        if name != "file" && name != "photo" {
            continue;
        }
        while let Some(chunk) = field.next().await {
            let chunk = chunk.map_err(|e| AppError::bad_request(format!("upload: {e}")))?;
            if bytes.len() + chunk.len() > max {
                return Err(AppError::bad_request("Photo too large"));
            }
            bytes.extend_from_slice(&chunk);
        }
        break;
    }
    if bytes.is_empty() {
        return Err(AppError::bad_request(
            "Send the image as multipart field `file`",
        ));
    }
    Ok(HttpResponse::Ok().json(svc.add_photo(user.user_id, &bytes).await?))
}

pub async fn delete_photo(
    svc: Svc,
    user: AuthenticatedUser,
    path: web::Path<String>,
) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(svc.delete_photo(user.user_id, &path.into_inner()).await?))
}

#[derive(serde::Deserialize)]
pub struct ReorderRequest {
    pub ids: Vec<String>,
}

pub async fn reorder_photos(
    svc: Svc,
    user: AuthenticatedUser,
    body: web::Json<ReorderRequest>,
) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(
        svc.reorder_photos(user.user_id, body.into_inner().ids)
            .await?,
    ))
}

pub async fn delete_account(svc: Svc, user: AuthenticatedUser) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(svc.delete_account(user.user_id).await?))
}

// ---- devices ---------------------------------------------------------------

pub async fn register_device(
    push: web::Data<Arc<PushService>>,
    user: AuthenticatedUser,
    body: web::Json<DeviceRequest>,
) -> AppResult<HttpResponse> {
    let token = body.token.trim();
    if !token.starts_with("ExponentPushToken[") && !token.starts_with("ExpoPushToken[") {
        return Err(AppError::bad_request("Invalid Expo push token"));
    }
    push.register(user.user_id, token, body.platform.as_deref())
        .await?;
    Ok(HttpResponse::Ok().json(OkResponse { ok: true }))
}

pub async fn unregister_device(
    push: web::Data<Arc<PushService>>,
    _user: AuthenticatedUser,
    body: web::Json<DeviceRequest>,
) -> AppResult<HttpResponse> {
    push.unregister(body.token.trim()).await;
    Ok(HttpResponse::Ok().json(OkResponse { ok: true }))
}

// ---- discover / stories ---------------------------------------------------

pub async fn stories(svc: Svc, user: AuthenticatedUser) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(svc.stories(user.user_id).await?))
}

pub async fn nearby(
    svc: Svc,
    user: AuthenticatedUser,
    q: web::Query<DiscoverQuery>,
) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(svc.nearby(user.user_id, q.into_inner()).await?))
}

pub async fn person(
    svc: Svc,
    user: AuthenticatedUser,
    path: web::Path<String>,
) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(svc.person(user.user_id, &path.into_inner()).await?))
}

// ---- swipe / matches ------------------------------------------------------

pub async fn swipe(
    svc: Svc,
    user: AuthenticatedUser,
    body: web::Json<SwipeRequest>,
) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(
        svc.swipe(
            user.user_id,
            &body.target_id,
            &body.action,
            body.mode.as_deref(),
        )
        .await?,
    ))
}

pub async fn likes(svc: Svc, user: AuthenticatedUser) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(svc.likes(user.user_id).await?))
}

pub async fn matches(svc: Svc, user: AuthenticatedUser) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(svc.matches(user.user_id).await?))
}

pub async fn unmatch(
    svc: Svc,
    user: AuthenticatedUser,
    path: web::Path<String>,
) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(svc.unmatch(user.user_id, &path.into_inner()).await?))
}

// ---- chat -----------------------------------------------------------------

pub async fn conversations(svc: Svc, user: AuthenticatedUser) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(svc.conversations(user.user_id).await?))
}

pub async fn list_messages(
    svc: Svc,
    user: AuthenticatedUser,
    path: web::Path<String>,
    q: web::Query<MessagesQuery>,
) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(
        svc.messages(user.user_id, &path.into_inner(), q.into_inner())
            .await?,
    ))
}

pub async fn send_message(
    svc: Svc,
    user: AuthenticatedUser,
    path: web::Path<String>,
    body: web::Json<SendMessageRequest>,
) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(
        svc.send_message(user.user_id, &path.into_inner(), &body.body)
            .await?,
    ))
}

// ---- feed & advice --------------------------------------------------------

pub async fn feed(
    svc: Svc,
    user: AuthenticatedUser,
    q: web::Query<FeedQuery>,
) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(svc.feed(user.user_id, q.into_inner()).await?))
}

pub async fn get_post(
    svc: Svc,
    user: AuthenticatedUser,
    path: web::Path<String>,
) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(svc.get_post(user.user_id, &path.into_inner()).await?))
}

pub async fn create_post(
    svc: Svc,
    user: AuthenticatedUser,
    body: web::Json<CreatePostRequest>,
) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(svc.create_post(user.user_id, body.into_inner()).await?))
}

pub async fn toggle_like(
    svc: Svc,
    user: AuthenticatedUser,
    path: web::Path<String>,
) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(svc.toggle_like(user.user_id, &path.into_inner()).await?))
}

pub async fn vote_verdict(
    svc: Svc,
    user: AuthenticatedUser,
    path: web::Path<String>,
    body: web::Json<VoteVerdictRequest>,
) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(
        svc.vote_verdict(user.user_id, &path.into_inner(), body.into_inner())
            .await?,
    ))
}

pub async fn toggle_save(
    svc: Svc,
    user: AuthenticatedUser,
    path: web::Path<String>,
) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(svc.toggle_save(user.user_id, &path.into_inner()).await?))
}

pub async fn comments(
    svc: Svc,
    user: AuthenticatedUser,
    path: web::Path<String>,
) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(svc.comments(user.user_id, &path.into_inner()).await?))
}

pub async fn add_comment(
    svc: Svc,
    user: AuthenticatedUser,
    path: web::Path<String>,
    body: web::Json<CommentRequest>,
) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(
        svc.add_comment(user.user_id, &path.into_inner(), &body.body)
            .await?,
    ))
}

// ---- advisors & following -------------------------------------------------

pub async fn advisors(
    svc: Svc,
    user: AuthenticatedUser,
    q: web::Query<AdvisorQuery>,
) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(svc.advisors(user.user_id, q.into_inner()).await?))
}

pub async fn advisor_profile(
    svc: Svc,
    user: AuthenticatedUser,
    path: web::Path<String>,
) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(svc.advisor_profile(user.user_id, &path.into_inner()).await?))
}

pub async fn toggle_follow(
    svc: Svc,
    user: AuthenticatedUser,
    path: web::Path<String>,
) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(svc.toggle_follow(user.user_id, &path.into_inner()).await?))
}

// ---- notes (stories rail) -------------------------------------------------

pub async fn add_note(
    svc: Svc,
    user: AuthenticatedUser,
    body: web::Json<CreateQuickNoteRequest>,
) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(svc.add_quick_note(user.user_id, body.into_inner()).await?))
}

// ---- notifications --------------------------------------------------------

pub async fn notifications(svc: Svc, user: AuthenticatedUser) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(svc.notifications(user.user_id).await?))
}

pub async fn confirm_notification(
    svc: Svc,
    user: AuthenticatedUser,
    path: web::Path<String>,
) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(svc.confirm_notification(user.user_id, &path.into_inner()).await?))
}

pub async fn delete_notification(
    svc: Svc,
    user: AuthenticatedUser,
    path: web::Path<String>,
) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(svc.delete_notification(user.user_id, &path.into_inner()).await?))
}

// ---- safety ---------------------------------------------------------------

pub async fn block(
    svc: Svc,
    user: AuthenticatedUser,
    path: web::Path<String>,
) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(svc.block(user.user_id, &path.into_inner()).await?))
}

pub async fn unblock(
    svc: Svc,
    user: AuthenticatedUser,
    path: web::Path<String>,
) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(svc.unblock(user.user_id, &path.into_inner()).await?))
}

pub async fn report(
    svc: Svc,
    user: AuthenticatedUser,
    path: web::Path<String>,
    body: web::Json<ReportRequest>,
) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(
        svc.report(user.user_id, &path.into_inner(), body.into_inner())
            .await?,
    ))
}

pub async fn blocked(svc: Svc, user: AuthenticatedUser) -> AppResult<HttpResponse> {
    Ok(HttpResponse::Ok().json(svc.blocked_users(user.user_id).await?))
}
