import React, { useState, useEffect, useRef } from 'react';
import {
  Alert,
  FlatList,
  Pressable,
  ScrollView,
  Share,
  StatusBar,
  Text,
  View,
} from 'react-native';
import { router } from 'expo-router';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { Feather, Ionicons } from '@expo/vector-icons';

import { BrutalistAvatar } from '@/components/tea/BrutalistAvatar';
import {
  CategoryPill,
  EmptyState,
  ErrorState,
  LoadingState,
  QuickNotesRail,
  VerdictVoteBar,
  type NoteItem,
} from '@/components/tea/ui';
import { QuickNoteModal } from '@/components/tea/QuickNoteModal';
import { brand } from '@/constants/brand';
import {
  useAddComment,
  useFeed,
  useNotifications,
  useProfile,
  useStories,
  useToggleFollow,
  useToggleLike,
  useToggleSave,
  useVoteVerdict,
} from '@/hooks/useDating';
import { useAppSettings } from '@/hooks/useAppSettings';
import type { FeedPost } from '@/lib/fixtures';
import { TEA_CATEGORIES } from '@/lib/fixtures';

function timeAgo(dateStr: string): string {
  const diffMs = Date.now() - new Date(dateStr).getTime();
  const mins = Math.floor(diffMs / 60000);
  if (mins < 1) return 'just now';
  if (mins < 60) return `${mins} minutes ago`;
  const hours = Math.floor(mins / 60);
  if (hours < 24) return `${hours} hours ago`;
  const days = Math.floor(hours / 24);
  return `${days} days ago`;
}

export default function HomeScreen() {
  const insets = useSafeAreaInsets();
  const [selectedCategory, setSelectedCategory] = useState('All');
  const [activeSort, setActiveSort] = useState<'latest' | 'hot' | 'top'>('latest');

  const { settings } = useAppSettings();
  const me = useProfile();
  const feed = useFeed({ category: selectedCategory });
  const stories = useStories();
  const notifications = useNotifications();
  const like = useToggleLike();
  const save = useToggleSave();
  const follow = useToggleFollow();
  const vote = useVoteVerdict();

  const [noteModal, setNoteModal] = useState<{
    visible: boolean;
    mode: 'create' | 'view';
    note?: NoteItem;
  }>({ visible: false, mode: 'create' });

  const posts = feed.data?.pages.flat() ?? [];
  const unreadAlerts = notifications.data?.filter((n) => !n.read).length ?? 0;

  const sortedPosts = [...posts].sort((a, b) => {
    if (activeSort === 'hot') return b.commentCount + b.likeCount - (a.commentCount + a.likeCount);
    if (activeSort === 'top') return b.helpfulCount - a.helpfulCount;
    return new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime();
  });

  const header = (
    <View className="pb-2">
      {/* 1. Quick Notes Rail (Inspired by stories layout) */}
      <View className="bg-[#ece6c2] border-b-2 border-black">
        <QuickNotesRail
          notes={stories.data ?? []}
          currentUserPhotoUrl={me.data?.photos?.[0]?.url}
          onAddNote={() => setNoteModal({ visible: true, mode: 'create' })}
          onPressNote={(note) => setNoteModal({ visible: true, mode: 'view', note })}
        />
      </View>

      {/* 2. Category Filter Pills */}
      <ScrollView
        horizontal
        showsHorizontalScrollIndicator={false}
        contentContainerStyle={{ paddingHorizontal: 16, paddingVertical: 10, gap: 10 }}>
        {TEA_CATEGORIES.map((cat) => (
          <CategoryPill
            key={cat}
            label={cat}
            selected={selectedCategory === cat}
            onPress={() => setSelectedCategory(cat)}
          />
        ))}
      </ScrollView>

      {/* 3. Sub-tabs & Sort Selector */}
      <View className="flex-row items-center justify-between px-4 py-1.5">
        <View className="flex-row gap-1.5">
          {(['latest', 'hot', 'top'] as const).map((mode) => {
            const active = activeSort === mode;
            const title = mode === 'latest' ? 'Latest' : mode === 'hot' ? 'Hot Tea 🔥' : 'Top Voted 🏆';
            return (
              <Pressable
                key={mode}
                onPress={() => setActiveSort(mode)}
                className={`px-2.5 py-1 rounded-[3px] border-[1.5px] border-black ${
                  active ? 'bg-[#73bda8]' : 'bg-[#ece6c2]'
                }`}
                style={{
                  shadowColor: '#000',
                  shadowOffset: active ? { width: 0, height: 1.5 } : { width: 0, height: 0 },
                  shadowOpacity: active ? 1 : 0,
                  shadowRadius: 0,
                }}>
                <Text className="text-[11px] font-bold text-black">{title}</Text>
              </Pressable>
            );
          })}
        </View>

        <Pressable
          onPress={() => router.push('/(app)/new-post')}
          className="flex-row items-center gap-1.5 px-3 py-1 bg-[#32b5ff] border-2 border-black rounded-[3px] active:translate-y-0.5"
          style={{
            shadowColor: '#000',
            shadowOffset: { width: -1.5, height: 2 },
            shadowOpacity: 1,
            shadowRadius: 0,
            elevation: 2,
          }}>
          <Feather name="plus" size={14} color="#000" />
          <Text className="text-xs font-black text-black uppercase">Spill Tea</Text>
        </Pressable>
      </View>
    </View>
  );

  return (
    <View className="flex-1 bg-[#ece6c2]" style={{ paddingTop: insets.top }}>
      <StatusBar barStyle="dark-content" backgroundColor="#ece6c2" />

      {/* Top App Header (Direct match to inspiration structure) */}
      <View className="h-14 flex-row items-center justify-between px-4 bg-[#ece6c2] border-b-2 border-black">
        {/* Left: Brand Wordmark + Chevron Dropdown */}
        <Pressable
          onPress={() => setSelectedCategory('All')}
          className="flex-row items-center gap-1.5">
          <Text className="text-2xl font-black text-black tracking-tight">TEA</Text>
          <Feather name="chevron-down" size={20} color="#000" />
        </Pressable>

        {/* Right: Heart (Notifications), Chat (Messages), Square Plus (New Post) */}
        <View className="flex-row items-center gap-3">
          {/* Heart / Notifications Icon */}
          <Pressable
            onPress={() => router.push('/(app)/notifications')}
            className="w-10 h-10 items-center justify-center relative active:translate-y-0.5">
            <Ionicons name="heart-outline" size={26} color="#000" />
            {unreadAlerts > 0 ? (
              <View className="absolute top-1.5 right-1.5 w-2.5 h-2.5 rounded-full bg-[#d72a2a] border border-black" />
            ) : null}
          </Pressable>

          {/* Chat / Direct Advice Messages Icon */}
          <Pressable
            onPress={() => router.push('/(app)/messages')}
            className="w-10 h-10 items-center justify-center active:translate-y-0.5">
            <Ionicons name="chatbubble-ellipses-outline" size={24} color="#000" />
          </Pressable>

          {/* Square Plus Button (matching inspiration SVG rect + line) */}
          <Pressable
            onPress={() => router.push('/(app)/new-post')}
            className="w-9 h-9 rounded-[6px] border-2 border-black bg-white items-center justify-center active:translate-y-0.5"
            style={{
              shadowColor: '#000',
              shadowOffset: { width: -1.5, height: 2 },
              shadowOpacity: 1,
              shadowRadius: 0,
              elevation: 2,
            }}>
            <Feather name="plus" size={20} color="#000" />
          </Pressable>
        </View>
      </View>

      {/* Main Feed List */}
      <FlatList
        data={sortedPosts}
        keyExtractor={(item) => item.id}
        ListHeaderComponent={header}
        contentContainerStyle={{ paddingBottom: insets.bottom + 40 }}
        showsVerticalScrollIndicator={false}
        keyboardShouldPersistTaps="handled"
        refreshing={feed.isRefetching}
        onRefresh={() => {
          feed.refetch();
          stories.refetch();
        }}
        onEndReached={() => {
          if (feed.hasNextPage && !feed.isFetchingNextPage) {
            feed.fetchNextPage();
          }
        }}
        onEndReachedThreshold={0.5}
        ListEmptyComponent={
          feed.isLoading ? (
            <LoadingState />
          ) : feed.isError ? (
            <ErrorState error={feed.error} onRetry={() => feed.refetch()} />
          ) : (
            <EmptyState
              emoji="🫖"
              title="No dating tea here yet"
              body={`No posts found in "${selectedCategory}". Be the first to ask or spill!`}
              actionLabel="+ Spill Something"
              onAction={() => router.push('/(app)/new-post')}
            />
          )
        }
        renderItem={({ item }) => {
          const isSelf = Boolean(
            (item.authorId && item.authorId === me.data?.user_id) ||
            (item.authorHandle && me.data?.handle && item.authorHandle.toLowerCase() === me.data.handle.toLowerCase())
          );
          return (
            <View className="px-4 mb-4">
              <InspirationPostCard
                post={item}
                currentUserPhotoUrl={me.data?.photos?.[0]?.url}
                isSelf={isSelf}
                sensitiveFilter={settings.sensitiveContentFilter}
                onPress={() => router.push(`/(app)/post/${item.id}`)}
                onLike={() => like.mutate(item.id)}
                onSave={() => save.mutate(item.id)}
                onFollow={() => follow.mutate(item.authorId)}
                onVote={(v) => vote.mutate({ postId: item.id, vote: v })}
                onAuthorPress={() => {
                  if (isSelf) {
                    router.push('/(app)/me');
                  } else {
                    const target = item.authorId || item.authorHandle;
                    if (target) router.push(`/(app)/profile/${target}` as any);
                  }
                }}
              />
            </View>
          );
        }}
      />

      <QuickNoteModal
        visible={noteModal.visible}
        mode={noteModal.mode}
        note={noteModal.note}
        currentUserPhotoUrl={me.data?.photos?.[0]?.url}
        onClose={() => setNoteModal((prev) => ({ ...prev, visible: false }))}
      />
    </View>
  );
}

// ==========================================
// INSPIRATION POST CARD
// ==========================================
function InspirationPostCard({
  post,
  currentUserPhotoUrl,
  isSelf = false,
  sensitiveFilter = false,
  onPress,
  onLike,
  onSave,
  onFollow,
  onVote,
  onAuthorPress,
}: {
  post: FeedPost;
  currentUserPhotoUrl?: string;
  isSelf?: boolean;
  sensitiveFilter?: boolean;
  onPress: () => void;
  onLike: () => void;
  onSave: () => void;
  onFollow: () => void;
  onVote: (vote: 'red' | 'green' | 'valid') => void;
  onAuthorPress: () => void;
}) {
  const isSensitive =
    sensitiveFilter &&
    (post.category.includes('Red Flags') || post.category.includes('Breakups') || post.category.includes('Ghosted'));
  const [revealed, setRevealed] = useState(!isSensitive);
  const [expanded, setExpanded] = useState(false);
  const addComment = useAddComment(post.id);

  // Pillar 39: Local-first state for 0ms feed micro-interactions (Like, Save, Follow)
  const [isFollowed, setIsFollowed] = useState(Boolean(post.followedByMe));
  const displayedFollowed = useRef(Boolean(post.followedByMe));
  useEffect(() => {
    if (displayedFollowed.current !== Boolean(post.followedByMe)) {
      displayedFollowed.current = Boolean(post.followedByMe);
      setIsFollowed(Boolean(post.followedByMe));
    }
  }, [post.followedByMe]);

  const [isLiked, setIsLiked] = useState(Boolean(post.likedByMe));
  const [localLikeCount, setLocalLikeCount] = useState(post.likeCount);
  const displayedLiked = useRef(Boolean(post.likedByMe));
  useEffect(() => {
    if (displayedLiked.current !== Boolean(post.likedByMe)) {
      displayedLiked.current = Boolean(post.likedByMe);
      setIsLiked(Boolean(post.likedByMe));
      setLocalLikeCount(post.likeCount);
    }
  }, [post.likedByMe, post.likeCount]);

  const [isSaved, setIsSaved] = useState(Boolean(post.savedByMe));
  const displayedSaved = useRef(Boolean(post.savedByMe));
  useEffect(() => {
    if (displayedSaved.current !== Boolean(post.savedByMe)) {
      displayedSaved.current = Boolean(post.savedByMe);
      setIsSaved(Boolean(post.savedByMe));
    }
  }, [post.savedByMe]);

  const handleFollowPress = () => {
    const next = !displayedFollowed.current;
    displayedFollowed.current = next;
    setIsFollowed(next);
    onFollow();
  };

  const handleLikePress = () => {
    const next = !displayedLiked.current;
    displayedLiked.current = next;
    setIsLiked(next);
    setLocalLikeCount((prev) => (next ? prev + 1 : Math.max(0, prev - 1)));
    onLike();
  };

  const handleSavePress = () => {
    const next = !displayedSaved.current;
    displayedSaved.current = next;
    setIsSaved(next);
    onSave();
  };

  const handlePostQuickReaction = (emoji: string) => {
    addComment.mutate(emoji);
  };

  const handleMoreOptions = () => {
    Alert.alert(post.authorHandle || post.author, 'Choose an action:', [
      { text: 'Cancel', style: 'cancel' },
      {
        text: 'Share Dilemma',
        onPress: () => {
          Share.share({
            message: `"${post.title}" — What's your verdict on Tea Dating Advice?`,
          }).catch(() => {});
        },
      },
      { text: 'View Full Advice Thread', onPress },
    ]);
  };

  return (
    <View
      className="bg-white border-2 border-black rounded-[4px] p-3.5"
      style={{
        shadowColor: '#000',
        shadowOffset: { width: -2, height: 4 },
        shadowOpacity: 1,
        shadowRadius: 0,
        elevation: 3,
      }}>
      {/* 1. Author Header Row (matching inspiration: Jack.James, Sponsored/Advisor, three dots) */}
      <View className="flex-row items-center justify-between mb-3">
        <Pressable
          onPress={onAuthorPress}
          className="flex-row items-center gap-2.5 flex-1">
          <BrutalistAvatar
            name={post.author}
            handle={post.authorHandle}
            imageUrl={post.authorPhotoUrl}
            size={40}
            shape="square"
          />
          <View className="flex-1">
            <View className="flex-row items-center gap-1.5">
              <Text className="text-sm font-bold text-black">{post.authorHandle || post.author}</Text>
              {post.authorRank ? (
                <View className="bg-tea-mint px-1.5 py-0.2 border border-black rounded-[2px]">
                  <Text className="text-[9px] font-black uppercase text-black">
                    {post.authorRank}
                  </Text>
                </View>
              ) : null}
            </View>
            <Text className="text-[10px] font-medium text-[#6e6e6e] mt-0.5">
              {post.city ? `${post.city} · ` : ''}Verified Advisor
            </Text>
          </View>
        </Pressable>

        <View className="flex-row items-center gap-2">
          {/* Follow CTA Button / Self Badge */}
          {isSelf ? (
            <View className="px-2 py-0.5 rounded-[3px] bg-tea-mint border border-black">
              <Text className="text-[10px] font-black uppercase text-black">You</Text>
            </View>
          ) : (
            <Pressable
              unstable_pressDelay={0}
              onPress={handleFollowPress}
              className={`px-2.5 py-1 rounded-[3px] border-[1.5px] border-black active:translate-y-0.5 ${
                isFollowed ? 'bg-[#ece6c2]' : 'bg-[#0e9bea]'
              }`}
              style={{
                shadowColor: '#000',
                shadowOffset: { width: 0, height: 1.5 },
                shadowOpacity: 1,
                shadowRadius: 0,
                elevation: 1,
              }}>
              <Text
                className={`text-[10px] font-bold ${
                  isFollowed ? 'text-black' : 'text-white'
                }`}>
                {isFollowed ? 'Following' : '+ Follow'}
              </Text>
            </Pressable>
          )}

          {/* Three Dots More Options Icon */}
          <Pressable
            onPress={handleMoreOptions}
            className="w-7 h-7 items-center justify-center active:translate-y-0.5">
            <Feather name="more-horizontal" size={18} color="#000" />
          </Pressable>
        </View>
      </View>

      {/* 2. Dilemma Card Body (Replacing photo with pure text advice narrative) */}
      <View
        className="bg-[#fcfbf4] border-2 border-black rounded-[3px] p-3.5 mb-3"
        style={{
          shadowColor: '#000',
          shadowOffset: { width: 0, height: 2 },
          shadowOpacity: 1,
          shadowRadius: 0,
        }}>
        {/* Category Pill and Post Title: tap to view thread */}
        <Pressable onPress={onPress}>
          <View className="self-start mb-2 bg-[#ece6c2] px-2 py-0.5 border border-black rounded-[2px]">
            <Text className="text-[10px] font-black uppercase text-black">{post.category}</Text>
          </View>

          <Text className="text-base font-black text-black leading-snug mb-1.5">
            {post.title}
          </Text>
        </Pressable>

        {/* Narrative Dilemma or Sensitive Spoiler Warning */}
        {!revealed ? (
          <Pressable
            onPress={() => setRevealed(true)}
            className="p-3 bg-[#ece6c2] border-2 border-black rounded-[2px] items-center justify-center mb-3 active:bg-[#dfd9b3]">
            <Text className="text-xs font-black text-black">⚠️ Sensitive Dating Dilemma</Text>
            <Text className="text-[10px] font-semibold text-[#555] mt-0.5">
              Tap to reveal dilemma story
            </Text>
          </Pressable>
        ) : (
          <Pressable onPress={onPress}>
            <Text
              numberOfLines={expanded ? undefined : 3}
              className="text-xs text-[#222] font-medium leading-relaxed mb-3">
              {post.question}
            </Text>
          </Pressable>
        )}

        {/* Community Verdict Voting Bar */}
        <VerdictVoteBar
          redFlagCount={post.redFlagCount}
          greenFlagCount={post.greenFlagCount}
          validCount={post.validCount}
          userVote={post.myVote || post.userVote}
          onVote={onVote}
        />
      </View>

      {/* 3. Action Bar directly below card */}
      <View className="flex-row items-center justify-between mb-2 pt-1 border-t border-black/10">
        {/* Left Icons: Heart, Chat, Paper Plane */}
        <View className="flex-row items-center gap-3">
          <Pressable
            unstable_pressDelay={0}
            onPress={handleLikePress}
            className="active:translate-y-0.5">
            <Ionicons
              name={isLiked ? 'heart' : 'heart-outline'}
              size={24}
              color={isLiked ? '#d72a2a' : '#000'}
            />
          </Pressable>

          <Pressable
            unstable_pressDelay={0}
            onPress={onPress}
            className="active:translate-y-0.5">
            <Ionicons name="chatbubble-outline" size={22} color="#000" />
          </Pressable>

          <Pressable
            unstable_pressDelay={0}
            onPress={() =>
              Share.share({
                message: `"${post.title}" — What's your verdict on Tea Dating Advice?`,
              }).catch(() => {})
            }
            className="active:translate-y-0.5">
            <Ionicons name="paper-plane-outline" size={22} color="#000" />
          </Pressable>
        </View>

        {/* Right Icon: Bookmark / Save */}
        <Pressable
          unstable_pressDelay={0}
          onPress={handleSavePress}
          className="active:translate-y-0.5">
          <Ionicons
            name={isSaved ? 'bookmark' : 'bookmark-outline'}
            size={22}
            color={isSaved ? '#cc6b49' : '#000'}
          />
        </Pressable>
      </View>

      {/* 4. Engagement & Comments Summary (matching inspiration) */}
      <View className="gap-1 mt-1">
        {/* Likes Count */}
        <Text className="text-xs font-bold text-black">
          {localLikeCount} Likes
        </Text>

        {/* Caption with Author Name and 'more' button */}
        <Text className="text-xs text-black leading-snug">
          <Text className="font-bold text-black">{post.authorHandle || post.author} </Text>
          <Text className="text-[#333]">
            {expanded ? post.question : post.question.slice(0, 85) + '...'}
          </Text>
          {!expanded ? (
            <Text
              onPress={() => setExpanded(true)}
              className="text-xs font-bold text-[#6e6e6e]">
              {' '}more
            </Text>
          ) : null}
        </Text>

        {/* View all comments link */}
        <Pressable onPress={onPress} className="mt-0.5">
          <Text className="text-[11px] font-semibold text-[#6e6e6e]">
            View all {post.commentCount} comments
          </Text>
        </Pressable>

        {/* Inline Comment & Reaction Row (matching inspiration: Add a comment... + 🙌 / ☕ / 🚩) */}
        <View className="flex-row items-center justify-between mt-1.5 pt-1.5 border-t border-black/5">
          <Pressable onPress={onPress} className="flex-row items-center gap-2 flex-1 py-1">
            <BrutalistAvatar name="You" imageUrl={currentUserPhotoUrl} size={20} shape="square" />
            <Text className="flex-1 text-xs text-[#888]">
              Add a comment...
            </Text>
          </Pressable>

          {/* Quick Reaction Emojis from inspiration */}
          <View className="flex-row items-center gap-2.5">
            <Pressable
              unstable_pressDelay={0}
              onPress={() => handlePostQuickReaction('🙌')}
              className="active:translate-y-0.5">
              <Text className="text-sm">🙌</Text>
            </Pressable>
            <Pressable
              unstable_pressDelay={0}
              onPress={() => handlePostQuickReaction('☕')}
              className="active:translate-y-0.5">
              <Text className="text-sm">☕</Text>
            </Pressable>
            <Pressable
              unstable_pressDelay={0}
              onPress={() => handlePostQuickReaction('🚩')}
              className="active:translate-y-0.5">
              <Text className="text-sm">🚩</Text>
            </Pressable>
          </View>
        </View>

        {/* Timestamp */}
        <Text className="text-[10px] text-[#6e6e6e] mt-1">
          {timeAgo(post.createdAt)}
        </Text>
      </View>
    </View>
  );
}
