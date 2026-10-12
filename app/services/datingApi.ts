import { apiUrl } from '@/constants/config';
import { getAccessToken } from '@/lib/auth-storage';
import { apiRequest } from '@/services/authApi';
import type {
  AdvisorPerson,
  ChatMessage,
  ConversationItem,
  FeedComment,
  FeedPost,
  MyProfile,
  NotificationItem,
  Person,
  Photo,
  StoryItem,
} from '@/lib/fixtures';
import {
  FIXTURE_ADVISORS,
  FIXTURE_COMMENTS,
  FIXTURE_CONVERSATIONS,
  FIXTURE_FEED,
  FIXTURE_MESSAGES,
  FIXTURE_NOTES,
  FIXTURE_NOTIFICATIONS,
  FIXTURE_PROFILE,
  interestText,
} from '@/lib/fixtures';
import { isNetworkError, setFixtureMode } from '@/lib/fixture-mode';

export type { ChatMessage };

export type PatchProfileBody = Partial<{
  display_name: string;
  handle: string;
  gender: string;
  looking_for: string[];
  intent: string;
  birthday: string;
  city: string;
  country: string;
  about: string;
  interests: string[];
  specialty: string;
  recent_advice_quote: string;
  min_age: number;
  max_age: number;
  max_distance_km: number;
  lat: number;
  lng: number;
  complete_onboarding: boolean;
}>;

// In-memory state for responsive offline interactions
let localFeed: FeedPost[] = [...FIXTURE_FEED];
let localAdvisors: AdvisorPerson[] = [...FIXTURE_ADVISORS];
let localComments: Record<string, FeedComment[]> = { ...FIXTURE_COMMENTS };
let localConversations: ConversationItem[] = [...FIXTURE_CONVERSATIONS];
let localMessages: Record<string, ChatMessage[]> = { ...FIXTURE_MESSAGES };
let localNotifications: NotificationItem[] = [...FIXTURE_NOTIFICATIONS];
let localProfile: MyProfile = { ...FIXTURE_PROFILE };

async function withFixtureFallback<T>(fn: () => Promise<T>, fixture: () => T): Promise<T> {
  try {
    const out = await fn();
    setFixtureMode(false);
    return out;
  } catch (e) {
    if (__DEV__ && isNetworkError(e)) {
      setFixtureMode(true, e instanceof Error ? e.message : 'network');
      return fixture();
    }
    throw e;
  }
}

function qs(params: Record<string, string | number | undefined | null>): string {
  const parts = Object.entries(params)
    .filter(([, v]) => v !== undefined && v !== null && v !== '')
    .map(([k, v]) => `${encodeURIComponent(k)}=${encodeURIComponent(String(v))}`);
  return parts.length ? `?${parts.join('&')}` : '';
}

const UUID_REGEX = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;
const LEGACY_POST_MAP: Record<string, string> = {
  'post-1': 'a0000000-0000-0000-0000-000000000001',
  'post-2': 'a0000000-0000-0000-0000-000000000002',
  'post-3': 'a0000000-0000-0000-0000-000000000003',
  'post-4': 'a0000000-0000-0000-0000-000000000004',
  'post-5': 'a0000000-0000-0000-0000-000000000005',
};

function resolvePostId(id: string): string {
  return LEGACY_POST_MAP[id] || id;
}

const LEGACY_ADVISOR_MAP: Record<string, string> = {
  'adv-1': '00000000-0000-0000-0000-000000000001',
  'adv-2': '00000000-0000-0000-0000-000000000002',
  'adv-3': '00000000-0000-0000-0000-000000000003',
  'adv-4': '00000000-0000-0000-0000-000000000004',
  'adv-5': '00000000-0000-0000-0000-000000000005',
  'adv-6': '00000000-0000-0000-0000-000000000006',
  'adv-7': '00000000-0000-0000-0000-000000000007',
  'adv-8': '00000000-0000-0000-0000-000000000008',
  'adv-9': '00000000-0000-0000-0000-000000000009',
  'adv-10': '00000000-0000-0000-0000-000000000010',
  'user-michael': '00000000-0000-0000-0000-000000000007',
  'user-maria': '00000000-0000-0000-0000-000000000008',
  'user-liz': '00000000-0000-0000-0000-000000000009',
  'user-emily': '00000000-0000-0000-0000-000000000010',
  'me-user': '00000000-0000-0000-0000-000000000001',
};

const REVERSE_ADVISOR_MAP: Record<string, string> = {
  '00000000-0000-0000-0000-000000000001': 'adv-1',
  '00000000-0000-0000-0000-000000000002': 'adv-2',
  '00000000-0000-0000-0000-000000000003': 'adv-3',
  '00000000-0000-0000-0000-000000000004': 'adv-4',
  '00000000-0000-0000-0000-000000000005': 'adv-5',
  '00000000-0000-0000-0000-000000000006': 'adv-6',
  '00000000-0000-0000-0000-000000000007': 'adv-7',
  '00000000-0000-0000-0000-000000000008': 'adv-8',
  '00000000-0000-0000-0000-000000000009': 'adv-9',
  '00000000-0000-0000-0000-000000000010': 'adv-10',
};

function resolveAdvisorId(id: string): string {
  return LEGACY_ADVISOR_MAP[id] || id;
}

const LEGACY_CONVERSATION_MAP: Record<string, string> = {
  'conv-1': 'd0000000-0000-0000-0000-000000000001',
  'conv-2': 'd0000000-0000-0000-0000-000000000002',
  'conv-3': 'd0000000-0000-0000-0000-000000000003',
  'conv-4': 'd0000000-0000-0000-0000-000000000004',
  'conv-5': 'd0000000-0000-0000-0000-000000000005',
  'conv-6': 'd0000000-0000-0000-0000-000000000006',
  'conv-7': 'd0000000-0000-0000-0000-000000000007',
  'conv-8': 'd0000000-0000-0000-0000-000000000008',
  'conv-9': 'd0000000-0000-0000-0000-000000000009',
};

const REVERSE_CONVERSATION_MAP: Record<string, string> = {
  'd0000000-0000-0000-0000-000000000001': 'conv-1',
  'd0000000-0000-0000-0000-000000000002': 'conv-2',
  'd0000000-0000-0000-0000-000000000003': 'conv-3',
  'd0000000-0000-0000-0000-000000000004': 'conv-4',
  'd0000000-0000-0000-0000-000000000005': 'conv-5',
  'd0000000-0000-0000-0000-000000000006': 'conv-6',
  'd0000000-0000-0000-0000-000000000007': 'conv-7',
  'd0000000-0000-0000-0000-000000000008': 'conv-8',
  'd0000000-0000-0000-0000-000000000009': 'conv-9',
};

function resolveConversationId(id: string): string {
  return LEGACY_CONVERSATION_MAP[id] || LEGACY_ADVISOR_MAP[id] || id;
}

export const datingApi = {
  // ---- self -------------------------------------------------------------
  profile: () =>
    withFixtureFallback(() => apiRequest<MyProfile>('/user/profile'), () => localProfile),

  patchProfile: async (body: PatchProfileBody) => {
    try {
      const res = await apiRequest<MyProfile>('/user/profile', {
        method: 'PATCH',
        body: JSON.stringify(body),
      });
      localProfile = { ...localProfile, ...res };
      return res;
    } catch (e) {
      if (__DEV__ && isNetworkError(e)) {
        localProfile = {
          ...localProfile,
          display_name: body.display_name ?? localProfile.display_name,
          handle: body.handle ?? localProfile.handle,
          about: body.about ?? localProfile.about,
          city: body.city ?? localProfile.city,
          country: body.country ?? localProfile.country,
          gender: body.gender ?? localProfile.gender,
          birthday: body.birthday ?? localProfile.birthday,
          interests: body.interests ?? localProfile.interests,
          onboarding_complete:
            body.complete_onboarding !== undefined
              ? body.complete_onboarding
              : localProfile.onboarding_complete,
        };
        return localProfile;
      }
      throw e;
    }
  },

  setLocation: (lat: number, lng: number, city?: string) =>
    apiRequest<MyProfile>('/user/profile/location', {
      method: 'POST',
      body: JSON.stringify({ lat, lng, city }),
    }).catch((e) => {
      if (__DEV__ && isNetworkError(e)) {
        localProfile = { ...localProfile, lat, lng, city: city || localProfile.city };
        return localProfile;
      }
      throw e;
    }),

  deleteAccount: () => apiRequest<{ ok: boolean }>('/user/me', { method: 'DELETE' }),

  registerDevice: (token: string, platform: string) =>
    apiRequest<{ ok: boolean }>('/user/devices', { method: 'POST', body: JSON.stringify({ token, platform }) }),

  unregisterDevice: (token: string) =>
    apiRequest<{ ok: boolean }>('/user/devices', { method: 'DELETE', body: JSON.stringify({ token }) }),

  blockedUsers: () =>
    withFixtureFallback(() => apiRequest<Person[]>('/user/blocked'), () => []),

  // ---- feed & advice ----------------------------------------------------
  feed: (
    opts: {
      category?: string;
      query?: string;
      cursor?: string;
      limit?: number;
      mode?: string;
      author_id?: string;
      authorId?: string;
      saved?: boolean;
    } = {},
  ) =>
    withFixtureFallback(
      () =>
        apiRequest<FeedPost[]>(
          `/feed${qs({
            category: opts.category,
            query: opts.query,
            cursor: opts.cursor,
            limit: opts.limit,
            mode: opts.mode,
            author_id: opts.author_id ?? opts.authorId,
            saved: opts.saved ? 'true' : undefined,
          })}`,
        ),
      () => {
        let items = [...localFeed];
        if (opts.category && opts.category !== 'All') {
          const cat = interestText(opts.category).toLowerCase();
          items = items.filter((p) => p.category.toLowerCase().includes(cat));
        }
        if (opts.query && opts.query.trim()) {
          const terms = opts.query.toLowerCase().trim().split(/\s+/).filter(Boolean);
          items = items.filter((p) => {
            const combined = `${p.title} ${p.question} ${p.author} ${p.authorHandle || ''} ${p.category}`.toLowerCase();
            return terms.every((t) => combined.includes(t));
          });
        }
        const aid = opts.author_id ?? opts.authorId;
        if (aid) {
          items = items.filter((p) => p.authorId === aid);
        }
        if (opts.saved) {
          items = items.filter((p) => p.savedByMe);
        }
        return items;
      },
    ),

  post: async (id: string) => {
    if (!id) throw new Error('Post ID required');
    const targetId = resolvePostId(id);
    if (UUID_REGEX.test(targetId)) {
      try {
        const p = await apiRequest<FeedPost>(`/feed/${targetId}`);
        setFixtureMode(false);
        return p;
      } catch (e) {
        // Fall through to local fallback
      }
    }
    const found = localFeed.find((p) => p.id === targetId || p.id === id);
    if (found) return found;
    throw new Error('Post not found');
  },

  createPost: async (body: { title: string; category: string; question: string }) => {
    try {
      return await apiRequest<FeedPost>('/feed', { method: 'POST', body: JSON.stringify(body) });
    } catch (e) {
      if (__DEV__ && isNetworkError(e)) {
        const newPost: FeedPost = {
          id: `post-${Date.now()}`,
          title: body.title,
          category: body.category,
          question: body.question,
          mode: 'advice',
          author: localProfile.display_name,
          authorId: localProfile.user_id,
          authorHandle: localProfile.handle,
          authorRank: localProfile.rankTitle,
          authorFollowers: localProfile.followersCount,
          city: localProfile.city || 'Online',
          likeCount: 1,
          commentCount: 0,
          helpfulCount: 0,
          likedByMe: false,
          followedByMe: false,
          savedByMe: false,
          redFlagCount: 0,
          greenFlagCount: 0,
          validCount: 0,
          createdAt: new Date().toISOString(),
        };
        localFeed = [newPost, ...localFeed];
        localProfile.postsCount += 1;
        return newPost;
      }
      throw e;
    }
  },

  toggleLike: async (postId: string) => {
    const targetId = resolvePostId(postId);
    if (UUID_REGEX.test(targetId)) {
      try {
        return await apiRequest<{ liked: boolean; likeCount: number }>(`/feed/${targetId}/like`, { method: 'POST' });
      } catch (e) {
        if (!__DEV__ && !isNetworkError(e)) throw e;
      }
    }
    const idx = localFeed.findIndex((p) => p.id === targetId || p.id === postId);
    if (idx !== -1) {
      const post = localFeed[idx];
      const liked = !post.likedByMe;
      post.likedByMe = liked;
      post.likeCount += liked ? 1 : -1;
      return { liked, likeCount: post.likeCount };
    }
    return { liked: true, likeCount: 1 };
  },

  toggleSave: async (postId: string) => {
    const targetId = resolvePostId(postId);
    if (UUID_REGEX.test(targetId)) {
      try {
        return await apiRequest<{ saved: boolean }>(`/feed/${targetId}/save`, { method: 'POST' });
      } catch (e) {
        if (!__DEV__ && !isNetworkError(e)) throw e;
      }
    }
    const idx = localFeed.findIndex((p) => p.id === targetId || p.id === postId);
    if (idx !== -1) {
      localFeed[idx].savedByMe = !localFeed[idx].savedByMe;
      return { saved: localFeed[idx].savedByMe };
    }
    return { saved: true };
  },

  voteVerdict: async (postId: string, vote: 'red' | 'green' | 'valid') => {
    const targetId = resolvePostId(postId);
    if (UUID_REGEX.test(targetId)) {
      try {
        const res = await apiRequest<{
          redFlagCount: number;
          greenFlagCount: number;
          validCount: number;
          userVote: 'red' | 'green' | 'valid' | null;
        }>(`/feed/${targetId}/vote`, {
          method: 'POST',
          body: JSON.stringify({ vote }),
        });
        const idx = localFeed.findIndex((p) => p.id === targetId || p.id === postId);
        if (idx !== -1) {
          localFeed[idx].redFlagCount = res.redFlagCount;
          localFeed[idx].greenFlagCount = res.greenFlagCount;
          localFeed[idx].validCount = res.validCount;
          localFeed[idx].userVote = res.userVote;
        }
        return res;
      } catch (e) {
        if (!__DEV__ && !isNetworkError(e)) throw e;
      }
    }
    const idx = localFeed.findIndex((p) => p.id === targetId || p.id === postId);
    if (idx !== -1) {
      const p = localFeed[idx];
      if (p.userVote === vote) {
        // Toggle off
        if (vote === 'red' && p.redFlagCount) p.redFlagCount -= 1;
        if (vote === 'green' && p.greenFlagCount) p.greenFlagCount -= 1;
        if (vote === 'valid' && p.validCount) p.validCount -= 1;
        p.userVote = null;
      } else {
        if (p.userVote === 'red' && p.redFlagCount) p.redFlagCount -= 1;
        if (p.userVote === 'green' && p.greenFlagCount) p.greenFlagCount -= 1;
        if (p.userVote === 'valid' && p.validCount) p.validCount -= 1;

        if (vote === 'red') p.redFlagCount = (p.redFlagCount || 0) + 1;
        if (vote === 'green') p.greenFlagCount = (p.greenFlagCount || 0) + 1;
        if (vote === 'valid') p.validCount = (p.validCount || 0) + 1;
        p.userVote = vote;
      }
      return {
        redFlagCount: p.redFlagCount,
        greenFlagCount: p.greenFlagCount,
        validCount: p.validCount,
        userVote: p.userVote,
      };
    }
    return { redFlagCount: 0, greenFlagCount: 0, validCount: 0, userVote: vote };
  },

  comments: async (postId: string) => {
    const targetId = resolvePostId(postId);
    if (UUID_REGEX.test(targetId)) {
      try {
        const comments = await apiRequest<FeedComment[]>(`/feed/${targetId}/comments`);
        setFixtureMode(false);
        return comments;
      } catch (e) {
        // Fall back to localComments
      }
    }
    return localComments[targetId] || localComments[postId] || [];
  },

  addComment: async (postId: string, body: string) => {
    const targetId = resolvePostId(postId);
    if (UUID_REGEX.test(targetId)) {
      try {
        return await apiRequest<FeedComment>(`/feed/${targetId}/comments`, { method: 'POST', body: JSON.stringify({ body }) });
      } catch (e) {
        if (!__DEV__ && !isNetworkError(e)) throw e;
      }
    }
    const comment: FeedComment = {
      id: `c-${Date.now()}`,
      postId: targetId,
      userId: localProfile.user_id,
      name: localProfile.display_name,
      advisorRank: localProfile.rankTitle,
      body,
      helpfulCount: 0,
      mine: true,
      createdAt: new Date().toISOString(),
    };
    if (!localComments[targetId]) localComments[targetId] = [];
    localComments[targetId].push(comment);

    const postIdx = localFeed.findIndex((p) => p.id === targetId || p.id === postId);
    if (postIdx !== -1) {
      localFeed[postIdx].commentCount += 1;
    }
    return comment;
  },

  // ---- advisors & fan following -----------------------------------------
  advisors: (query?: string) =>
    withFixtureFallback(
      () => apiRequest<AdvisorPerson[]>(`/advisors${qs({ query })}`),
      () => {
        if (!query || !query.trim()) return localAdvisors;
        const terms = query.toLowerCase().trim().split(/\s+/).filter(Boolean);
        return localAdvisors.filter((a) => {
          const combined = `${a.name} ${a.handle} ${a.bio} ${a.specialty} ${a.city}`.toLowerCase();
          return terms.every((t) => combined.includes(t));
        });
      },
    ),

  advisorProfile: (id: string) =>
    withFixtureFallback(
      () => apiRequest<AdvisorPerson>(`/advisors/${resolveAdvisorId(id)}`),
      () => {
        const resolvedId = resolveAdvisorId(id);
        const lowerId = id.toLowerCase();
        const lowerResolved = resolvedId.toLowerCase();
        const legacyId = REVERSE_ADVISOR_MAP[resolvedId] || REVERSE_ADVISOR_MAP[id];

        // 1. Check localAdvisors by id, resolvedId, reverse legacyId, or handle
        const found = localAdvisors.find(
          (a) =>
            a.id.toLowerCase() === lowerId ||
            a.id.toLowerCase() === lowerResolved ||
            (legacyId && a.id.toLowerCase() === legacyId.toLowerCase()) ||
            a.handle.toLowerCase() === lowerId
        );
        if (found) return found;

        // 2. Check if this is the current user ('me', user_id, or handle)
        if (
          lowerId === 'me' ||
          lowerId === localProfile.user_id.toLowerCase() ||
          lowerResolved === localProfile.user_id.toLowerCase() ||
          lowerId === localProfile.handle.toLowerCase()
        ) {
          return {
            id: localProfile.user_id,
            name: localProfile.display_name,
            handle: localProfile.handle,
            photoUrl: localProfile.photos?.[0]?.url,
            rank: localProfile.rankTitle,
            bio: localProfile.about,
            followersCount: localProfile.followersCount,
            followingCount: localProfile.followingCount,
            adviceGivenCount: 0,
            helpfulPercent: localProfile.helpfulRating,
            isFollowing: false,
            recentAdviceQuote: localProfile.about,
            city: localProfile.city || 'Global',
            specialty: localProfile.specialty || 'Tea Advisor',
            postsCount: localProfile.postsCount,
            upvotesCount: localProfile.followersCount,
          };
        }

        // 3. Check notifications for actor
        const notifActor = localNotifications.find(
          (n) =>
            (n.actorId &&
              (n.actorId.toLowerCase() === lowerId ||
                n.actorId.toLowerCase() === lowerResolved ||
                (legacyId && n.actorId.toLowerCase() === legacyId.toLowerCase()))) ||
            (n.actorHandle && n.actorHandle.toLowerCase() === lowerId)
        );
        if (notifActor) {
          return {
            id: notifActor.actorId || resolvedId,
            name: notifActor.actorName,
            handle: notifActor.actorHandle,
            photoUrl: notifActor.actorPhotoUrl,
            rank: 'Tea Member 🍵',
            bio: 'Dating advisor active in the Tea community.',
            followersCount: 500,
            followingCount: 150,
            adviceGivenCount: 10,
            helpfulPercent: 90,
            isFollowing: Boolean(notifActor.followedBack),
            recentAdviceQuote: notifActor.text,
            city: 'Online',
            specialty: 'Dating Advice',
            postsCount: 5,
            upvotesCount: 200,
          };
        }

        // 4. Check feed for author
        const postAuthor = localFeed.find(
          (p) =>
            (p.authorId &&
              (p.authorId.toLowerCase() === lowerId ||
                p.authorId.toLowerCase() === lowerResolved ||
                (legacyId && p.authorId.toLowerCase() === legacyId.toLowerCase()))) ||
            (p.authorHandle && p.authorHandle.toLowerCase() === lowerId)
        );
        if (postAuthor) {
          return {
            id: postAuthor.authorId,
            name: postAuthor.author,
            handle: postAuthor.authorHandle,
            photoUrl: postAuthor.authorPhotoUrl,
            rank: postAuthor.authorRank || 'Tea Contributor 🍵',
            bio: `Author of dating dilemma: "${postAuthor.title}"`,
            followersCount: postAuthor.authorFollowers || 100,
            followingCount: 50,
            adviceGivenCount: 5,
            helpfulPercent: 92,
            isFollowing: Boolean(postAuthor.followedByMe),
            recentAdviceQuote: postAuthor.question,
            city: postAuthor.city,
            specialty: postAuthor.category,
            postsCount: 1,
            upvotesCount: postAuthor.likeCount,
          };
        }

        // If not found anywhere, do NOT fallback to localAdvisors[0]!
        throw new Error(`Advisor not found: ${id}`);
      },
    ),

  toggleFollow: async (advisorId: string) => {
    try {
      const targetId = resolveAdvisorId(advisorId);
      return await apiRequest<{ isFollowing: boolean; followersCount: number }>(`/advisors/${targetId}/follow`, { method: 'POST' });
    } catch (e) {
      if (__DEV__ && isNetworkError(e)) {
        const resolvedId = resolveAdvisorId(advisorId);
        const lowerTarget = advisorId.toLowerCase();
        const lowerResolved = resolvedId.toLowerCase();
        const legacyId = REVERSE_ADVISOR_MAP[resolvedId] || REVERSE_ADVISOR_MAP[advisorId];

        const idx = localAdvisors.findIndex(
          (a) =>
            a.id.toLowerCase() === lowerTarget ||
            a.id.toLowerCase() === lowerResolved ||
            (legacyId && a.id.toLowerCase() === legacyId.toLowerCase()) ||
            a.handle.toLowerCase() === lowerTarget
        );
        if (idx !== -1) {
          const adv = localAdvisors[idx];
          adv.isFollowing = !adv.isFollowing;
          adv.followersCount += adv.isFollowing ? 1 : -1;
          localProfile.followingCount += adv.isFollowing ? 1 : -1;

          // Also update feed posts matching this author
          localFeed.forEach((p) => {
            if (
              p.authorId === advisorId ||
              p.authorId === adv.id ||
              p.authorHandle.toLowerCase() === adv.handle.toLowerCase()
            ) {
              p.followedByMe = adv.isFollowing;
            }
          });

          // Also update notifications
          localNotifications.forEach((n) => {
            if (
              n.actorId === advisorId ||
              n.actorId === adv.id ||
              n.actorHandle.toLowerCase() === adv.handle.toLowerCase()
            ) {
              n.followedBack = adv.isFollowing;
            }
          });

          return { isFollowing: adv.isFollowing, followersCount: adv.followersCount };
        }
        return { isFollowing: true, followersCount: 1 };
      }
      throw e;
    }
  },

  // ---- notes / stories --------------------------------------------------
  stories: () =>
    withFixtureFallback(() => apiRequest<StoryItem[]>('/stories'), () => FIXTURE_NOTES),

  addNote: async (note: string, emoji?: string) => {
    try {
      return await apiRequest<StoryItem>('/stories', {
        method: 'POST',
        body: JSON.stringify({ note, emoji }),
      });
    } catch (e) {
      if (__DEV__ && isNetworkError(e)) {
        const item: StoryItem = {
          id: `note-${Date.now()}`,
          author: localProfile.display_name,
          name: localProfile.display_name,
          note,
          emoji: emoji || '✨',
          isSelf: true,
        };
        FIXTURE_NOTES.unshift(item);
        return item;
      }
      throw e;
    }
  },

  // ---- messages & 1-on-1 chat -------------------------------------------
  conversations: () =>
    withFixtureFallback(
      () => apiRequest<ConversationItem[]>('/messages/conversations'),
      () => localConversations,
    ),

  messages: (conversationId: string, before?: string, limit = 50) => {
    const targetId = resolveConversationId(conversationId);
    return withFixtureFallback(
      () => apiRequest<ChatMessage[]>(`/messages/conversations/${targetId}${qs({ before, limit })}`),
      () =>
        localMessages[conversationId] ||
        localMessages[targetId] ||
        localMessages[REVERSE_CONVERSATION_MAP[conversationId] || ''] ||
        localMessages[REVERSE_CONVERSATION_MAP[targetId] || ''] ||
        localMessages['conv-1'] ||
        [],
    );
  },

  sendMessage: async (conversationId: string, body: string) => {
    const targetId = resolveConversationId(conversationId);
    try {
      return await apiRequest<ChatMessage>(`/messages/conversations/${targetId}`, {
        method: 'POST',
        body: JSON.stringify({ body }),
      });
    } catch (e) {
      if (__DEV__ && isNetworkError(e)) {
        const msg: ChatMessage = {
          id: `m-${Date.now()}`,
          senderId: 'me',
          body,
          mine: true,
          created_at: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }),
        };
        const fixtureKey = localMessages[conversationId]
          ? conversationId
          : localMessages[targetId]
          ? targetId
          : conversationId;
        if (!localMessages[fixtureKey]) localMessages[fixtureKey] = [];
        localMessages[fixtureKey].unshift(msg);

        // Update preview in conversation list
        const conv = localConversations.find(
          (c) => c.id === conversationId || c.id === targetId || c.id === (REVERSE_CONVERSATION_MAP[targetId] || ''),
        );
        if (conv) {
          conv.preview = body;
          conv.time = 'Just now';
          conv.unread = false;
        }

        return msg;
      }
      throw e;
    }
  },

  // ---- notifications ---------------------------------------------------
  notifications: () =>
    withFixtureFallback(() => apiRequest<NotificationItem[]>('/notifications'), () => localNotifications),

  confirmNotification: async (id: string) => {
    try {
      return await apiRequest<{ ok: boolean }>(`/notifications/${id}/confirm`, { method: 'POST' });
    } catch (e) {
      if (__DEV__ && isNetworkError(e)) {
        const notif = localNotifications.find((n) => n.id === id);
        if (notif) notif.confirmed = true;
        return { ok: true };
      }
      throw e;
    }
  },

  deleteNotification: async (id: string) => {
    try {
      return await apiRequest<{ ok: boolean }>(`/notifications/${id}`, { method: 'DELETE' });
    } catch (e) {
      if (__DEV__ && isNetworkError(e)) {
        localNotifications = localNotifications.filter((n) => n.id !== id);
        return { ok: true };
      }
      throw e;
    }
  },

  // ---- safety -----------------------------------------------------------
  block: (userId: string) => apiRequest<{ ok: boolean }>(`/users/${userId}/block`, { method: 'POST' }),
  unblock: (userId: string) => apiRequest<{ ok: boolean }>(`/users/${userId}/block`, { method: 'DELETE' }),
  report: (userId: string, reason: string, details?: string) =>
    apiRequest<{ ok: boolean }>(`/users/${userId}/report`, {
      method: 'POST',
      body: JSON.stringify({ reason, details }),
    }),

  // ---- media & photo management -----------------------------------------
  uploadPhoto: async (uri: string, mimeType = 'image/jpeg', fileName = 'photo.jpg'): Promise<Photo[]> => {
    try {
      const formData = new FormData();
      formData.append('file', {
        uri,
        type: mimeType,
        name: fileName,
      } as any);

      const photos = await apiRequest<Photo[]>('/user/profile/photos', {
        method: 'POST',
        body: formData,
      });
      localProfile.photos = photos;
      return photos;
    } catch (e) {
      if (__DEV__ && isNetworkError(e)) {
        const newPhoto: Photo = {
          id: `photo-${Date.now()}`,
          url: uri,
          position: localProfile.photos.length,
        };
        localProfile.photos = [...localProfile.photos, newPhoto];
        return localProfile.photos;
      }
      throw e;
    }
  },

  deletePhoto: async (id: string): Promise<Photo[]> => {
    try {
      const photos = await apiRequest<Photo[]>(`/user/profile/photos/${id}`, {
        method: 'DELETE',
      });
      localProfile.photos = photos;
      return photos;
    } catch (e) {
      if (__DEV__ && isNetworkError(e)) {
        localProfile.photos = localProfile.photos.filter((p) => p.id !== id);
        return localProfile.photos;
      }
      throw e;
    }
  },

  reorderPhotos: async (ids: string[]): Promise<Photo[]> => {
    try {
      const photos = await apiRequest<Photo[]>('/user/profile/photos/reorder', {
        method: 'POST',
        body: JSON.stringify({ ids }),
      });
      localProfile.photos = photos;
      return photos;
    } catch (e) {
      if (__DEV__ && isNetworkError(e)) {
        const map = new Map(localProfile.photos.map((p) => [p.id, p]));
        localProfile.photos = ids
          .map((id, idx) => {
            const p = map.get(id);
            return p ? { ...p, position: idx } : null;
          })
          .filter((p): p is Photo => p !== null);
        return localProfile.photos;
      }
      throw e;
    }
  },
};
