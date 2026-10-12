import React, { useState } from 'react';
import {
  Pressable,
  ScrollView,
  StatusBar,
  Text,
  View,
} from 'react-native';
import { router } from 'expo-router';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { Feather, Ionicons } from '@expo/vector-icons';

import { BrutalistAvatar } from '@/components/tea/BrutalistAvatar';
import { BrutalButton, BrutalCard, EmptyState, LoadingState, VerdictVoteBar } from '@/components/tea/ui';
import { brand } from '@/constants/brand';
import { useFeed, useNotifications, useProfile, useToggleLike, useToggleSave, useVoteVerdict } from '@/hooks/useDating';
import type { FeedPost } from '@/lib/fixtures';

export default function MeScreen() {
  const insets = useSafeAreaInsets();
  const me = useProfile();
  const myPostsQuery = useFeed(me.data?.user_id ? { authorId: me.data.user_id } : undefined);
  const savedPostsQuery = useFeed({ saved: true });
  const notifications = useNotifications();
  const toggleLike = useToggleLike();
  const toggleSave = useToggleSave();
  const voteVerdict = useVoteVerdict();

  const [activeTab, setActiveTab] = useState<'my_posts' | 'saved' | 'stats'>('my_posts');

  if (me.isLoading) return <LoadingState message="Loading advisor profile..." />;
  if (me.isError || !me.data) {
    return (
      <View className="flex-1 bg-tea-canvas items-center justify-center p-6">
        <Text className="text-base font-bold text-black mb-3">Could not load profile.</Text>
        <BrutalButton label="Retry" onPress={() => me.refetch()} variant="mint" />
      </View>
    );
  }

  const p = me.data;
  const myPosts = myPostsQuery.data?.pages.flat() ?? [];
  const savedPosts = savedPostsQuery.data?.pages.flat() ?? [];
  const unreadCount = notifications.data?.filter((n) => !n.read).length ?? 0;

  const postsCount = p.postsCount ?? myPosts.length;
  const followersCount = p.followersCount ?? 0;
  const followingCount = p.followingCount ?? 0;

  return (
    <View className="flex-1 bg-[#ece6c2]" style={{ paddingTop: insets.top }}>
      <StatusBar barStyle="dark-content" backgroundColor="#ece6c2" />

      {/* Header */}
      <View className="flex-row items-center justify-between px-5 py-3 border-b-2 border-black bg-[#ece6c2]">
        <View className="flex-row items-center gap-2">
          <Text className="text-xl font-black text-black tracking-tight">
            @{p.handle || (p.display_name ? p.display_name.toLowerCase().replace(/\s+/g, '_') : 'advisor')}
          </Text>
          <View className="bg-black px-2 py-0.5 rounded-[2px]">
            <Text className="text-[10px] font-bold text-white uppercase tracking-wider">Advisor</Text>
          </View>
        </View>

        <View className="flex-row items-center gap-3">
          <Pressable
            onPress={() => router.push('/(app)/notifications')}
            className="w-10 h-10 rounded-[2px] bg-white border-2 border-black items-center justify-center relative active:translate-y-0.5"
            style={{
              shadowColor: '#000',
              shadowOffset: { width: -2, height: 2 },
              shadowOpacity: 1,
              shadowRadius: 0,
              elevation: 3,
            }}>
            <Ionicons name="notifications-outline" size={20} color="#000" />
            {unreadCount > 0 ? (
              <View className="absolute -top-1.5 -right-1.5 min-w-[18px] h-[18px] bg-tea-red border border-black rounded-full items-center justify-center px-1">
                <Text className="text-[9px] font-black text-white">{unreadCount}</Text>
              </View>
            ) : null}
          </Pressable>

          <Pressable
            onPress={() => router.push('/(app)/settings')}
            className="w-10 h-10 rounded-[2px] bg-white border-2 border-black items-center justify-center active:translate-y-0.5"
            style={{
              shadowColor: '#000',
              shadowOffset: { width: -2, height: 2 },
              shadowOpacity: 1,
              shadowRadius: 0,
              elevation: 3,
            }}>
            <Feather name="settings" size={20} color="#000" />
          </Pressable>
        </View>
      </View>

      <ScrollView
        showsVerticalScrollIndicator={false}
        contentContainerStyle={{ paddingBottom: insets.bottom + 90 }}>
        {/* Profile Card & Stats Section (Direct match to HTML snippet 2) */}
        <View className="px-5 pt-4 pb-4">
          <View className="flex-row items-center justify-between gap-4">
            {/* Profile Avatar */}
            <View className="items-center">
              <BrutalistAvatar
                name={p.display_name}
                handle={p.handle}
                imageUrl={p.photos?.[0]?.url}
                size={82}
                shape="square"
              />
            </View>

            {/* 3 Stat Boxes matching HTML snippet 2: Posts (1,234), Followers (5,678), Following (9,101) */}
            <View className="flex-1 flex-row justify-around bg-white border-2 border-black py-2.5 px-1 rounded-[3px]"
              style={{
                shadowColor: '#000',
                shadowOffset: { width: -3, height: 3 },
                shadowOpacity: 1,
                shadowRadius: 0,
                elevation: 4,
              }}>
              <View className="items-center">
                <Text className="text-base font-black text-black">
                  {postsCount.toLocaleString()}
                </Text>
                <Text className="text-[11px] font-semibold text-[#444]">Posts</Text>
              </View>
              <View className="w-[1.5px] bg-black my-0.5" />
              <View className="items-center">
                <Text className="text-base font-black text-black">
                  {followersCount.toLocaleString()}
                </Text>
                <Text className="text-[11px] font-semibold text-[#444]">Followers</Text>
              </View>
              <View className="w-[1.5px] bg-black my-0.5" />
              <View className="items-center">
                <Text className="text-base font-black text-black">
                  {followingCount.toLocaleString()}
                </Text>
                <Text className="text-[11px] font-semibold text-[#444]">Following</Text>
              </View>
            </View>
          </View>

          {/* User Bio and Meta */}
          <View className="mt-3.5">
            <View className="flex-row items-center gap-2">
              <Text className="text-lg font-black text-black">{p.display_name || 'Advisor'}</Text>
              <View className="bg-tea-mint px-2 py-0.5 border border-black rounded-[2px]">
                <Text className="text-[10px] font-black text-black uppercase">
                  {p.rankTitle || 'Top Advisor'}
                </Text>
              </View>
            </View>

            <Text className="text-xs font-semibold text-[#666] mt-0.5">
              {[p.city, p.country].filter(Boolean).join(', ') || 'Global'} • {p.specialty || 'Dating Advisor'}
            </Text>

            <Text className="text-sm text-black font-medium mt-2 leading-relaxed">
              {p.about || 'Welcome to my Tea advisor profile! Share your dilemmas for honest feedback.'}
            </Text>

            {/* Advisor Verification Pill */}
            <View className="mt-3 flex-row items-center bg-[#fdfbef] border-2 border-black px-2.5 py-1.5 rounded-[2px] gap-2">
              <Ionicons name="shield-checkmark" size={14} color="#0EA8FF" />
              <Text className="text-[11px] font-bold text-black flex-1">
                Verified Tea Advisor Profile • Active Community Member
              </Text>
            </View>
          </View>

          {/* Action Buttons Row (Directly matching HTML snippet 2 buttons) */}
          <View className="flex-row items-center gap-2.5 mt-4">
            <Pressable
              onPress={() => router.push('/(app)/edit-profile')}
              className="flex-1 h-11 bg-[#73bda8] border-2 border-black rounded-[3px] items-center justify-center flex-row gap-2 active:translate-y-0.5"
              style={{
                shadowColor: '#000',
                shadowOffset: { width: -3, height: 4 },
                shadowOpacity: 1,
                shadowRadius: 0,
                elevation: 4,
              }}>
              <Feather name="edit-3" size={16} color="#000" />
              <Text className="text-sm font-black text-black">Edit profile</Text>
            </Pressable>

            <Pressable
              onPress={() => router.push('/(app)/new-post')}
              className="w-12 h-11 bg-[#32b5ff] border-2 border-black rounded-[3px] items-center justify-center active:translate-y-0.5"
              style={{
                shadowColor: '#000',
                shadowOffset: { width: -2, height: 4 },
                shadowOpacity: 1,
                shadowRadius: 0,
                elevation: 4,
              }}>
              <Feather name="plus" size={20} color="#000" />
            </Pressable>
          </View>
        </View>

        {/* Tab Selection */}
        <View className="flex-row border-y-2 border-black bg-white mt-2">
          <Pressable
            unstable_pressDelay={0}
            onPress={() => setActiveTab('my_posts')}
            className={`flex-1 py-3 items-center border-r-2 border-black ${
              activeTab === 'my_posts' ? 'bg-tea-mint' : 'bg-white'
            }`}>
            <Text className="text-xs font-black text-black uppercase tracking-wider">
              My Advice ({myPosts.length})
            </Text>
          </Pressable>

          <Pressable
            unstable_pressDelay={0}
            onPress={() => setActiveTab('saved')}
            className={`flex-1 py-3 items-center border-r-2 border-black ${
              activeTab === 'saved' ? 'bg-tea-mint' : 'bg-white'
            }`}>
            <Text className="text-xs font-black text-black uppercase tracking-wider">
              Saved Tea ({savedPosts.length})
            </Text>
          </Pressable>

          <Pressable
            unstable_pressDelay={0}
            onPress={() => setActiveTab('stats')}
            className={`flex-1 py-3 items-center ${activeTab === 'stats' ? 'bg-tea-mint' : 'bg-white'}`}>
            <Text className="text-xs font-black text-black uppercase tracking-wider">Trust Stats</Text>
          </Pressable>
        </View>

        {/* Content by Tab */}
        <View className="px-5 pt-4">
          {activeTab === 'my_posts' ? (
            myPosts.length === 0 ? (
              <EmptyState
                icon="message-square"
                title="No advice posts yet"
                description="Share your dating dilemmas or drop spicy tea for the community."
                actionLabel="+ Spill First Tea"
                onAction={() => router.push('/(app)/new-post')}
              />
            ) : (
              myPosts.map((post) => (
                <ProfilePostCard
                  key={post.id}
                  post={post}
                  onPress={() => router.push(`/(app)/post/${post.id}`)}
                  onVote={(v) => voteVerdict.mutate({ postId: post.id, vote: v })}
                />
              ))
            )
          ) : activeTab === 'saved' ? (
            savedPosts.length === 0 ? (
              <EmptyState
                icon="bookmark"
                title="No saved advice yet"
                description="Save the most insightful dating situations and hot takes to read later."
                actionLabel="Explore Feed"
                onAction={() => router.push('/(app)')}
              />
            ) : (
              savedPosts.map((post) => (
                <ProfilePostCard
                  key={post.id}
                  post={post}
                  onPress={() => router.push(`/(app)/post/${post.id}`)}
                  onVote={(v) => voteVerdict.mutate({ postId: post.id, vote: v })}
                />
              ))
            )
          ) : (
            /* Stats / Advisor Metrics */
            <View className="gap-3.5">
              <BrutalCard variant="white">
                <Text className="text-xs font-black uppercase tracking-wider text-black mb-2">
                  Advisor Score & Credibility
                </Text>
                <View className="flex-row items-center justify-between py-2 border-b border-black/10">
                  <Text className="text-sm font-semibold text-black">Community Trust Rating</Text>
                  <Text className="text-base font-black text-tea-mint">{p.helpfulRating ?? 95}%</Text>
                </View>
                <View className="flex-row items-center justify-between py-2 border-b border-black/10">
                  <Text className="text-sm font-semibold text-black">Advice Given</Text>
                  <Text className="text-base font-black text-black">
                    {(p.adviceGivenCount ?? p.postsCount ?? 0).toLocaleString()}
                  </Text>
                </View>
                <View className="flex-row items-center justify-between py-2">
                  <Text className="text-sm font-semibold text-black">Fan Followers</Text>
                  <Text className="text-base font-black text-tea-blue">{followersCount.toLocaleString()}</Text>
                </View>
              </BrutalCard>

              <BrutalCard variant="paper">
                <Text className="text-xs font-black uppercase tracking-wider text-black mb-2">
                  Community Advice Oath
                </Text>
                <Text className="text-xs text-[#222] leading-relaxed">
                  1. Thoughtful dating advice: share candid wisdom and constructive takes.{'\n'}
                  2. Authentic advisor persona: procedural monogram or verified avatar.{'\n'}
                  3. Respect privacy: no sharing phone numbers, private chats, or doxxing.
                </Text>
              </BrutalCard>
            </View>
          )}
        </View>
      </ScrollView>
    </View>
  );
}

function ProfilePostCard({
  post,
  onPress,
  onVote,
}: {
  post: FeedPost;
  onPress: () => void;
  onVote: (vote: 'red' | 'green' | 'valid') => void;
}) {
  return (
    <View className="mb-4">
      <BrutalCard variant="white">
        <Pressable onPress={onPress}>
          <View className="flex-row items-center justify-between mb-2">
            <View className="bg-[#ece6c2] px-2 py-0.5 border border-black rounded-[2px]">
              <Text className="text-[10px] font-black uppercase text-black">{post.category}</Text>
            </View>
            <Text className="text-[11px] font-semibold text-[#666]">
              {post.commentCount} comments • {post.likeCount} likes
            </Text>
          </View>

          <Text className="text-base font-black text-black leading-snug mb-1">{post.title}</Text>
          <Text className="text-xs text-[#333] leading-relaxed line-clamp-3 mb-3">{post.question}</Text>
        </Pressable>

        {/* Verdict voting display */}
        <VerdictVoteBar
          redCount={post.redFlagCount}
          greenCount={post.greenFlagCount}
          validCount={post.validCount}
          userVote={post.userVote || post.myVote}
          onVote={onVote}
        />
      </BrutalCard>
    </View>
  );
}
