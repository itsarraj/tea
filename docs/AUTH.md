# Authentication Architecture & Lifecycle

This document describes the token lifecycle, security boundaries, and 401 latch queue mechanism implemented in the Tea mobile client and BFF.

---

## 1. Token Strategy & Bifurcation

- **Access Token**: Short-lived JWT (typically 15 minutes). Sent in the `Authorization: Bearer <token>` HTTP header with every authenticated request.
- **Refresh Token**: Long-lived rotating token (30 days). Stored encrypted in device hardware via `expo-secure-store`.
- **Storage Isolation**: Tokens are strictly stored under `tea_access` and `tea_refresh` keys. Legacy vendor keys (`palora_*`) are completely eliminated.

---

## 2. The 401 Single-Flight Latch Queue

To prevent race conditions where multiple parallel requests fail with 401 and attempt simultaneous token refreshes:

```
[Request 1 (401)] ──┐
[Request 2 (401)] ──┼──> [401 Latch Lock] ──> Single POST /api/v1/auth/refresh
[Request 3 (401)] ──┘             │
                                  ▼ (Success: New Access Token)
                            Replay Request 1 with new token
                            Replay Request 2 with new token
                            Replay Request 3 with new token
```

### Implementation (`app/lib/auth-api.ts`)
1. When any API call receives HTTP 401, it enters the refresh latch.
2. If a refresh is already in flight, subsequent failing requests enqueue a pending Promise resolving once the active refresh completes.
3. If the refresh request succeeds:
   - The new token pair is stored in SecureStore.
   - All queued requests retry with the refreshed token.
4. If the refresh fails (e.g., token expired or revoked):
   - Tokens are cleared from SecureStore via `clearTokens()`.
   - The user session is invalidated, transitioning the app to the `/welcome` login screen.

---

## 3. Account Deletion & Security Safeguards

Per Google Play Store requirements:
- Users can delete their account directly within the app (`Settings -> Delete Account`) or via a public web form (`/api/v1/legal/delete-account`).
- Deletion cascades across `auth.users`, `dating.profiles`, `dating.photos`, `dating.feed_posts`, `dating.feed_comments`, and `dating.messages`.
