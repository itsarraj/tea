# Tea Architecture

Expo Router client + Actix-web BFF over PostgreSQL (schemas `auth`, `dating`) with optional Redis.
A neo-brutalist dating advice platform centered on crowd-sourced dilemma verdicts, top advisors, and text-only privacy.

## Layout

- `bff/src/module/auth`: register/login/refresh/logout, email verify, password reset, Google OAuth, phone OTP
- `bff/src/module/dating`: profiles, dilemmas, verdict voting (🚩 Red / 💚 Green / ⚖️ Valid), advisors, 1-on-1 consultations, stories, bookmarks, blocks/reports, account deletion
- `bff/src/module/legal`: privacy, terms, safety standards, delete-account (returns styled neo-brutalist HTML)
- `bff/src/module/{storage,sms,push,email}`: provider adapters, all config-gated for zero-credential local dev
- `bff/src/middleware`: JWT extractor with jti blacklist, fixed-window rate limiter, CORS
- `app/app`: Expo Router routes; `(app)/` is the authenticated group with neo-brutalist bottom navigation
- `app/services`: fetch wrappers (`authApi`, `datingApi`), `app/hooks`: TanStack Query hooks, `app/components/tea`: neo-brutalist UI components

## Data Model (migrations 001 - 009)

- `auth.users`: Core identity (id, email, password_hash, name, handle, birthday, phone, email_verified, is_banned)
- `dating.profiles`: Extended profile: handle, rank_title, followers_count, following_count, posts_count, helpful_rating, specialty, recent_advice_quote, avatar_seed, onboarding_complete, last_active_at
- `dating.feed_posts`: Dilemma posts with categories (`🚩 Red Flags`, `☕ First Date`, `🤔 Am I Overreacting?`, `📱 Texting Rules`, `👻 Ghosted`, etc.), title, question, red_flags count, green_flags count, valid_count, helpful_count
- `dating.post_verdicts`: User verdict votes (`red`, `green`, `valid`) with unique constraint per `(post_id, user_id)`
- `dating.post_saves`: Bookmarked dilemma posts
- `dating.post_comments`: Community advice comments on dilemma posts
- `dating.advisor_follows`: Advisor follower relationships
- `dating.conversations` & `dating.messages`: 1-on-1 private advisor consultations
- `dating.blocks` & `dating.reports`: Safety moderation flags
- `dating.notifications`: Activity alerts (new verdicts, advice comments, follows)

## Design System & Neo-Brutalist Visual Tokens

- **Canvas / Background**: `#ECE6C2`
- **Mint Accent**: `#73BDA8`
- **Terracotta / Coral**: `#CC6B49`
- **Electric Blue**: `#0EA8FF`
- **High-Contrast Ink**: `#020202`
- **Card Surface**: `#FFFFFF` or `#FAF8ED`
- **Borders**: 2px or 3px solid `#020202` with 0px corner radii (`rounded-[2px]`) and hard drop shadows (`shadowOffset: { width: -3, height: 3 }, shadowOpacity: 1, shadowRadius: 0`)
- **Avatars**: Procedural 5x5 SVG pixel blocks generated deterministically from user seed/handle (`BrutalistAvatar.tsx`), avoiding all photo access

## API Surface (`/api/v1`)

- **Auth**: `POST /auth/{register,login,refresh,logout,phone/start,phone/verify,google,password-reset,password-reset/confirm}`, `GET /auth/google`, `GET /auth/google/callback`, `GET|POST /auth/verify-email`.
- **User / Self**: `GET|PATCH /user/profile`, `POST /user/change-password`, `GET /user/me`, `DELETE /user/me`, `GET /user/blocked`, `POST|DELETE /user/devices`.
- **Feed & Dilemmas**: `GET /feed` (filter by category / mode), `POST /feed`, `GET /feed/{id}`, `POST /feed/{id}/vote` (`verdict: "red" | "green" | "valid"`), `POST /feed/{id}/like`, `POST /feed/{id}/save`, `GET|POST /feed/{id}/comments`.
- **Advisors**: `GET /advisors` (ordered by helpfulness / rank), `GET /advisors/{id}`, `POST /advisors/{id}/follow`.
- **Consultations**: `GET /messages/conversations`, `GET|POST /messages/conversations/{id}`.
- **Safety**: `POST|DELETE /users/{id}/block`, `POST /users/{id}/report`.
- **Legal**: `GET /legal/privacy`, `GET /legal/terms`, `GET /legal/safety`, `GET /legal/delete-account` (also available directly at root `/privacy`, `/terms`, `/safety`, `/delete-account`).
- **Health**: `GET /health`.

## Google Play Compliance Guardrails

1. **Strict 18+ Adult Policy**: Birthday validation enforces age >= 18 on registration (`register.tsx`), onboarding (`onboarding.tsx`), and BFF (`auth/service.rs`).
2. **Text-Only Architecture**: Zero `READ_MEDIA_IMAGES` or `READ_MEDIA_VIDEO` permissions. Blocked in `app.config.js` and `AndroidManifest.xml`.
3. **Public Legal Endpoints**: `/privacy`, `/delete-account`, `/safety` return HTTP 200 via Actix BFF and Nginx reverse proxy.
4. **Pre-Seeded Reviewer Account**: `playstore@teadating.app` / `TeaReview2026!` seeded in migration `009`.

