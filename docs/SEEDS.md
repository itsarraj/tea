# Database Seeds & Fixtures

The Tea platform maintains a multi-layered data strategy to ensure both rich local developer experiences (when running completely offline) and realistic database environments (when running the Postgres BFF backend).

---

## 1. SQL Migrations & Database Seeds (`bff/migrations/`)

PostgreSQL database schemas and seed datasets are managed via SQLx migrations executed in order:

- `001_auth_kit.sql`: Foundation auth tables (`auth.users`, `auth.refresh_tokens`, `auth.email_verifications`, `auth.password_resets`).
- `002_dating_profile_fields.sql`: User profile fields (bio, intent, birthday, location).
- `003_friendzy_dating.sql`: Core interaction tables (`dating.profiles`, `dating.photos`, `dating.swipes`, `dating.matches`, `dating.conversations`, `dating.messages`).
- `004_friendzy_real_users.sql`: Initial seed of diverse users with geographic profiles.
- `005_demo_seed.sql`: Primary demo seed containing 20+ profiles and demo conversations.
- `008_tea_dating_advice.sql`: Tea-specific tables (`dating.feed_posts`, `dating.feed_comments`, `dating.verdict_votes`, `dating.user_follows`, `dating.user_blocks`, `dating.user_reports`, `dating.quick_notes`, `dating.notifications`).
- `009_tea_seed_data.sql`: Seed dilemmas, advice posts, comment threads, and initial community advisors.
- `010_tea_advisor_photos.sql`: Seed photos specifically for prominent advisors (e.g. Maya, Jordan, Chloe, Marcus, Priya).
- `011_sanitize_media_urls.sql`: Media URL normalizer ensuring all photos point to reliable HTTPS sources.
- `012_verdict_votes_perf.sql`: Performance indices for fast count queries on post verdicts.
- `013_sanitize_advisor_photos.sql`: Photo sanitizer ensuring advisors have active photo rows in `dating.photos` with correct sort orders.
- `014_backfill_profile_handles.sql`: Backfill script ensuring every user profile has a unique `@handle`.
- `015_connected_mock_data.sql`: Connected logical mock dataset across profiles, photos, 10 official feed categories, verdict votes, comments, advisors leaderboard, stories/quick notes, mutual matches, multi-turn chat threads, and interactive notifications.
- `016_seed_playstore_reviewer.sql`: Dedicated Google Play Store QA Reviewer account seed (`playstore@teadating.app` / `TeaReview2026!`). Pre-loads 4 HD photos, 4 consultations (including consultation requests), 11 dialogue messages, 5 interactive notifications, 2 authored dilemmas with full comment threads & verdict votes, fresh 24h stories, and full follow relationships.

---

## 2. Test Accounts for App QA

| Account | Password | User ID | Handle | Role / Purpose |
|---|---|---|---|---|
| `marina@teadating.app` | `demo1234` | `00000000-0000-0000-0000-000000000001` | `@Marina_Jose` | **Primary Test User** (Top Advisor 🏆, 5 photos, 6 matches, 6 conversations, 15 notifications) |
| `jack@teadating.app` | `demo1234` | `00000000-0000-0000-0000-000000000002` | `@Jack.James` | Senior Advisor ★ (Texting Psychology) |
| `sylvia@teadating.app` | `demo1234` | `00000000-0000-0000-0000-000000000003` | `@Sylvia_A` | Tea Master 🫖 (Relationship Therapist) |
| `jessica@teadating.app` | `demo1234` | `00000000-0000-0000-0000-000000000005` | `@Jessica_09` | Dating Strategist ✨ (Situationships Coach) |
| `playstore@teadating.app` | `TeaReview2026!` | `00000000-0000-0000-0000-000000000099` | `@PlayReviewer` | Google Play Store QA Review Account |

## 3. Running Migrations

To apply pending migrations to the local PostgreSQL instance:

```bash
cd apps/tea/bff
export DATABASE_URL="postgres://postgres:postgres@localhost:5432/tea_bff"
sqlx migrate run
```

---

## 4. Client Offline Fixture Fallback (`app/lib/fixtures.ts`)

To ensure seamless frontend development even when the backend is offline:
- If the BFF server at `http://127.0.0.1:8000` is unreachable, `app/lib/fixture-mode.ts` automatically activates Offline Demo Mode.
- `app/lib/fixtures.ts` serves local in-memory datasets (`DEMO_FEED`, `DEMO_ADVISORS`, `DEMO_STORIES`, `DEMO_COMMENTS`, `DEMO_CONVERSATIONS`).
- The `OfflineBanner` alerts the user whenever offline fixture mode is active.
- All domain entity types are defined in `app/types/index.ts` and imported cleanly into both API hooks and fixture files.
