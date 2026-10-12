# Tea Expo Router Tree

The Tea mobile application uses Expo Router file-based routing located in `app/app/`.

---

## 1. Root & Splash Navigation (`app/app/`)

- `_layout.tsx`: Root application shell. Configures fonts (`HankenGrotesk`), React Query client provider, Auth context provider, system UI navigation bar color (`#ECE6C2`), and global Stack navigator.
- `index.tsx`: Initial entry routing gate. Checks authentication token status:
  - If authenticated, redirects to `/(app)`.
  - If unauthenticated, redirects to `/welcome`.
- `welcome.tsx`: Public landing screen showcasing the Tea branding, value proposition, and login/register calls-to-action.
- `login.tsx`: Email and password authentication screen with Google OAuth and remember-me toggles.
- `register.tsx`: Registration screen with birthday age-gate picker (18+ verification) and full name entry.
- `onboarding.tsx`: Profile setup flow (bio, dating intents, avatar photo upload).
- `reset-password.tsx`: Forgot password request and confirmation screen.
- `verify-email/[token].tsx`: Deep link target for email confirmation tokens.
- `auth/google/callback.tsx`: OAuth callback redirect handler.

---

## 2. Authenticated App Flow (`app/app/(app)/`)

- `_layout.tsx`: Authenticated app layout with `TeaTabBar` bottom navigation bar and offline connectivity listener.
- `index.tsx`: Main community feed tab. Renders horizontal category filter pills, quick notes rail, and brutalist story dilemma cards.
- `search.tsx`: Search & discover tab. Find advice topics, people, and keywords.
- `advisors.tsx`: Advisors leaderboard tab. Shows top community council members, badges, follower counts, and follow actions.
- `messages.tsx`: Direct messages & conversations list with active matches and chat previews.
- `me.tsx`: Current user's profile view with photo carousel, follower statistics, and profile edit launcher.

### Sub-routes & Detail Screens

- `chat/[id].tsx`: Real-time chat screen between matched users or advisors with WebSocket integration.
- `post/[id].tsx`: Full post details view with interactive verdict voting bar, quick emojis, and comment thread.
- `new-post.tsx` / `create.tsx`: Compose dilemma post screen with photo attachment and category selection.
- `profile/[id].tsx`: Public user/advisor profile view with photo gallery, bio, and follow toggle.
- `edit-profile.tsx`: Edit profile details, bio, photo reordering/upload, and age verification.
- `notifications.tsx`: Activity center with follow requests, verdict alerts, and mentions.
- `settings.tsx`: App preferences, notification toggles, haptics, and sign-out controls.
- `preferences.tsx`: Dating discovery filters (age range, distance, intents).
- `blocked.tsx`: Management screen for blocked user accounts.
- `change-password.tsx`: Change account security credentials.
