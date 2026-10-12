use chrono::{DateTime, NaiveDate, Utc};
use serde::{Deserialize, Serialize};
use uuid::Uuid;

// ---------------------------------------------------------------------------
// Photos
// ---------------------------------------------------------------------------

#[derive(Debug, Clone, Serialize, sqlx::FromRow)]
pub struct PhotoRow {
    pub id: Uuid,
    pub user_id: Uuid,
    pub url: String,
    pub storage_key: Option<String>,
    pub position: i32,
}

#[derive(Debug, Clone, Serialize)]
pub struct PhotoJson {
    pub id: String,
    pub url: String,
    pub position: i32,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub full_url: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub thumb_url: Option<String>,
}

impl From<PhotoRow> for PhotoJson {
    fn from(p: PhotoRow) -> Self {
        let (full_url, thumb_url) = if p.url.contains("_card.webp") {
            (
                Some(p.url.replace("_card.webp", "_full.webp")),
                Some(p.url.replace("_card.webp", "_thumb.webp")),
            )
        } else {
            (None, None)
        };
        Self {
            id: p.id.to_string(),
            url: p.url,
            position: p.position,
            full_url,
            thumb_url,
        }
    }
}

// ---------------------------------------------------------------------------
// My profile
// ---------------------------------------------------------------------------

#[derive(Debug, sqlx::FromRow)]
pub struct MyProfileRow {
    pub user_id: Uuid,
    pub display_name: String,
    pub handle: String,
    pub gender: Option<String>,
    pub looking_for: Vec<String>,
    pub intent: String,
    pub birthday: Option<NaiveDate>,
    pub age: Option<i32>,
    pub city: String,
    pub country: String,
    pub about: String,
    pub interests: Vec<String>,
    pub lat: Option<f64>,
    pub lng: Option<f64>,
    pub min_age: i32,
    pub max_age: i32,
    pub max_distance_km: i32,
    pub rank_title: String,
    pub helpful_rating: i32,
    pub followers_count: i32,
    pub following_count: i32,
    pub posts_count: i32,
    pub advice_given_count: i32,
    pub specialty: String,
    pub recent_advice_quote: String,
    pub onboarding_complete: bool,
    pub email: String,
    pub phone: Option<String>,
    pub has_password: bool,
}

#[derive(Debug, Serialize)]
pub struct MyProfileJson {
    pub user_id: String,
    pub display_name: String,
    pub handle: String,
    pub gender: Option<String>,
    pub looking_for: Vec<String>,
    pub intent: String,
    pub birthday: Option<String>,
    pub age: Option<i32>,
    pub city: String,
    pub country: String,
    pub about: String,
    pub interests: Vec<String>,
    pub lat: Option<f64>,
    pub lng: Option<f64>,
    pub min_age: i32,
    pub max_age: i32,
    pub max_distance_km: i32,
    #[serde(rename = "rankTitle")]
    pub rank_title: String,
    #[serde(rename = "helpfulRating")]
    pub helpful_rating: i32,
    #[serde(rename = "followersCount")]
    pub followers_count: i32,
    #[serde(rename = "followingCount")]
    pub following_count: i32,
    #[serde(rename = "postsCount")]
    pub posts_count: i32,
    #[serde(rename = "adviceGivenCount")]
    pub advice_given_count: i32,
    pub specialty: String,
    #[serde(rename = "recentAdviceQuote")]
    pub recent_advice_quote: String,
    pub onboarding_complete: bool,
    pub email: String,
    pub phone: Option<String>,
    pub has_password: bool,
    pub photos: Vec<PhotoJson>,
}

impl MyProfileJson {
    pub fn from_row(r: MyProfileRow, photos: Vec<PhotoJson>) -> Self {
        Self {
            user_id: r.user_id.to_string(),
            display_name: r.display_name,
            handle: r.handle,
            gender: r.gender,
            looking_for: r.looking_for,
            intent: r.intent,
            birthday: r.birthday.map(|d| d.to_string()),
            age: r.age,
            city: r.city,
            country: r.country,
            about: r.about,
            interests: r.interests,
            lat: r.lat,
            lng: r.lng,
            min_age: r.min_age,
            max_age: r.max_age,
            max_distance_km: r.max_distance_km,
            rank_title: r.rank_title,
            helpful_rating: r.helpful_rating,
            followers_count: r.followers_count,
            following_count: r.following_count,
            posts_count: r.posts_count,
            advice_given_count: r.advice_given_count,
            specialty: r.specialty,
            recent_advice_quote: r.recent_advice_quote,
            onboarding_complete: r.onboarding_complete,
            email: r.email,
            phone: r.phone,
            has_password: r.has_password,
            photos,
        }
    }
}

#[derive(Debug, Deserialize, Default)]
pub struct PatchProfileRequest {
    pub display_name: Option<String>,
    pub handle: Option<String>,
    pub gender: Option<String>,
    pub looking_for: Option<Vec<String>>,
    pub intent: Option<String>,
    /// YYYY-MM-DD
    pub birthday: Option<String>,
    pub city: Option<String>,
    pub country: Option<String>,
    pub about: Option<String>,
    pub specialty: Option<String>,
    pub recent_advice_quote: Option<String>,
    pub interests: Option<Vec<String>>,
    pub min_age: Option<i32>,
    pub max_age: Option<i32>,
    pub max_distance_km: Option<i32>,
    pub lat: Option<f64>,
    pub lng: Option<f64>,
    /// Client asks to finish onboarding; server validates required fields.
    pub complete_onboarding: Option<bool>,
}

#[derive(Debug, Deserialize)]
pub struct LocationRequest {
    pub lat: f64,
    pub lng: f64,
    pub city: Option<String>,
}

#[derive(Debug, Deserialize)]
pub struct DeviceRequest {
    pub token: String,
    pub platform: Option<String>,
}

// ---------------------------------------------------------------------------
// Public profile (what other users see)
// ---------------------------------------------------------------------------

#[derive(Debug, sqlx::FromRow)]
pub struct PublicProfileRow {
    pub user_id: Uuid,
    pub display_name: String,
    pub handle: Option<String>,
    pub age: Option<i32>,
    pub gender: Option<String>,
    pub city: String,
    pub about: String,
    pub interests: Vec<String>,
    pub intent: String,
    pub distance_km: Option<f64>,
    pub last_active_at: DateTime<Utc>,
    pub created_at: DateTime<Utc>,
}

#[derive(Debug, Clone, Serialize)]
pub struct PublicProfileJson {
    pub id: String,
    pub name: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub handle: Option<String>,
    pub age: i32,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub gender: Option<String>,
    pub city: String,
    #[serde(rename = "distanceKm", skip_serializing_if = "Option::is_none")]
    pub distance_km: Option<f64>,
    #[serde(rename = "isNew", skip_serializing_if = "Option::is_none")]
    pub is_new: Option<bool>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub online: Option<bool>,
    pub interests: Vec<String>,
    pub about: String,
    pub intent: String,
    #[serde(rename = "matchPercent")]
    pub match_percent: i32,
    pub photos: Vec<PhotoJson>,
    #[serde(rename = "photoUrl", skip_serializing_if = "Option::is_none")]
    pub photo_url: Option<String>,
}

impl PublicProfileJson {
    pub fn from_row(r: PublicProfileRow, photos: Vec<PhotoJson>, match_percent: i32) -> Self {
        let now = Utc::now();
        let is_new = (now - r.created_at).num_days() <= 7;
        let online = (now - r.last_active_at).num_minutes() <= 15;
        Self {
            id: r.user_id.to_string(),
            name: r.display_name,
            handle: r.handle.filter(|h| !h.is_empty()),
            age: r.age.unwrap_or(18),
            gender: r.gender,
            city: r.city,
            distance_km: r.distance_km.map(|d| (d * 10.0).round() / 10.0),
            is_new: if is_new { Some(true) } else { None },
            online: if online { Some(true) } else { None },
            interests: r.interests,
            about: r.about,
            intent: r.intent,
            match_percent,
            photo_url: photos.first().map(|p| p.url.clone()),
            photos,
        }
    }
}

// ---------------------------------------------------------------------------
// Swipes / matches
// ---------------------------------------------------------------------------

#[derive(Debug, Deserialize)]
pub struct SwipeRequest {
    pub target_id: String,
    pub action: String,
    /// "friends" | "partner": the mode the client was browsing in. Optional.
    pub mode: Option<String>,
}

#[derive(Debug, Serialize)]
pub struct SwipeResponse {
    pub matched: bool,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub match_id: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub conversation_id: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub person: Option<PublicProfileJson>,
}

#[derive(Debug, Serialize)]
pub struct MatchJson {
    pub id: String,
    #[serde(rename = "conversationId")]
    pub conversation_id: String,
    pub person: PublicProfileJson,
    #[serde(rename = "createdAt")]
    pub created_at: String,
}

#[derive(Debug, Serialize)]
pub struct LikesSummary {
    pub received: i64,
    pub matches: i64,
    pub people: Vec<PublicProfileJson>,
}

// ---------------------------------------------------------------------------
// Chat
// ---------------------------------------------------------------------------

#[derive(Debug, sqlx::FromRow)]
pub struct ConversationRow {
    pub id: Uuid,
    pub match_id: Uuid,
    pub peer_id: Uuid,
    pub peer_name: String,
    pub peer_handle: Option<String>,
    pub last_preview: String,
    pub last_message_at: DateTime<Utc>,
    pub last_sender_id: Option<Uuid>,
    pub last_read_at: Option<DateTime<Utc>>,
    pub request_status: String,
}

#[derive(Debug, Serialize)]
pub struct ConversationJson {
    pub id: String,
    #[serde(rename = "matchId")]
    pub match_id: String,
    #[serde(rename = "peerId")]
    pub peer_id: String,
    pub name: String,
    #[serde(rename = "handle", skip_serializing_if = "Option::is_none")]
    pub handle: Option<String>,
    #[serde(rename = "photoUrl", skip_serializing_if = "Option::is_none")]
    pub photo_url: Option<String>,
    pub preview: String,
    pub time: String,
    #[serde(rename = "lastMessageAt")]
    pub last_message_at: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub unread: Option<bool>,
    #[serde(rename = "requestStatus")]
    pub request_status: String,
}

#[derive(Debug, sqlx::FromRow)]
pub struct MessageRow {
    pub id: Uuid,
    pub sender_id: Uuid,
    pub body: String,
    pub created_at: DateTime<Utc>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct MessageJson {
    pub id: String,
    #[serde(rename = "senderId")]
    pub sender_id: String,
    pub body: String,
    pub mine: bool,
    pub created_at: String,
}

#[derive(Debug, Deserialize)]
pub struct SendMessageRequest {
    pub body: String,
}

#[derive(Debug, Deserialize)]
pub struct MessagesQuery {
    /// ISO timestamp; return messages strictly before this.
    pub before: Option<String>,
    pub limit: Option<i64>,
}

// ---------------------------------------------------------------------------
// Feed
// ---------------------------------------------------------------------------

#[derive(Debug, sqlx::FromRow)]
pub struct FeedRow {
    pub id: Uuid,
    pub author_id: Uuid,
    pub author_name: String,
    pub author_handle: String,
    pub author_rank: String,
    pub author_followers: i32,
    pub author_city: String,
    pub mode: String,
    pub title: String,
    pub category: String,
    pub question: String,
    pub like_count: i64,
    pub comment_count: i64,
    pub helpful_count: i32,
    pub red_flags: i32,
    pub green_flags: i32,
    pub valid_count: i32,
    pub liked_by_me: bool,
    pub followed_by_me: bool,
    pub saved_by_me: bool,
    pub user_vote: Option<String>,
    pub my_swipe: Option<String>,
    pub conversation_id: Option<Uuid>,
    pub created_at: DateTime<Utc>,
}

#[derive(Debug, Clone, Serialize)]
pub struct TopCommentJson {
    pub author: String,
    pub text: String,
    #[serde(rename = "helpfulCount")]
    pub helpful_count: i32,
}

#[derive(Debug, Serialize)]
pub struct FeedPostJson {
    pub id: String,
    pub title: String,
    pub category: String,
    pub question: String,
    pub mode: String,
    pub author: String,
    #[serde(rename = "authorId")]
    pub author_id: String,
    #[serde(rename = "authorHandle")]
    pub author_handle: String,
    #[serde(rename = "authorRank")]
    pub author_rank: String,
    #[serde(rename = "authorFollowers")]
    pub author_followers: i32,
    pub city: String,
    #[serde(rename = "authorPhotoUrl", skip_serializing_if = "Option::is_none")]
    pub author_photo_url: Option<String>,
    #[serde(rename = "likeCount")]
    pub like_count: i64,
    #[serde(rename = "commentCount")]
    pub comment_count: i64,
    #[serde(rename = "helpfulCount")]
    pub helpful_count: i32,
    #[serde(rename = "likedByMe")]
    pub liked_by_me: bool,
    #[serde(rename = "followedByMe")]
    pub followed_by_me: bool,
    #[serde(rename = "savedByMe")]
    pub saved_by_me: bool,
    #[serde(rename = "redFlagCount")]
    pub red_flag_count: i32,
    #[serde(rename = "greenFlagCount")]
    pub green_flag_count: i32,
    #[serde(rename = "validCount")]
    pub valid_count: i32,
    #[serde(rename = "userVote")]
    pub user_vote: Option<String>,
    #[serde(rename = "topComment", skip_serializing_if = "Option::is_none")]
    pub top_comment: Option<TopCommentJson>,
    pub relation: String,
    #[serde(rename = "conversationId", skip_serializing_if = "Option::is_none")]
    pub conversation_id: Option<String>,
    #[serde(rename = "createdAt")]
    pub created_at: String,
}

#[derive(Debug, Deserialize)]
pub struct FeedQuery {
    pub mode: Option<String>,
    pub category: Option<String>,
    pub query: Option<String>,
    pub cursor: Option<String>,
    pub limit: Option<i64>,
    pub author_id: Option<String>,
    pub saved: Option<bool>,
}

#[derive(Debug, Deserialize)]
pub struct CreatePostRequest {
    pub title: Option<String>,
    pub category: String,
    pub question: String,
    pub mode: Option<String>,
}

#[derive(Debug, Deserialize)]
pub struct VoteVerdictRequest {
    pub vote: String, // 'red' | 'green' | 'valid'
}

#[derive(Debug, Serialize)]
pub struct VoteVerdictResponse {
    #[serde(rename = "redFlagCount")]
    pub red_flag_count: i32,
    #[serde(rename = "greenFlagCount")]
    pub green_flag_count: i32,
    #[serde(rename = "validCount")]
    pub valid_count: i32,
    #[serde(rename = "userVote")]
    pub user_vote: Option<String>,
}

#[derive(Debug, Serialize)]
pub struct SaveToggleResponse {
    pub saved: bool,
}

#[derive(Debug, Serialize)]
pub struct LikeToggleResponse {
    pub liked: bool,
    #[serde(rename = "likeCount")]
    pub like_count: i64,
}

#[derive(Debug, sqlx::FromRow)]
pub struct CommentRow {
    pub id: Uuid,
    pub user_id: Uuid,
    pub user_name: String,
    pub advisor_rank: String,
    pub body: String,
    pub helpful_count: i32,
    pub is_top_advice: bool,
    pub created_at: DateTime<Utc>,
}

#[derive(Debug, Serialize)]
pub struct CommentJson {
    pub id: String,
    #[serde(rename = "postId", skip_serializing_if = "Option::is_none")]
    pub post_id: Option<String>,
    #[serde(rename = "userId")]
    pub user_id: String,
    pub name: String,
    #[serde(rename = "photoUrl", skip_serializing_if = "Option::is_none")]
    pub photo_url: Option<String>,
    #[serde(rename = "advisorRank")]
    pub advisor_rank: String,
    pub body: String,
    #[serde(rename = "helpfulCount")]
    pub helpful_count: i32,
    #[serde(rename = "isTopAdvice")]
    pub is_top_advice: bool,
    pub mine: bool,
    #[serde(rename = "createdAt")]
    pub created_at: String,
}

#[derive(Debug, Deserialize)]
pub struct CommentRequest {
    pub body: String,
}

// ---------------------------------------------------------------------------
// Advisors & Following
// ---------------------------------------------------------------------------

#[derive(Debug, sqlx::FromRow)]
pub struct AdvisorRow {
    pub user_id: Uuid,
    pub display_name: String,
    pub handle: String,
    pub rank_title: String,
    pub about: String,
    pub followers_count: i32,
    pub following_count: i32,
    pub advice_given_count: i32,
    pub helpful_rating: i32,
    pub recent_advice_quote: String,
    pub city: String,
    pub specialty: String,
    pub posts_count: i32,
    pub is_following: bool,
}

#[derive(Debug, Serialize)]
pub struct AdvisorPersonJson {
    pub id: String,
    pub name: String,
    pub handle: String,
    pub rank: String,
    pub bio: String,
    #[serde(rename = "photoUrl", skip_serializing_if = "Option::is_none")]
    pub photo_url: Option<String>,
    #[serde(rename = "followersCount")]
    pub followers_count: i32,
    #[serde(rename = "followingCount")]
    pub following_count: i32,
    #[serde(rename = "adviceGivenCount")]
    pub advice_given_count: i32,
    #[serde(rename = "helpfulPercent")]
    pub helpful_percent: i32,
    #[serde(rename = "isFollowing")]
    pub is_following: bool,
    #[serde(rename = "recentAdviceQuote")]
    pub recent_advice_quote: String,
    pub city: String,
    pub specialty: String,
    #[serde(rename = "postsCount")]
    pub posts_count: i32,
}

#[derive(Debug, Deserialize)]
pub struct AdvisorQuery {
    pub query: Option<String>,
    pub limit: Option<i64>,
}

#[derive(Debug, Serialize)]
pub struct FollowToggleResponse {
    #[serde(rename = "isFollowing")]
    pub is_following: bool,
    #[serde(rename = "followersCount")]
    pub followers_count: i32,
}

// ---------------------------------------------------------------------------
// Quick Notes (Stories Rail)
// ---------------------------------------------------------------------------

#[derive(Debug, sqlx::FromRow)]
pub struct QuickNoteRow {
    pub id: Uuid,
    pub user_id: Option<Uuid>,
    pub author: String,
    pub name: String,
    pub note: String,
    pub emoji: String,
    pub created_at: DateTime<Utc>,
}

#[derive(Debug, Serialize)]
pub struct QuickNoteJson {
    pub id: String,
    #[serde(rename = "userId", skip_serializing_if = "Option::is_none")]
    pub user_id: Option<String>,
    pub author: String,
    pub name: String,
    #[serde(rename = "authorPhotoUrl", skip_serializing_if = "Option::is_none")]
    pub author_photo_url: Option<String>,
    pub note: String,
    pub emoji: String,
    #[serde(rename = "isSelf")]
    pub is_self: bool,
}

#[derive(Debug, Deserialize)]
pub struct CreateQuickNoteRequest {
    pub note: String,
    pub emoji: Option<String>,
}

// ---------------------------------------------------------------------------
// Notifications
// ---------------------------------------------------------------------------

#[derive(Debug, sqlx::FromRow)]
pub struct NotificationRow {
    pub id: Uuid,
    pub user_id: Uuid,
    pub actor_id: Option<Uuid>,
    pub actor_name: String,
    pub actor_handle: String,
    pub r#type: String,
    pub text: String,
    pub post_id: Option<Uuid>,
    pub post_snippet: Option<String>,
    pub post_category: Option<String>,
    pub read: bool,
    pub confirmed: bool,
    pub created_at: DateTime<Utc>,
}

#[derive(Debug, Serialize)]
pub struct NotificationJson {
    pub id: String,
    pub r#type: String,
    #[serde(rename = "actorId", skip_serializing_if = "Option::is_none")]
    pub actor_id: Option<String>,
    #[serde(rename = "actorName")]
    pub actor_name: String,
    #[serde(rename = "actorPhotoUrl", skip_serializing_if = "Option::is_none")]
    pub actor_photo_url: Option<String>,
    #[serde(rename = "actorHandle")]
    pub actor_handle: String,
    pub text: String,
    pub time: String,
    pub read: bool,
    pub confirmed: bool,
    #[serde(rename = "postId", skip_serializing_if = "Option::is_none")]
    pub post_id: Option<String>,
    #[serde(rename = "postSnippet", skip_serializing_if = "Option::is_none")]
    pub post_snippet: Option<String>,
    #[serde(rename = "postCategory", skip_serializing_if = "Option::is_none")]
    pub post_category: Option<String>,
    pub section: String,
}

// ---------------------------------------------------------------------------
// Legacy Stubs & Safety
// ---------------------------------------------------------------------------

#[derive(Debug, Serialize)]
pub struct StoryJson {
    pub id: String,
    pub name: String,
    #[serde(rename = "photoUrl", skip_serializing_if = "Option::is_none")]
    pub photo_url: Option<String>,
    #[serde(rename = "isSelf", skip_serializing_if = "Option::is_none")]
    pub is_self: Option<bool>,
}

#[derive(Debug, Deserialize)]
pub struct DiscoverQuery {
    pub interest: Option<String>,
    pub limit: Option<i64>,
    pub offset: Option<i64>,
    pub max_km: Option<i32>,
    /// "friends" | "partner": only people open to that mode. Defaults to the viewer's intent.
    pub intent: Option<String>,
    pub city: Option<String>,
}

#[derive(Debug, Deserialize)]
pub struct ReportRequest {
    pub reason: String,
    pub details: Option<String>,
}

#[derive(Debug, Serialize)]
pub struct OkResponse {
    pub ok: bool,
}
