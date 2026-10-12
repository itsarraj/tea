import React, { useState, useEffect, useRef } from 'react';
import {
  Alert,
  Pressable,
  ScrollView,
  Share,
  StatusBar,
  Text,
  View,
} from 'react-native';
import { router, useLocalSearchParams } from 'expo-router';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { Feather, Ionicons } from '@expo/vector-icons';

import { BrutalistAvatar } from '@/components/tea/BrutalistAvatar';
import { BrutalButton, BrutalCard, EmptyState, LoadingState, VerdictVoteBar } from '@/components/tea/ui';
import {
  useAdvisorProfile,
  useBlockUser,
  useFeed,
  useProfile,
  useReportUser,
  useToggleFollow,
  useVoteVerdict,
} from '@/hooks/useDating';

export default function AdvisorProfileScreen() {
  const { id } = useLocalSearchParams<{ id: string }>();
  const insets = useSafeAreaInsets();
  const me = useProfile();
  const advisorQuery = useAdvisorProfile(id);
  const toggleFollow = useToggleFollow();
  const voteVerdict = useVoteVerdict();
  const feedQuery = useFeed();
  const blockUser = useBlockUser();
  const reportUser = useReportUser();

  const advisor = advisorQuery.data;
  const isSelf = Boolean(
    id === 'me' ||
    (advisor && me.data?.user_id && advisor.id.toLowerCase() === me.data.user_id.toLowerCase()) ||
    (advisor && me.data?.handle && advisor.handle.toLowerCase() === me.data.handle.toLowerCase()) ||
    (id && me.data?.user_id && id.toLowerCase() === me.data.user_id.toLowerCase()) ||
    (id && me.data?.handle && id.toLowerCase() === me.data.handle.toLowerCase()),
  );
  const allPosts = feedQuery.data?.pages.flat() ?? [];
  const advisorPosts = allPosts.filter(
    (p) =>
      p.authorId === id ||
      (advisor && (p.authorId === advisor.id || p.authorHandle.toLowerCase() === advisor.handle.toLowerCase())),
  );

  // Pillar 39: Local-first state for 0ms micro-interactions
  const [isFollowed, setIsFollowed] = useState(Boolean(advisor?.isFollowing));
  const [localFollowersCount, setLocalFollowersCount] = useState(advisor?.followersCount ?? 0);
  const displayedFollowed = useRef(Boolean(advisor?.isFollowing));

  useEffect(() => {
    if (displayedFollowed.current !== Boolean(advisor?.isFollowing)) {
      displayedFollowed.current = Boolean(advisor?.isFollowing);
      setIsFollowed(Boolean(advisor?.isFollowing));
      setLocalFollowersCount(advisor?.followersCount ?? 0);
    }
  }, [advisor?.isFollowing, advisor?.followersCount]);

  const handleFollowPress = () => {
    if (!advisor?.id) return;
    const next = !displayedFollowed.current;
    displayedFollowed.current = next;
    setIsFollowed(next);
    setLocalFollowersCount((prev) => (next ? prev + 1 : Math.max(0, prev - 1)));
    toggleFollow.mutate(advisor.id);
  };

  const back = () => (router.canGoBack() ? router.back() : router.replace('/(app)/advisors'));

  const handleSafetyAction = () => {
    if (!advisor) return;
    Alert.alert(
      'Advisor Options',
      `Options for ${advisor.name}:`,
      [
        {
          text: 'Share Advisor Profile',
          onPress: () => {
            Share.share({
              message: `Check out dating advisor ${advisor.name} (@${advisor.handle}) on Tea Dating Advice!`,
            }).catch(() => {});
          },
        },
        {
          text: 'Report Advisor',
          style: 'destructive',
          onPress: () => {
            Alert.alert('Report Reason', 'Why are you reporting this advisor?', [
              { text: 'Harassment / Abusive Advice', onPress: () => sendReport('Harassment') },
              { text: 'Spam / Solicitations', onPress: () => sendReport('Spam') },
              { text: 'Inappropriate Content', onPress: () => sendReport('Inappropriate') },
              { text: 'Cancel', style: 'cancel' },
            ]);
          },
        },
        {
          text: `Block ${advisor.name}`,
          style: 'destructive',
          onPress: () => {
            Alert.alert(
              'Block Advisor?',
              `You will no longer see dilemmas or advice from ${advisor.name}.`,
              [
                { text: 'Cancel', style: 'cancel' },
                {
                  text: 'Block',
                  style: 'destructive',
                  onPress: async () => {
                    try {
                      await blockUser.mutateAsync(advisor.id);
                      Alert.alert('Blocked', 'Advisor has been blocked.');
                      back();
                    } catch (e) {
                      Alert.alert('Error', e instanceof Error ? e.message : 'Could not block advisor');
                    }
                  },
                },
              ],
            );
          },
        },
        { text: 'Cancel', style: 'cancel' },
      ],
    );
  };

  const sendReport = async (reason: string) => {
    if (!advisor) return;
    try {
      await reportUser.mutateAsync({
        userId: advisor.id,
        reason,
        details: `Advisor profile: ${advisor.name} (@${advisor.handle})`,
      });
      Alert.alert('Report Submitted', 'Thank you. Our moderators will review this account.');
    } catch (e) {
      Alert.alert('Error', e instanceof Error ? e.message : 'Could not submit report');
    }
  };

  if (advisorQuery.isLoading) {
    return <LoadingState message="Loading advisor dossier..." />;
  }

  if (!advisor) {
    return (
      <View className="flex-1 bg-[#ece6c2] items-center justify-center p-6">
        <Text className="text-base font-black text-black mb-3">Advisor not found</Text>
        <BrutalButton label="Back to Leaderboard" onPress={back} variant="mint" />
      </View>
    );
  }

  return (
    <View className="flex-1 bg-[#ece6c2]" style={{ paddingTop: insets.top }}>
      <StatusBar barStyle="dark-content" backgroundColor="#ece6c2" />

      {/* Screen Header */}
      <View className="flex-row items-center justify-between px-5 py-3 border-b-2 border-black bg-[#ece6c2]">
        <View className="flex-row items-center gap-3">
          <Pressable
            onPress={back}
            className="w-10 h-10 rounded-[2px] bg-white border-2 border-black items-center justify-center active:translate-y-0.5"
            style={{
              shadowColor: '#000',
              shadowOffset: { width: -2, height: 2 },
              shadowOpacity: 1,
              shadowRadius: 0,
              elevation: 3,
            }}>
            <Feather name="arrow-left" size={20} color="#000" />
          </Pressable>
          <Text className="text-xl font-black text-black">Advisor Dossier</Text>
        </View>

        <View className="flex-row items-center gap-2">
          <View className="bg-black px-2 py-0.5 rounded-[2px]">
            <Text className="text-[10px] font-black uppercase text-white tracking-wider">
              {isSelf ? 'You' : advisor.rank?.startsWith('#') ? `Rank ${advisor.rank}` : `Rank #${advisor.rank}`}
            </Text>
          </View>
          {isSelf ? (
            <Pressable
              onPress={() => router.push('/(app)/edit-profile')}
              className="w-8 h-8 rounded-[2px] bg-tea-mint border border-black items-center justify-center active:translate-y-0.5"
              style={{
                shadowColor: '#000',
                shadowOffset: { width: -1.5, height: 1.5 },
                shadowOpacity: 1,
                shadowRadius: 0,
                elevation: 2,
              }}>
              <Feather name="edit-3" size={15} color="#000" />
            </Pressable>
          ) : (
            <Pressable
              onPress={handleSafetyAction}
              className="w-8 h-8 rounded-[2px] bg-white border border-black items-center justify-center active:translate-y-0.5"
              style={{
                shadowColor: '#000',
                shadowOffset: { width: -1.5, height: 1.5 },
                shadowOpacity: 1,
                shadowRadius: 0,
                elevation: 2,
              }}>
              <Feather name="more-vertical" size={16} color="#000" />
            </Pressable>
          )}
        </View>
      </View>

      <ScrollView
        showsVerticalScrollIndicator={false}
        contentContainerStyle={{ padding: 20, paddingBottom: insets.bottom + 40 }}>
        {/* Profile Card Header matching HTML Snippet 2 */}
        <View className="flex-row items-center justify-between gap-4 mb-4">
          <BrutalistAvatar
            name={advisor.name}
            handle={advisor.handle}
            imageUrl={advisor.photoUrl}
            size={80}
            shape="square"
          />

          {/* 3 Stat Boxes */}
          <View
            className="flex-1 flex-row justify-around bg-white border-2 border-black py-2.5 px-1 rounded-[3px]"
            style={{
              shadowColor: '#000',
              shadowOffset: { width: -3, height: 3 },
              shadowOpacity: 1,
              shadowRadius: 0,
              elevation: 4,
            }}>
            <View className="items-center">
              <Text className="text-base font-black text-black">
                {advisor.postsCount ?? advisorPosts.length}
              </Text>
              <Text className="text-[11px] font-semibold text-[#444]">Posts</Text>
            </View>
            <View className="w-[1.5px] bg-black my-0.5" />
            <View className="items-center">
              <Text className="text-base font-black text-black">
                {localFollowersCount.toLocaleString()}
              </Text>
              <Text className="text-[11px] font-semibold text-[#444]">Followers</Text>
            </View>
            <View className="w-[1.5px] bg-black my-0.5" />
            <View className="items-center">
              <Text className="text-base font-black text-black">
                {advisor.upvotesCount ? `${(advisor.upvotesCount / 1000).toFixed(1)}k` : `${advisor.helpfulPercent ? advisor.helpfulPercent : 95}%`}
              </Text>
              <Text className="text-[11px] font-semibold text-[#444]">Trust</Text>
            </View>
          </View>
        </View>

        {/* Bio details */}
        <View className="mb-4">
          <View className="flex-row items-center gap-2 mb-1">
            <Text className="text-lg font-black text-black">{advisor.name}</Text>
            <View className="bg-tea-mint px-2 py-0.5 border border-black rounded-[2px]">
              <Text className="text-[10px] font-black uppercase text-black">
                {advisor.specialty}
              </Text>
            </View>
          </View>

          <Text className="text-xs font-semibold text-[#555] mb-2">
            @{advisor.handle} • {advisor.city || 'Online'}
          </Text>

          <Text className="text-sm font-medium text-black leading-relaxed mb-3">
            {advisor.bio}
          </Text>

          {/* Verified Advisor Trust Notice */}
          <View className="p-2.5 bg-white border border-black rounded-[2px] flex-row items-center gap-2">
            <Ionicons name="shield-checkmark" size={14} color="#0EA8FF" />
            <Text className="text-[11px] font-bold text-black flex-1">
              Verified Dating Advisor • High Community Trust Rating
            </Text>
          </View>
        </View>

        {/* Action CTAs */}
        {isSelf ? (
          <View className="flex-row items-center gap-3 mb-6">
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
              <Text className="text-sm font-black text-black">Edit Profile</Text>
            </Pressable>

            <Pressable
              onPress={() => router.push('/(app)/settings')}
              className="flex-1 h-11 bg-[#ece6c2] border-2 border-black rounded-[3px] items-center justify-center flex-row gap-2 active:translate-y-0.5"
              style={{
                shadowColor: '#000',
                shadowOffset: { width: -3, height: 4 },
                shadowOpacity: 1,
                shadowRadius: 0,
                elevation: 4,
              }}>
              <Feather name="settings" size={16} color="#000" />
              <Text className="text-sm font-black text-black">Settings</Text>
            </Pressable>
          </View>
        ) : (
          <View className="flex-row items-center gap-3 mb-6">
            <Pressable
              unstable_pressDelay={0}
              onPress={handleFollowPress}
              className={`flex-1 h-11 border-2 border-black rounded-[3px] items-center justify-center flex-row gap-2 active:translate-y-0.5 ${
                isFollowed ? 'bg-[#ece6c2]' : 'bg-[#73bda8]'
              }`}
              style={{
                shadowColor: '#000',
                shadowOffset: { width: -3, height: 4 },
                shadowOpacity: 1,
                shadowRadius: 0,
                elevation: 4,
              }}>
              <Feather
                name={isFollowed ? 'check' : 'user-plus'}
                size={16}
                color="#000"
              />
              <Text className="text-sm font-black text-black">
                {isFollowed ? 'Following' : `Follow (${localFollowersCount})`}
              </Text>
            </Pressable>

            <Pressable
              onPress={() => router.push(`/(app)/chat/${advisor.id}`)}
              className="flex-1 h-11 bg-[#32b5ff] border-2 border-black rounded-[3px] items-center justify-center flex-row gap-2 active:translate-y-0.5"
              style={{
                shadowColor: '#000',
                shadowOffset: { width: -3, height: 4 },
                shadowOpacity: 1,
                shadowRadius: 0,
                elevation: 4,
              }}>
              <Feather name="message-square" size={16} color="#000" />
              <Text className="text-sm font-black text-black">Direct Advice</Text>
            </Pressable>
          </View>
        )}

        {/* Section title */}
        <View className="flex-row items-center justify-between mb-3 px-1">
          <Text className="text-xs font-black uppercase tracking-wider text-black">
            Spilled Advice by {advisor.name}
          </Text>
          <Text className="text-[10px] font-bold text-[#666]">
            {advisorPosts.length} Discussions
          </Text>
        </View>

        {/* Advisor's Advice Posts */}
        {advisorPosts.length === 0 ? (
          <EmptyState
            icon="feather"
            title="No public dilemmas yet"
            description={
              isSelf
                ? 'You have not spilled any dilemmas yet. Ask for advice or share your perspective.'
                : 'This advisor primarily offers 1-on-1 private advice sessions.'
            }
            actionLabel={isSelf ? '+ Spill First Dilemma' : 'Message Advisor'}
            onAction={() =>
              isSelf ? router.push('/(app)/new-post') : router.push(`/(app)/chat/${advisor.id}`)
            }
          />
        ) : (
          advisorPosts.map((post) => (
            <View
              key={post.id}
              className="mb-4">
              <BrutalCard variant="white">
                <Pressable onPress={() => router.push(`/(app)/post/${post.id}`)}>
                  <View className="flex-row items-center justify-between mb-1.5">
                    <View className="bg-[#ece6c2] px-2 py-0.5 border border-black rounded-[2px]">
                      <Text className="text-[10px] font-black uppercase text-black">
                        {post.category}
                      </Text>
                    </View>
                    <Text className="text-[11px] font-semibold text-[#666]">
                      {post.commentCount} replies • {post.likeCount} upvotes
                    </Text>
                  </View>

                  <Text className="text-base font-black text-black leading-snug mb-1">
                    {post.title}
                  </Text>
                  <Text className="text-xs text-[#333] font-medium leading-relaxed line-clamp-3 mb-3">
                    {post.question}
                  </Text>
                </Pressable>

                <VerdictVoteBar
                  redCount={post.redFlagCount}
                  greenCount={post.greenFlagCount}
                  validCount={post.validCount}
                  userVote={post.userVote || post.myVote}
                  onVote={(v) => voteVerdict.mutate({ postId: post.id, vote: v })}
                />
              </BrutalCard>
            </View>
          ))
        )}
      </ScrollView>
    </View>
  );
}
