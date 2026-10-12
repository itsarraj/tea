import React, { useState, useEffect, useRef } from 'react';
import {
  FlatList,
  Pressable,
  StatusBar,
  Text,
  View,
} from 'react-native';
import { router } from 'expo-router';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import Svg, { Path } from 'react-native-svg';

import { BrutalistAvatar } from '@/components/tea/BrutalistAvatar';
import { BrutalCard, EmptyState, ErrorState, LoadingState } from '@/components/tea/ui';
import { brand } from '@/constants/brand';
import { useAdvisors, useProfile, useToggleFollow } from '@/hooks/useDating';
import type { AdvisorPerson } from '@/lib/fixtures';

export default function AdvisorsScreen() {
  const insets = useSafeAreaInsets();
  const me = useProfile();
  const advisors = useAdvisors();
  const follow = useToggleFollow();

  const list = advisors.data ?? [];

  const rankColor = (idx: number) => {
    if (idx === 0) return '#FFD166'; // 1st Gold
    if (idx === 1) return '#32B5FF'; // 2nd Silver/Blue
    if (idx === 2) return '#73BDA8'; // 3rd Mint
    return '#ECE6C2';
  };

  const rankEmoji = (idx: number) => {
    if (idx === 0) return '👑 #1';
    if (idx === 1) return '🥈 #2';
    if (idx === 2) return '🥉 #3';
    return `#${idx + 1}`;
  };

  return (
    <View style={{ flex: 1, backgroundColor: brand.canvas, paddingTop: insets.top }}>
      <StatusBar barStyle="dark-content" />

      {/* Header */}
      <View
        style={{
          paddingHorizontal: 16,
          paddingVertical: 14,
          backgroundColor: '#ECE6C2',
          borderBottomWidth: 2,
          borderBottomColor: '#000000',
        }}>
        <View style={{ flexDirection: 'row', alignItems: 'center', justifyContent: 'space-between' }}>
          <View>
            <Text
              style={{
                fontSize: 22,
                fontWeight: '900',
                color: '#020202',
                fontFamily: 'HankenGrotesk-Black',
                letterSpacing: -0.5,
              }}>
              Top Advisors 🏆
            </Text>
            <Text
              style={{
                fontSize: 11,
                fontWeight: '600',
                color: '#6E6E6E',
                marginTop: 2,
              }}>
              Community-voted best dating advice givers
            </Text>
          </View>

          <View
            style={{
              paddingHorizontal: 8,
              paddingVertical: 4,
              backgroundColor: '#73BDA8',
              borderWidth: 1.5,
              borderColor: '#000000',
              borderRadius: 6,
            }}>
            <Text style={{ fontSize: 10, fontWeight: '800', color: '#020202' }}>
              Fan Following
            </Text>
          </View>
        </View>
      </View>

      {/* Advisors Leaderboard List */}
      <FlatList
        data={list}
        keyExtractor={(item) => item.id}
        contentContainerStyle={{ padding: 16, paddingBottom: insets.bottom + 24 }}
        showsVerticalScrollIndicator={false}
        refreshing={advisors.isRefetching}
        onRefresh={() => advisors.refetch()}
        ListEmptyComponent={
          advisors.isLoading ? (
            <LoadingState message="Ranking top advisors…" />
          ) : advisors.isError ? (
            <ErrorState error={advisors.error} onRetry={() => advisors.refetch()} />
          ) : (
            <EmptyState emoji="👑" title="No advisors yet" body="Be the first to give great dating advice." />
          )
        }
        renderItem={({ item, index }) => {
          const isSelf = Boolean(
            (item.id && item.id.toLowerCase() === me.data?.user_id?.toLowerCase()) ||
            (item.handle && me.data?.handle && item.handle.toLowerCase() === me.data.handle.toLowerCase())
          );
          return (
            <LeaderboardAdvisorCard
              item={item}
              index={index}
              isSelf={isSelf}
              rankColor={rankColor}
              rankEmoji={rankEmoji}
              onFollow={() => follow.mutate(item.id)}
            />
          );
        }}
      />
    </View>
  );
}

function LeaderboardAdvisorCard({
  item,
  index,
  isSelf,
  rankColor,
  rankEmoji,
  onFollow,
}: {
  item: AdvisorPerson;
  index: number;
  isSelf: boolean;
  rankColor: (idx: number) => string;
  rankEmoji: (idx: number) => string;
  onFollow: () => void;
}) {
  const [isFollowing, setIsFollowing] = useState(Boolean(item.isFollowing));
  const [localFollowersCount, setLocalFollowersCount] = useState(item.followersCount);
  const displayedFollowing = useRef(Boolean(item.isFollowing));

  useEffect(() => {
    if (displayedFollowing.current !== Boolean(item.isFollowing)) {
      displayedFollowing.current = Boolean(item.isFollowing);
      setIsFollowing(Boolean(item.isFollowing));
      setLocalFollowersCount(item.followersCount);
    }
  }, [item.isFollowing, item.followersCount]);

  const handleFollowPress = () => {
    const next = !displayedFollowing.current;
    displayedFollowing.current = next;
    setIsFollowing(next);
    setLocalFollowersCount((prev) => (next ? prev + 1 : Math.max(0, prev - 1)));
    onFollow();
  };

  return (
    <BrutalCard bg="#FFFFFF" shadowOffset={{ x: -2, y: 3 }}>
      <View style={{ flexDirection: 'row', alignItems: 'flex-start', gap: 12 }}>
        {/* Rank Pill */}
        <View
          style={{
            position: 'absolute',
            top: -6,
            right: -6,
            backgroundColor: rankColor(index),
            borderWidth: 1.5,
            borderColor: '#000000',
            borderRadius: 4,
            paddingHorizontal: 7,
            paddingVertical: 2,
            shadowColor: '#000000',
            shadowOffset: { width: 0, height: 1 },
            shadowOpacity: 1,
            shadowRadius: 0,
            zIndex: 2,
          }}>
          <Text style={{ fontSize: 10, fontWeight: '900', color: '#020202' }}>
            {rankEmoji(index)}
          </Text>
        </View>

        {/* Avatar */}
        <Pressable onPress={() => (isSelf ? router.push('/(app)/me') : router.push(`/(app)/profile/${item.id || item.handle}` as any))}>
          <BrutalistAvatar
            seed={item.handle}
            name={item.name}
            imageUrl={item.photoUrl}
            size={52}
            shape="rounded"
            badge={index < 3 ? 'advisor' : 'none'}
          />
        </Pressable>

        {/* Details */}
        <View style={{ flex: 1, paddingRight: 40 }}>
          <Pressable onPress={() => (isSelf ? router.push('/(app)/me') : router.push(`/(app)/profile/${item.id || item.handle}` as any))}>
            <Text
              style={{
                fontSize: 15,
                fontWeight: '900',
                color: '#020202',
                fontFamily: 'HankenGrotesk-Bold',
              }}>
              {item.name}
            </Text>
            <Text style={{ fontSize: 11, color: '#6E6E6E' }}>
              @{item.handle} · {item.city}
            </Text>
          </Pressable>

          <View style={{ alignSelf: 'flex-start', marginVertical: 4 }}>
            <View
              style={{
                backgroundColor: '#ECE6C2',
                paddingHorizontal: 6,
                paddingVertical: 1.5,
                borderRadius: 4,
                borderWidth: 1,
                borderColor: '#000000',
              }}>
              <Text style={{ fontSize: 9, fontWeight: '700', color: '#020202' }}>
                {item.specialty}
              </Text>
            </View>
          </View>

          <Text
            numberOfLines={2}
            style={{ fontSize: 12, color: '#131313', lineHeight: 16, marginTop: 2 }}>
            {item.bio}
          </Text>
        </View>
      </View>

      {/* Quote Snippet */}
      <View
        style={{
          marginTop: 10,
          backgroundColor: '#ECE6C2',
          borderWidth: 1.5,
          borderColor: '#000000',
          borderRadius: 6,
          padding: 8,
        }}>
        <Text style={{ fontSize: 10, fontWeight: '800', color: '#020202', marginBottom: 2 }}>
          💬 Notable Advice:
        </Text>
        <Text
          style={{ fontSize: 11, color: '#020202', fontStyle: 'italic', lineHeight: 15 }}>
          "{item.recentAdviceQuote}"
        </Text>
      </View>

      {/* Bottom Fan Following & Follow CTA */}
      <View
        style={{
          flexDirection: 'row',
          alignItems: 'center',
          justifyContent: 'space-between',
          marginTop: 10,
          paddingTop: 8,
          borderTopWidth: 1,
          borderTopColor: '#DFDFE8',
        }}>
        <View style={{ flexDirection: 'row', gap: 12 }}>
          <View>
            <Text style={{ fontSize: 12, fontWeight: '800', color: '#020202' }}>
              {localFollowersCount}
            </Text>
            <Text style={{ fontSize: 9, color: '#6E6E6E', fontWeight: '600' }}>
              Followers
            </Text>
          </View>
          <View>
            <Text style={{ fontSize: 12, fontWeight: '800', color: '#020202' }}>
              {item.adviceGivenCount}
            </Text>
            <Text style={{ fontSize: 9, color: '#6E6E6E', fontWeight: '600' }}>
              Advice Given
            </Text>
          </View>
          <View>
            <Text style={{ fontSize: 12, fontWeight: '800', color: '#73BDA8' }}>
              {item.helpfulPercent}%
            </Text>
            <Text style={{ fontSize: 9, color: '#6E6E6E', fontWeight: '600' }}>
              Helpful Rate
            </Text>
          </View>
        </View>

        {/* Follow Button / Self Badge */}
        {isSelf ? (
          <View
            style={{
              paddingHorizontal: 12,
              paddingVertical: 6,
              borderRadius: 6,
              borderWidth: 1.5,
              borderColor: '#000000',
              backgroundColor: '#73BDA8',
            }}>
            <Text style={{ fontSize: 11, fontWeight: '900', color: '#020202' }}>YOU</Text>
          </View>
        ) : (
          <Pressable
            unstable_pressDelay={0}
            onPress={handleFollowPress}
            style={{
              paddingHorizontal: 14,
              paddingVertical: 6,
              borderRadius: 6,
              borderWidth: 1.5,
              borderColor: '#000000',
              backgroundColor: isFollowing ? '#ECE6C2' : '#0E9BEA',
              shadowColor: '#000000',
              shadowOffset: { width: 0, height: 2 },
              shadowOpacity: 1,
              shadowRadius: 0,
            }}>
            <Text
              style={{
                fontSize: 11,
                fontWeight: '800',
                color: isFollowing ? '#020202' : '#FFFFFF',
              }}>
              {isFollowing ? '✓ Following' : '+ Follow'}
            </Text>
          </Pressable>
        )}
      </View>
    </BrutalCard>
  );
}
