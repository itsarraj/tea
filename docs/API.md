# Tea BFF API Contract

This document specifies the REST and WebSocket endpoints provided by the Tea Backend-For-Frontend (BFF) service running on Rust Actix-web.

Base URL: `http://127.0.0.1:8000/api/v1` (via ADB reverse or network host)

---

## 1. Authentication (`/api/v1/auth`)

| Method | Endpoint | Description | Auth Required |
|---|---|---|---|
| `POST` | `/auth/register` | Register new account with email, password, full name, birthday | No |
| `POST` | `/auth/login` | Authenticate with email/password; returns access + refresh JWTs | No |
| `POST` | `/auth/refresh` | Rotate access token using valid refresh token | No (Bearer refresh) |
| `POST` | `/auth/logout` | Revoke session refresh token | Yes |
| `POST` | `/auth/verify-email` | Request email verification OTP/link | Yes |
| `GET` | `/auth/verify-email/{token}` | Verify user email address | No |
| `POST` | `/auth/password-reset` | Initiate forgot password email | No |
| `POST` | `/auth/password-reset/confirm` | Confirm password reset with token | No |
| `GET` | `/auth/google` | OAuth start redirect for web | No |
| `POST` | `/auth/google` | Exchange Google ID token for Tea JWT pair | No |
| `GET` | `/auth/google/callback` | OAuth callback handler | No |
| `POST` | `/auth/phone/start` | Request SMS verification code | No |
| `POST` | `/auth/phone/verify` | Verify SMS OTP and complete login | No |

---

## 2. User & Profile (`/api/v1/user`)

| Method | Endpoint | Description | Auth Required |
|---|---|---|---|
| `GET` | `/user/me` | Fetch authenticated user summary (profile, badges, stats) | Yes |
| `DELETE` | `/user/me` | Permanently delete account and all user data | Yes |
| `POST` | `/user/change-password` | Update account password | Yes |
| `GET` | `/user/profile` | Fetch user's dating & advisor profile details | Yes |
| `PATCH` | `/user/profile` | Update profile bio, handle, intent, tags, age, city | Yes |
| `POST` | `/user/profile/location` | Update geo-coordinates (latitude, longitude) | Yes |
| `POST` | `/user/profile/photos` | Upload a new profile photo (multipart/form-data) | Yes |
| `POST` | `/user/profile/photos/reorder` | Reorder profile photos array | Yes |
| `DELETE` | `/user/profile/photos/{id}` | Delete photo by ID | Yes |
| `POST` | `/user/devices` | Register Expo push notification token | Yes |
| `DELETE` | `/user/devices` | Unregister push token | Yes |
| `GET` | `/user/blocked` | List users blocked by current account | Yes |

---

## 3. Feed & Dating Advice (`/api/v1/feed`)

| Method | Endpoint | Description | Auth Required |
|---|---|---|---|
| `GET` | `/feed?page={p}&limit={n}&category={c}` | Fetch paginated feed posts with photos, author, verdict counts | Yes |
| `POST` | `/feed` | Create new dilemma / story post with category and images | Yes |
| `GET` | `/feed/{id}` | Fetch individual feed post by ID | Yes |
| `POST` | `/feed/{id}/like` | Toggle like reaction on post | Yes |
| `POST` | `/feed/{id}/vote` | Cast verdict vote (`red_flag`, `green_flag`, `overreacting`, `run`) | Yes |
| `POST` | `/feed/{id}/save` | Toggle bookmark/saved status on post | Yes |
| `GET` | `/feed/{id}/comments` | List comments and quick reactions for post | Yes |
| `POST` | `/feed/{id}/comments` | Add comment with optional verdict tag and emoji | Yes |

---

## 4. Advisors & Community (`/api/v1/advisors`)

| Method | Endpoint | Description | Auth Required |
|---|---|---|---|
| `GET` | `/advisors` | List top community advisors, badges, rankings, verified photos | Yes |
| `GET` | `/advisors/{id}` | Get public profile for advisor / user | Yes |
| `POST` | `/advisors/{id}/follow` | Toggle following status on an advisor | Yes |

---

## 5. Stories & Quick Notes (`/api/v1/stories`)

| Method | Endpoint | Description | Auth Required |
|---|---|---|---|
| `GET` | `/stories` | List active 24-hour quick notes & status updates | Yes |
| `POST` | `/stories` | Post ephemeral 24-hour note with emoji | Yes |

---

## 6. Discover & Swiping (`/api/v1/discover`, `/api/v1/swipe`)

| Method | Endpoint | Description | Auth Required |
|---|---|---|---|
| `GET` | `/discover/nearby` | Discover nearby prospective matches | Yes |
| `GET` | `/discover/people/{id}` | Fetch detailed person profile for dating deck | Yes |
| `POST` | `/swipe` | Submit swipe decision (`like`, `pass`, `superlike`) | Yes |
| `GET` | `/likes` | List profiles who liked current user | Yes |
| `GET` | `/matches` | List mutual matches | Yes |
| `DELETE` | `/matches/{id}` | Unmatch with user | Yes |

---

## 7. Messaging & WebSockets (`/api/v1/messages`, `/api/v1/ws`)

| Method | Endpoint | Description | Auth Required |
|---|---|---|---|
| `GET` | `/messages/conversations` | List user conversation threads with last message & unread badge | Yes |
| `GET` | `/messages/conversations/{id}` | Fetch conversation chat history | Yes |
| `POST` | `/messages/conversations/{id}` | Send direct message | Yes |
| `GET` | `/ws?token={jwt}` | Real-time WebSocket connection for live chats & typing | Yes |

---

## 8. Moderation & Safety

| Method | Endpoint | Description | Auth Required |
|---|---|---|---|
| `POST` | `/users/{id}/block` | Block user | Yes |
| `DELETE` | `/users/{id}/block` | Unblock user | Yes |
| `POST` | `/users/{id}/report` | Report user with violation reason | Yes |
| `GET` | `/notifications` | List user notifications (verdicts, followers, comments) | Yes |
| `POST` | `/notifications/{id}/confirm` | Confirm / accept follow request | Yes |
| `DELETE` | `/notifications/{id}` | Dismiss notification | Yes |
