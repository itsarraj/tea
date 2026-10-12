import {
  useInfiniteQuery,
  useMutation,
  useQuery,
  useQueryClient,
} from '@tanstack/react-query';

import type { AdvisorPerson, ChatMessage, FeedPost, MyProfile, NotificationItem } from '@/lib/fixtures';
import { datingApi, type PatchProfileBody } from '@/services/datingApi';

export const datingKeys = {
  all: ['dating'] as const,
  profile: ['dating', 'profile'] as const,
  blocked: ['dating', 'blocked'] as const,
  stories: ['dating', 'stories'] as const,
  feed: (opts?: string | { category?: string; query?: string; authorId?: string; saved?: boolean }) => {
    if (typeof opts === 'string') return ['dating', 'feed', opts, '', '', false] as const;
    return [
      'dating',
      'feed',
      opts?.category ?? 'all',
      opts?.query ?? '',
      opts?.authorId ?? '',
      opts?.saved ?? false,
    ] as const;
  },
  post: (id: string) => ['dating', 'post', id] as const,
  comments: (postId: string) => ['dating', 'comments', postId] as const,
  advisors: (query?: string) => ['dating', 'advisors', query ?? ''] as const,
  advisor: (id: string) => ['dating', 'advisor', id] as const,
  notifications: ['dating', 'notifications'] as const,
  conversations: ['dating', 'conversations'] as const,
  messages: (id: string) => ['dating', 'messages', id] as const,
};

// ---- self -------------------------------------------------------------------

export function useProfile(enabled = true) {
  return useQuery({ queryKey: datingKeys.profile, queryFn: () => datingApi.profile(), enabled, staleTime: 30_000 });
}

export function usePatchProfile() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: (body: PatchProfileBody) => datingApi.patchProfile(body),
    onSuccess: (profile) => {
      qc.setQueryData<MyProfile>(datingKeys.profile, profile);
      qc.invalidateQueries({ queryKey: ['dating', 'feed'] });
      qc.invalidateQueries({ queryKey: ['dating', 'advisors'] });
    },
  });
}

export function useSetLocation() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: (v: { lat: number; lng: number; city?: string }) => datingApi.setLocation(v.lat, v.lng, v.city),
    onSuccess: (profile) => {
      qc.setQueryData<MyProfile>(datingKeys.profile, profile);
      qc.invalidateQueries({ queryKey: ['dating', 'feed'] });
      qc.invalidateQueries({ queryKey: ['dating', 'advisors'] });
    },
  });
}

export function useUploadPhoto() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: (v: { uri: string; mimeType?: string; fileName?: string }) =>
      datingApi.uploadPhoto(v.uri, v.mimeType, v.fileName),
    onSuccess: (photos) => {
      qc.setQueryData<MyProfile>(datingKeys.profile, (old) => (old ? { ...old, photos } : old));
    },
  });
}

export function useDeletePhoto() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: (id: string) => datingApi.deletePhoto(id),
    onSuccess: (photos) => {
      qc.setQueryData<MyProfile>(datingKeys.profile, (old) => (old ? { ...old, photos } : old));
    },
  });
}

export function useReorderPhotos() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: (ids: string[]) => datingApi.reorderPhotos(ids),
    onSuccess: (photos) => {
      qc.setQueryData<MyProfile>(datingKeys.profile, (old) => (old ? { ...old, photos } : old));
    },
  });
}

export function useDeleteAccount() {
  return useMutation({ mutationFn: () => datingApi.deleteAccount() });
}

export function useBlockedUsers() {
  return useQuery({ queryKey: datingKeys.blocked, queryFn: () => datingApi.blockedUsers() });
}

// ---- discover ---------------------------------------------------------------

export function useStories() {
  return useQuery({ queryKey: datingKeys.stories, queryFn: () => datingApi.stories() });
}

// ---- chat -------------------------------------------------------------------

export function useConversations() {
  return useQuery({
    queryKey: datingKeys.conversations,
    queryFn: () => datingApi.conversations(),
    refetchInterval: 15_000,
  });
}

/** Messages newest-first pages; the screen renders them inverted. */
export function useConversationMessages(id: string | undefined) {
  return useInfiniteQuery({
    queryKey: datingKeys.messages(id || ''),
    enabled: Boolean(id),
    initialPageParam: undefined as string | undefined,
    queryFn: ({ pageParam }) => datingApi.messages(id!, pageParam, 50),
    getNextPageParam: (last) => (last.length < 50 ? undefined : last[last.length - 1]?.created_at),
  });
}

export function useSendMessage(conversationId: string | undefined) {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: (body: string) => datingApi.sendMessage(conversationId!, body),
    onMutate: (body: string) => {
      if (!conversationId) return;
      const key = datingKeys.messages(conversationId);
      const previous = qc.getQueryData<{ pages: ChatMessage[][]; pageParams: unknown[] }>(key);
      const optimisticMsg: ChatMessage = {
        id: `temp-${Date.now()}`,
        senderId: 'me',
        body,
        mine: true,
        created_at: new Date().toISOString(),
      };
      qc.setQueryData<{ pages: ChatMessage[][]; pageParams: unknown[] }>(key, (old) => {
        if (!old) {
          return { pages: [[optimisticMsg]], pageParams: [undefined] };
        }
        const [first = [], ...rest] = old.pages;
        return { ...old, pages: [[optimisticMsg, ...first], ...rest] };
      });
      return { previous };
    },
    onError: (_err, _body, context) => {
      if (context?.previous && conversationId) {
        qc.setQueryData(datingKeys.messages(conversationId), context.previous);
      }
    },
    onSuccess: (msg) => {
      const key = datingKeys.messages(conversationId || '');
      qc.setQueryData<{ pages: ChatMessage[][]; pageParams: unknown[] }>(key, (old) => {
        if (!old) return old;
        const [first = [], ...rest] = old.pages;
        const filtered = first.filter((m) => !m.id.startsWith('temp-'));
        return { ...old, pages: [[msg, ...filtered], ...rest] };
      });
      qc.invalidateQueries({ queryKey: datingKeys.conversations });
      qc.invalidateQueries({ queryKey: ['dating', 'messages'] });
    },
  });
}

// ---- feed -------------------------------------------------------------------

const FEED_PAGE = 20;

export type FeedOptions = {
  category?: string;
  query?: string;
  authorId?: string;
  saved?: boolean;
};

export function useFeed(opts?: string | FeedOptions) {
  const category = typeof opts === 'string' ? opts : opts?.category;
  const query = typeof opts === 'object' ? opts?.query : undefined;
  const authorId = typeof opts === 'object' ? opts?.authorId : undefined;
  const saved = typeof opts === 'object' ? opts?.saved : undefined;
  return useInfiniteQuery({
    queryKey: datingKeys.feed(opts),
    initialPageParam: undefined as string | undefined,
    queryFn: ({ pageParam }) =>
      datingApi.feed({ category, query, authorId, saved, cursor: pageParam, limit: FEED_PAGE }),
    getNextPageParam: (last) => (last.length < FEED_PAGE ? undefined : last[last.length - 1]?.createdAt),
  });
}

export const POST_ID_ALIASES: Record<string, string> = {
  'post-1': 'a0000000-0000-0000-0000-000000000001',
  'post-2': 'a0000000-0000-0000-0000-000000000002',
  'post-3': 'a0000000-0000-0000-0000-000000000003',
  'post-4': 'a0000000-0000-0000-0000-000000000004',
  'post-5': 'a0000000-0000-0000-0000-000000000005',
};

export const REVERSE_POST_ID_ALIASES: Record<string, string> = Object.entries(POST_ID_ALIASES).reduce(
  (acc, [k, v]) => ({ ...acc, [v]: k }),
  {} as Record<string, string>,
);

export function matchesPostId(candidateId: string | undefined, targetId: string | undefined): boolean {
  if (!candidateId || !targetId) return false;
  if (candidateId === targetId) return true;
  if (POST_ID_ALIASES[targetId] && candidateId === POST_ID_ALIASES[targetId]) return true;
  if (REVERSE_POST_ID_ALIASES[targetId] && candidateId === REVERSE_POST_ID_ALIASES[targetId]) return true;
  if (POST_ID_ALIASES[candidateId] && targetId === POST_ID_ALIASES[candidateId]) return true;
  if (REVERSE_POST_ID_ALIASES[candidateId] && targetId === REVERSE_POST_ID_ALIASES[candidateId]) return true;
  return false;
}

export function usePost(id: string | undefined) {
  const qc = useQueryClient();
  return useQuery({
    queryKey: datingKeys.post(id || ''),
    queryFn: () => datingApi.post(id!),
    enabled: Boolean(id),
    initialData: () => {
      if (!id) return undefined;
      const targetId = POST_ID_ALIASES[id] || id;

      // 1. Check direct post cache
      const cached =
        qc.getQueryData<FeedPost>(datingKeys.post(targetId)) ||
        qc.getQueryData<FeedPost>(datingKeys.post(id));
      if (cached) return cached;

      // 2. Search all feed queries in cache
      const feeds = qc.getQueriesData<any>({ queryKey: ['dating', 'feed'] });
      for (const [, data] of feeds) {
        if (Array.isArray(data)) {
          const found = data.find((p: FeedPost) => matchesPostId(p?.id, id));
          if (found) return found;
        } else if (data?.pages && Array.isArray(data.pages)) {
          for (const page of data.pages) {
            if (Array.isArray(page)) {
              const found = page.find((p: FeedPost) => matchesPostId(p?.id, id));
              if (found) return found;
            }
          }
        }
      }
      return undefined;
    },
  });
}

export function useCreatePost() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: (body: { title?: string; category: string; question: string; mode?: string }) =>
      datingApi.createPost({
        title: body.title || body.question.slice(0, 60),
        category: body.category,
        question: body.question,
      }),
    onSuccess: () => qc.invalidateQueries({ queryKey: ['dating', 'feed'] }),
  });
}

type FeedPages = { pages: FeedPost[][]; pageParams: unknown[] };

export function useToggleLike() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: (postId: string) => datingApi.toggleLike(postId),
    onMutate: (postId: string) => {
      // 1. Synchronously snapshot and update caches without awaiting query cancellation
      // to guarantee 0ms perceived UI latency
      void qc.cancelQueries({ queryKey: ['dating', 'feed'] });
      void qc.cancelQueries({ queryKey: ['dating', 'post'] });

      const previousFeeds = qc.getQueriesData<FeedPages>({ queryKey: ['dating', 'feed'] });
      const previousPosts = qc.getQueriesData<FeedPost>({ queryKey: ['dating', 'post'] });

      qc.setQueriesData<FeedPages>({ queryKey: ['dating', 'feed'] }, (old) =>
        old
          ? {
              ...old,
              pages: old.pages.map((pg) =>
                pg.map((p) =>
                  matchesPostId(p.id, postId)
                    ? {
                        ...p,
                        likedByMe: !p.likedByMe,
                        likeCount: p.likedByMe ? Math.max(0, p.likeCount - 1) : p.likeCount + 1,
                      }
                    : p,
                ),
              ),
            }
          : old,
      );

      qc.setQueriesData<FeedPost>({ queryKey: ['dating', 'post'] }, (old) =>
        old && matchesPostId(old.id, postId)
          ? {
              ...old,
              likedByMe: !old.likedByMe,
              likeCount: old.likedByMe ? Math.max(0, old.likeCount - 1) : old.likeCount + 1,
            }
          : old,
      );

      return { previousFeeds, previousPosts };
    },
    onError: (_err, _postId, context) => {
      if (context?.previousFeeds) {
        context.previousFeeds.forEach(([key, data]) => qc.setQueryData(key, data));
      }
      if (context?.previousPosts) {
        context.previousPosts.forEach(([key, data]) => qc.setQueryData(key, data));
      }
    },
    onSuccess: (res, postId) => {
      qc.setQueriesData<FeedPages>({ queryKey: ['dating', 'feed'] }, (old) =>
        old
          ? {
              ...old,
              pages: old.pages.map((pg) =>
                pg.map((p) =>
                  matchesPostId(p.id, postId)
                    ? { ...p, likedByMe: res.liked, likeCount: res.likeCount }
                    : p,
                ),
              ),
            }
          : old,
      );
      qc.setQueriesData<FeedPost>({ queryKey: ['dating', 'post'] }, (old) =>
        old && matchesPostId(old.id, postId)
          ? { ...old, likedByMe: res.liked, likeCount: res.likeCount }
          : old,
      );
    },
  });
}

export function useComments(postId: string | undefined) {
  return useQuery({
    queryKey: datingKeys.comments(postId || ''),
    queryFn: () => datingApi.comments(postId!),
    enabled: Boolean(postId),
  });
}

export function useAddComment(postId: string | undefined) {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: (body: string) => datingApi.addComment(postId!, body),
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: datingKeys.comments(postId || '') });
      qc.invalidateQueries({ queryKey: ['dating', 'feed'] });
      if (postId) qc.invalidateQueries({ queryKey: datingKeys.post(postId) });
    },
  });
}

// ---- safety -----------------------------------------------------------------

export function useBlockUser() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: (userId: string) => datingApi.block(userId),
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: datingKeys.all });
    },
  });
}

export function useUnblockUser() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: (userId: string) => datingApi.unblock(userId),
    onMutate: (userId: string) => {
      void qc.cancelQueries({ queryKey: datingKeys.blocked });
      const previous = qc.getQueryData<AdvisorPerson[]>(datingKeys.blocked);
      if (previous) {
        qc.setQueryData<AdvisorPerson[]>(
          datingKeys.blocked,
          previous.filter((u) => u.id !== userId),
        );
      }
      return { previous };
    },
    onError: (_err, _userId, context) => {
      if (context?.previous) {
        qc.setQueryData(datingKeys.blocked, context.previous);
      }
    },
    onSettled: () => {
      qc.invalidateQueries({ queryKey: datingKeys.blocked });
      qc.invalidateQueries({ queryKey: ['dating', 'feed'] });
      qc.invalidateQueries({ queryKey: ['dating', 'advisors'] });
    },
  });
}

export function useReportUser() {
  return useMutation({
    mutationFn: (v: { userId: string; reason: string; details?: string }) =>
      datingApi.report(v.userId, v.reason, v.details),
  });
}

// ---- advisors & fan following -----------------------------------------------

export function useAdvisors(query?: string) {
  return useQuery({
    queryKey: datingKeys.advisors(query),
    queryFn: () => datingApi.advisors(query),
  });
}

export function useAdvisorProfile(id: string | undefined) {
  return useQuery({
    queryKey: datingKeys.advisor(id || ''),
    queryFn: () => datingApi.advisorProfile(id!),
    enabled: Boolean(id),
  });
}

export function useToggleFollow() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: (advisorId: string) => datingApi.toggleFollow(advisorId),
    onMutate: (advisorId: string) => {
      // 1. Cancel in-flight queries without blocking UI update
      void qc.cancelQueries({ queryKey: ['dating', 'advisors'] });
      void qc.cancelQueries({ queryKey: ['dating', 'advisor'] });
      void qc.cancelQueries({ queryKey: ['dating', 'feed'] });
      void qc.cancelQueries({ queryKey: ['dating', 'post'] });
      void qc.cancelQueries({ queryKey: datingKeys.profile });

      // 2. Snapshot current caches for rollback
      const prevAdvisors = qc.getQueriesData<AdvisorPerson[]>({ queryKey: ['dating', 'advisors'] });
      const prevAdvisor = qc.getQueriesData<AdvisorPerson>({ queryKey: ['dating', 'advisor'] });
      const prevFeed = qc.getQueriesData<FeedPages>({ queryKey: ['dating', 'feed'] });
      const prevPosts = qc.getQueriesData<FeedPost>({ queryKey: ['dating', 'post'] });
      const prevProfile = qc.getQueryData<MyProfile>(datingKeys.profile);

      // 3. Determine current following state from any existing cache
      let currentlyFollowing: boolean | undefined = undefined;

      for (const [, adv] of prevAdvisor) {
        if (adv && (adv.id === advisorId || adv.handle === advisorId)) {
          currentlyFollowing = adv.isFollowing;
          break;
        }
      }
      if (currentlyFollowing === undefined) {
        for (const [, list] of prevAdvisors) {
          if (Array.isArray(list)) {
            const found = list.find((a) => a.id === advisorId || a.handle === advisorId);
            if (found) {
              currentlyFollowing = found.isFollowing;
              break;
            }
          }
        }
      }
      if (currentlyFollowing === undefined) {
        for (const [, feed] of prevFeed) {
          if (feed?.pages) {
            for (const page of feed.pages) {
              const found = page.find((p) => p.authorId === advisorId || p.authorHandle === advisorId);
              if (found && found.followedByMe !== undefined) {
                currentlyFollowing = found.followedByMe;
                break;
              }
            }
          }
          if (currentlyFollowing !== undefined) break;
        }
      }

      const nextFollowing = currentlyFollowing === undefined ? true : !currentlyFollowing;
      const delta = nextFollowing ? 1 : -1;

      // 4. Optimistically update ['dating', 'advisors']
      qc.setQueriesData<AdvisorPerson[]>({ queryKey: ['dating', 'advisors'] }, (old) =>
        old
          ? old.map((a) =>
              a.id === advisorId || a.handle === advisorId
                ? {
                    ...a,
                    isFollowing: nextFollowing,
                    followersCount: Math.max(0, a.followersCount + delta),
                  }
                : a,
            )
          : old,
      );

      // 5. Optimistically update ['dating', 'advisor']
      qc.setQueriesData<AdvisorPerson>({ queryKey: ['dating', 'advisor'] }, (old) =>
        old && (old.id === advisorId || old.handle === advisorId)
          ? {
              ...old,
              isFollowing: nextFollowing,
              followersCount: Math.max(0, old.followersCount + delta),
            }
          : old,
      );

      // 6. Optimistically update ['dating', 'feed']
      qc.setQueriesData<FeedPages>({ queryKey: ['dating', 'feed'] }, (old) =>
        old
          ? {
              ...old,
              pages: old.pages.map((page) =>
                page.map((p) =>
                  p.authorId === advisorId || p.authorHandle === advisorId
                    ? {
                        ...p,
                        followedByMe: nextFollowing,
                        authorFollowers: Math.max(0, (p.authorFollowers ?? 0) + delta),
                      }
                    : p,
                ),
              ),
            }
          : old,
      );

      // 7. Optimistically update ['dating', 'post']
      qc.setQueriesData<FeedPost>({ queryKey: ['dating', 'post'] }, (old) =>
        old && (old.authorId === advisorId || old.authorHandle === advisorId)
          ? {
              ...old,
              followedByMe: nextFollowing,
              authorFollowers: Math.max(0, (old.authorFollowers ?? 0) + delta),
            }
          : old,
      );

      // 8. Optimistically update profile following count
      qc.setQueryData<MyProfile>(datingKeys.profile, (old) =>
        old
          ? {
              ...old,
              followingCount: Math.max(0, (old.followingCount ?? 0) + delta),
            }
          : old,
      );

      return { prevAdvisors, prevAdvisor, prevFeed, prevPosts, prevProfile };
    },
    onError: (_err, _advisorId, context) => {
      if (context?.prevAdvisors) {
        context.prevAdvisors.forEach(([k, data]) => qc.setQueryData(k, data));
      }
      if (context?.prevAdvisor) {
        context.prevAdvisor.forEach(([k, data]) => qc.setQueryData(k, data));
      }
      if (context?.prevFeed) {
        context.prevFeed.forEach(([k, data]) => qc.setQueryData(k, data));
      }
      if (context?.prevPosts) {
        context.prevPosts.forEach(([k, data]) => qc.setQueryData(k, data));
      }
      if (context?.prevProfile) {
        qc.setQueryData(datingKeys.profile, context.prevProfile);
      }
    },
    onSuccess: (res, advisorId) => {
      qc.setQueriesData<AdvisorPerson[]>({ queryKey: ['dating', 'advisors'] }, (old) =>
        old
          ? old.map((a) =>
              a.id === advisorId || a.handle === advisorId
                ? {
                    ...a,
                    isFollowing: res.isFollowing,
                    followersCount: res.followersCount,
                  }
                : a,
            )
          : old,
      );

      qc.setQueriesData<AdvisorPerson>({ queryKey: ['dating', 'advisor'] }, (old) =>
        old && (old.id === advisorId || old.handle === advisorId)
          ? {
              ...old,
              isFollowing: res.isFollowing,
              followersCount: res.followersCount,
            }
          : old,
      );

      qc.setQueriesData<FeedPages>({ queryKey: ['dating', 'feed'] }, (old) =>
        old
          ? {
              ...old,
              pages: old.pages.map((page) =>
                page.map((p) =>
                  p.authorId === advisorId || p.authorHandle === advisorId
                    ? {
                        ...p,
                        followedByMe: res.isFollowing,
                        authorFollowers: res.followersCount,
                      }
                    : p,
                ),
              ),
            }
          : old,
      );

      qc.setQueriesData<FeedPost>({ queryKey: ['dating', 'post'] }, (old) =>
        old && (old.authorId === advisorId || old.authorHandle === advisorId)
          ? {
              ...old,
              followedByMe: res.isFollowing,
              authorFollowers: res.followersCount,
            }
          : old,
      );
    },
  });
}

export function useToggleSave() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: (postId: string) => datingApi.toggleSave(postId),
    onMutate: (postId: string) => {
      void qc.cancelQueries({ queryKey: ['dating', 'feed'] });
      void qc.cancelQueries({ queryKey: ['dating', 'post'] });

      const previousFeeds = qc.getQueriesData<FeedPages>({ queryKey: ['dating', 'feed'] });
      const previousPosts = qc.getQueriesData<FeedPost>({ queryKey: ['dating', 'post'] });

      qc.setQueriesData<FeedPages>({ queryKey: ['dating', 'feed'] }, (old) =>
        old
          ? {
              ...old,
              pages: old.pages.map((pg) =>
                pg.map((p) =>
                  matchesPostId(p.id, postId) ? { ...p, savedByMe: !p.savedByMe } : p,
                ),
              ),
            }
          : old,
      );

      qc.setQueriesData<FeedPost>({ queryKey: ['dating', 'post'] }, (old) =>
        old && matchesPostId(old.id, postId) ? { ...old, savedByMe: !old.savedByMe } : old,
      );

      return { previousFeeds, previousPosts };
    },
    onError: (_err, _postId, context) => {
      if (context?.previousFeeds) {
        context.previousFeeds.forEach(([key, data]) => qc.setQueryData(key, data));
      }
      if (context?.previousPosts) {
        context.previousPosts.forEach(([key, data]) => qc.setQueryData(key, data));
      }
    },
    onSuccess: (res, postId) => {
      qc.setQueriesData<FeedPages>({ queryKey: ['dating', 'feed'] }, (old) =>
        old
          ? {
              ...old,
              pages: old.pages.map((pg) =>
                pg.map((p) =>
                  matchesPostId(p.id, postId) ? { ...p, savedByMe: res.saved } : p,
                ),
              ),
            }
          : old,
      );
      qc.setQueriesData<FeedPost>({ queryKey: ['dating', 'post'] }, (old) =>
        old && matchesPostId(old.id, postId) ? { ...old, savedByMe: res.saved } : old,
      );
    },
  });
}

export function useVoteVerdict() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: ({ postId, vote }: { postId: string; vote: 'red' | 'green' | 'valid' }) =>
      datingApi.voteVerdict(postId, vote),
    onMutate: ({ postId, vote }) => {
      // 1. Synchronously snapshot and update caches without awaiting query cancellation
      // to guarantee 0ms perceived UI latency
      void qc.cancelQueries({ queryKey: ['dating', 'feed'] });
      void qc.cancelQueries({ queryKey: ['dating', 'post'] });

      // 2. Snapshot current state for rollback
      const previousFeeds = qc.getQueriesData<FeedPages>({ queryKey: ['dating', 'feed'] });
      const previousPosts = qc.getQueriesData<FeedPost>({ queryKey: ['dating', 'post'] });

      const applyVote = (p: FeedPost): FeedPost => {
        let redFlagCount = p.redFlagCount ?? 0;
        let greenFlagCount = p.greenFlagCount ?? 0;
        let validCount = p.validCount ?? 0;
        const currentVote = p.userVote || p.myVote;
        let userVote: 'red' | 'green' | 'valid' | null = null;

        if (currentVote === vote) {
          // Toggle off
          if (vote === 'red' && redFlagCount > 0) redFlagCount -= 1;
          if (vote === 'green' && greenFlagCount > 0) greenFlagCount -= 1;
          if (vote === 'valid' && validCount > 0) validCount -= 1;
          userVote = null;
        } else {
          // Remove previous vote if any
          if (currentVote === 'red' && redFlagCount > 0) redFlagCount -= 1;
          if (currentVote === 'green' && greenFlagCount > 0) greenFlagCount -= 1;
          if (currentVote === 'valid' && validCount > 0) validCount -= 1;

          // Add newly selected vote
          if (vote === 'red') redFlagCount += 1;
          if (vote === 'green') greenFlagCount += 1;
          if (vote === 'valid') validCount += 1;
          userVote = vote;
        }

        return {
          ...p,
          redFlagCount,
          greenFlagCount,
          validCount,
          userVote,
          myVote: userVote,
        };
      };

      // 3. Immediately update all feed caches (0ms UI latency)
      qc.setQueriesData<FeedPages>({ queryKey: ['dating', 'feed'] }, (old) =>
        old
          ? {
              ...old,
              pages: old.pages.map((pg) =>
                pg.map((p) => (matchesPostId(p.id, postId) ? applyVote(p) : p)),
              ),
            }
          : old,
      );

      // 4. Immediately update all matching post detail caches
      qc.setQueriesData<FeedPost>({ queryKey: ['dating', 'post'] }, (old) =>
        old && matchesPostId(old.id, postId) ? applyVote(old) : old,
      );

      return { previousFeeds, previousPosts };
    },
    onError: (_err, _vars, context) => {
      if (context?.previousFeeds) {
        context.previousFeeds.forEach(([key, data]) => qc.setQueryData(key, data));
      }
      if (context?.previousPosts) {
        context.previousPosts.forEach(([key, data]) => qc.setQueryData(key, data));
      }
    },
    onSuccess: (res, { postId }) => {
      if (!res) return;
      // Sync authoritative counts directly from response without refetching the feed
      qc.setQueriesData<FeedPages>({ queryKey: ['dating', 'feed'] }, (old) =>
        old
          ? {
              ...old,
              pages: old.pages.map((pg) =>
                pg.map((p) =>
                  matchesPostId(p.id, postId)
                    ? {
                        ...p,
                        redFlagCount: res.redFlagCount,
                        greenFlagCount: res.greenFlagCount,
                        validCount: res.validCount,
                        userVote: res.userVote,
                        myVote: res.userVote,
                      }
                    : p,
                ),
              ),
            }
          : old,
      );

      qc.setQueriesData<FeedPost>({ queryKey: ['dating', 'post'] }, (old) =>
        old && matchesPostId(old.id, postId)
          ? {
              ...old,
              redFlagCount: res.redFlagCount,
              greenFlagCount: res.greenFlagCount,
              validCount: res.validCount,
              userVote: res.userVote,
              myVote: res.userVote,
            }
          : old,
      );
    },
  });
}

export function useAddNote() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: ({ note, emoji }: { note: string; emoji?: string }) => datingApi.addNote(note, emoji),
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: datingKeys.stories });
    },
  });
}

// ---- notifications ----------------------------------------------------------

export function useNotifications() {
  return useQuery({
    queryKey: datingKeys.notifications,
    queryFn: () => datingApi.notifications(),
  });
}

export function useConfirmNotification() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: (id: string) => datingApi.confirmNotification(id),
    onMutate: (id: string) => {
      void qc.cancelQueries({ queryKey: datingKeys.notifications });
      const previous = qc.getQueryData<NotificationItem[]>(datingKeys.notifications);
      if (previous) {
        qc.setQueryData<NotificationItem[]>(
          datingKeys.notifications,
          previous.map((n) => (n.id === id ? { ...n, confirmed: true } : n)),
        );
      }
      return { previous };
    },
    onError: (_err, _id, context) => {
      if (context?.previous) {
        qc.setQueryData(datingKeys.notifications, context.previous);
      }
    },
    onSettled: () => {
      qc.invalidateQueries({ queryKey: datingKeys.notifications });
    },
  });
}

export function useDeleteNotification() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: (id: string) => datingApi.deleteNotification(id),
    onMutate: (id: string) => {
      void qc.cancelQueries({ queryKey: datingKeys.notifications });
      const previous = qc.getQueryData<NotificationItem[]>(datingKeys.notifications);
      if (previous) {
        qc.setQueryData<NotificationItem[]>(
          datingKeys.notifications,
          previous.filter((n) => n.id !== id),
        );
      }
      return { previous };
    },
    onError: (_err, _id, context) => {
      if (context?.previous) {
        qc.setQueryData(datingKeys.notifications, context.previous);
      }
    },
    onSettled: () => {
      qc.invalidateQueries({ queryKey: datingKeys.notifications });
    },
  });
}


