# Client State & TanStack Query Architecture

The Tea mobile application strictly adheres to Pillar 1 and Pillar 9 of `PRE_DEV_GUIDE.md`:
- **Server State**: Owned exclusively by TanStack Query (`@tanstack/react-query`).
- **Auth Tokens**: Owned exclusively by `expo-secure-store` via `lib/auth-storage.ts`.
- **UI Settings & Preferences**: Decoupled from SecureStore, managed via synchronous in-memory state with file persistence (`lib/settings-storage.ts`).

---

## 1. Query Keys Registry

All TanStack Query keys are array literals organized by domain:

| Domain | Query Key | Hook | Invalidation Triggers |
|---|---|---|---|
| User Profile | `['dating', 'me']` | `useMyProfile()` | Profile patch, photo upload/delete/reorder |
| Community Feed | `['dating', 'feed', category]` | `useFeed(category)` | New post submission, post deletion |
| Post Details | `['dating', 'feed', id]` | `useFeedPost(id)` | Verdict vote, post like, bookmark toggle |
| Post Comments | `['dating', 'feed', id, 'comments']` | `useFeedComments(id)` | Comment submission |
| Advisors | `['dating', 'advisors']` | `useAdvisors()` | Follow / unfollow toggle |
| Advisor Profile | `['dating', 'advisors', id]` | `useAdvisorProfile(id)` | Follow / unfollow toggle |
| Stories / Notes | `['dating', 'stories']` | `useStories()` | Quick note submission |
| Notifications | `['dating', 'notifications']` | `useNotifications()` | Confirm follow, notification dismissal |
| Blocked Users | `['dating', 'blocked']` | `useBlockedUsers()` | Block / unblock actions |
| App Settings | `['appSettings']` | `useAppSettings()` | Settings toggle mutation |

---

## 2. Optimistic Updates & Cache Mutations

### Verdict Voting (`useVoteVerdict`)
When a user votes on a dilemma (`red_flag`, `green_flag`, `overreacting`, `run`):
1. Optimistically increments the target verdict count on the cached post.
2. Updates `userVote` to the selected key.
3. If the network request fails, rolls back to previous cache snapshot.

### Post Likes & Bookmarks
Optimistic toggling for instant visual response, followed by background synchronization with the BFF.

### Follow Actions (`useToggleFollow`)
Optimistically flips the `isFollowing` state and updates advisor follower count in both the advisors list and detail profile queries.

---

## 3. Storage Separation Rules

- **SecureStore**: Only contains `tea_access`, `tea_refresh`, and `tea_remember_email`.
- **No Large Blobs in SecureStore**: Never store feed posts, advisor lists, or complex settings in SecureStore (avoids Android Keystore 2KB hardware limit and bridge serialization latency).
- **Settings Storage**: Uses synchronous in-memory read cache initialized once at startup and persisted asynchronously to disk via `expo-file-system`.
