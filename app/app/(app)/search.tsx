import React, { useEffect, useState, useRef } from 'react';
import {
  FlatList,
  Pressable,
  ScrollView,
  StatusBar,
  Text,
  TextInput,
  View,
} from 'react-native';
import { router, useLocalSearchParams } from 'expo-router';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import Svg, { Circle, Path, Rect } from 'react-native-svg';

import { BrutalistAvatar } from '@/components/tea/BrutalistAvatar';
import {
  BrutalButton,
  BrutalCard,
  CategoryPill,
  EmptyState,
  ErrorState,
  LoadingState,
} from '@/components/tea/ui';
import { brand } from '@/constants/brand';
import {
  useAdvisors,
  useFeed,
  useProfile,
  useToggleFollow,
  useToggleLike,
  useToggleSave,
} from '@/hooks/useDating';
import type { AdvisorPerson, FeedPost } from '@/lib/fixtures';
import { TEA_CATEGORIES } from '@/lib/fixtures';

export default function SearchScreen() {
  const insets = useSafeAreaInsets();
  const params = useLocalSearchParams<{ query?: string }>();
  const [searchQuery, setSearchQuery] = useState(params.query || '');
  const [debouncedQuery, setDebouncedQuery] = useState(params.query || '');
  const [activeTab, setActiveTab] = useState<'advice' | 'people'>('advice');
  const [selectedTag, setSelectedTag] = useState<string | null>(null);

  useEffect(() => {
    if (params.query !== undefined) {
      setSearchQuery(params.query);
      setDebouncedQuery(params.query);
    }
  }, [params.query]);

  useEffect(() => {
    const timer = setTimeout(() => {
      setDebouncedQuery(searchQuery.trim());
    }, 250);
    return () => clearTimeout(timer);
  }, [searchQuery]);

  const handleClear = () => {
    setSearchQuery('');
    setDebouncedQuery('');
    setSelectedTag(null);
  };

  const handleSelectSuggestion = (tag: string) => {
    setSearchQuery(tag);
    setDebouncedQuery(tag);
    setSelectedTag(null);
  };

  const me = useProfile();
  const feed = useFeed({
    query: debouncedQuery || undefined,
    category: selectedTag && selectedTag !== 'All' ? selectedTag : undefined,
  });
  const advisorSearch = debouncedQuery || (selectedTag && selectedTag !== 'All' ? selectedTag : undefined);
  const advisors = useAdvisors(advisorSearch);
  const follow = useToggleFollow();
  const like = useToggleLike();
  const save = useToggleSave();

  const posts = feed.data?.pages.flat() ?? [];
  const advisorList = advisors.data ?? [];

  return (
    <View style={{ flex: 1, backgroundColor: brand.canvas, paddingTop: insets.top }}>
      <StatusBar barStyle="dark-content" />

      {/* 1. Header & Search Input (Matching HTML snippet 5) */}
      <View
        style={{
          paddingHorizontal: 16,
          paddingTop: 12,
          paddingBottom: 8,
          backgroundColor: '#ECE6C2',
          borderBottomWidth: 2,
          borderBottomColor: '#000000',
        }}>
        <Text
          style={{
            fontSize: 22,
            fontWeight: '900',
            color: '#020202',
            marginBottom: 10,
            fontFamily: 'HankenGrotesk-Black',
            letterSpacing: -0.5,
          }}>
          Search & Discover
        </Text>

        {/* Brutalist Search Box from HTML */}
        <View style={{ position: 'relative' }}>
          <View
            style={{
              position: 'absolute',
              top: 3,
              left: -1,
              right: 1,
              bottom: -3,
              backgroundColor: '#000000',
              borderRadius: 8,
            }}
          />
          <View
            style={{
              height: 40,
              backgroundColor: '#ECE6C2',
              borderRadius: 8,
              borderWidth: 2,
              borderColor: '#000000',
              flexDirection: 'row',
              alignItems: 'center',
              paddingHorizontal: 10,
              gap: 8,
            }}>
            <Svg width={16} height={16} viewBox="0 0 16 16" fill="none">
              <Circle cx={7} cy={7} r={5} stroke="#000000" strokeWidth={1.5} />
              <Path d="M11 11l4 4" stroke="#000000" strokeWidth={2} strokeLinecap="round" />
            </Svg>
            <TextInput
              value={searchQuery}
              onChangeText={setSearchQuery}
              placeholder="Search dating advice, questions, advisors..."
              placeholderTextColor="#6E6E6E"
              style={{
                flex: 1,
                fontSize: 13,
                color: '#020202',
                fontFamily: 'HankenGrotesk-Medium',
                paddingVertical: 0,
              }}
              returnKeyType="search"
            />
            {searchQuery ? (
              <Pressable
                onPress={() => {
                  setSearchQuery('');
                  setDebouncedQuery('');
                }}
                hitSlop={6}>
                <Text style={{ fontSize: 13, color: '#6E6E6E', fontWeight: '700' }}>✕</Text>
              </Pressable>
            ) : null}
          </View>
        </View>

        {/* Horizontal Category Chips from HTML */}
        <ScrollView
          horizontal
          showsHorizontalScrollIndicator={false}
          contentContainerStyle={{ gap: 8, paddingTop: 10, paddingBottom: 4 }}>
          {TEA_CATEGORIES.map((tag) => {
            const active = (tag === 'All' && !selectedTag) || selectedTag === tag;
            return (
              <Pressable
                key={tag}
                onPress={() => setSelectedTag(tag === 'All' || selectedTag === tag ? null : tag)}
                style={{
                  paddingHorizontal: 12,
                  paddingVertical: 5,
                  borderRadius: 4,
                  borderWidth: active ? 2 : 1,
                  borderColor: '#000000',
                  backgroundColor: active ? '#73BDA8' : '#ECE6C2',
                  shadowColor: '#000000',
                  shadowOffset: { width: 0, height: 1 },
                  shadowOpacity: 1,
                  shadowRadius: 0,
                }}>
                <Text
                  style={{
                    fontSize: 11,
                    fontWeight: active ? '800' : '600',
                    color: '#020202',
                  }}>
                  {tag}
                </Text>
              </Pressable>
            );
          })}
        </ScrollView>

        {/* Active Search & Filter Indicator */}
        {(selectedTag || debouncedQuery) ? (
          <View
            style={{
              flexDirection: 'row',
              alignItems: 'center',
              justifyContent: 'space-between',
              paddingTop: 8,
              paddingBottom: 2,
            }}>
            <Text style={{ fontSize: 11, fontWeight: '700', color: '#6E6E6E' }}>
              Active filter:{' '}
              <Text style={{ color: '#020202', fontWeight: '800' }}>
                {[debouncedQuery ? `"${debouncedQuery}"` : null, selectedTag ? selectedTag : null].filter(Boolean).join(' in ')}
              </Text>
            </Text>
            <Pressable onPress={handleClear} hitSlop={6}>
              <Text style={{ fontSize: 11, fontWeight: '800', color: '#0E9BEA' }}>Clear all</Text>
            </Pressable>
          </View>
        ) : null}
      </View>

      {/* 2. Mode Selector: Advice Posts vs Top Advisors (People) */}
      <View
        style={{
          flexDirection: 'row',
          paddingHorizontal: 16,
          paddingVertical: 8,
          gap: 10,
        }}>
        <Pressable
          onPress={() => setActiveTab('advice')}
          style={{
            flex: 1,
            paddingVertical: 8,
            alignItems: 'center',
            borderRadius: 6,
            borderWidth: 2,
            borderColor: '#000000',
            backgroundColor: activeTab === 'advice' ? '#73BDA8' : '#ECE6C2',
            shadowColor: '#000000',
            shadowOffset: activeTab === 'advice' ? { width: -1, height: 2 } : { width: 0, height: 0 },
            shadowOpacity: activeTab === 'advice' ? 1 : 0,
            shadowRadius: 0,
          }}>
          <Text
            style={{
              fontSize: 13,
              fontWeight: activeTab === 'advice' ? '800' : '600',
              color: '#020202',
            }}>
            💡 Dating Advice ({feed.isLoading ? '...' : posts.length})
          </Text>
        </Pressable>

        <Pressable
          onPress={() => setActiveTab('people')}
          style={{
            flex: 1,
            paddingVertical: 8,
            alignItems: 'center',
            borderRadius: 6,
            borderWidth: 2,
            borderColor: '#000000',
            backgroundColor: activeTab === 'people' ? '#32B5FF' : '#ECE6C2',
            shadowColor: '#000000',
            shadowOffset: activeTab === 'people' ? { width: -1, height: 2 } : { width: 0, height: 0 },
            shadowOpacity: activeTab === 'people' ? 1 : 0,
            shadowRadius: 0,
          }}>
          <Text
            style={{
              fontSize: 13,
              fontWeight: activeTab === 'people' ? '800' : '600',
              color: '#020202',
            }}>
            👥 Advisors & People ({advisors.isLoading ? '...' : advisorList.length})
          </Text>
        </Pressable>
      </View>

      {/* 3. Results Content */}
      {activeTab === 'advice' ? (
        <FlatList
          data={posts}
          keyExtractor={(item) => item.id}
          keyboardShouldPersistTaps="handled"
          keyboardDismissMode="on-drag"
          contentContainerStyle={{ paddingHorizontal: 16, paddingBottom: insets.bottom + 20 }}
          showsVerticalScrollIndicator={false}
          refreshing={feed.isRefetching}
          onRefresh={() => feed.refetch()}
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
              <View style={{ alignItems: 'center' }}>
                <EmptyState
                  emoji="🔍"
                  title="No advice found"
                  body={
                    debouncedQuery || selectedTag
                      ? `No dating advice matching "${[debouncedQuery, selectedTag].filter(Boolean).join(' · ')}". Try different keywords or select a popular category below.`
                      : 'Search above for questions, red flags, or advice topics.'
                  }
                  actionLabel={debouncedQuery || selectedTag ? 'Clear Filters' : undefined}
                  onAction={handleClear}
                />
                <View style={{ width: '100%', marginTop: 8 }}>
                  <Text
                    style={{
                      fontSize: 12,
                      fontWeight: '800',
                      color: '#020202',
                      marginBottom: 8,
                      textAlign: 'center',
                    }}>
                    Popular topics
                  </Text>
                  <View style={{ flexDirection: 'row', flexWrap: 'wrap', gap: 6, justifyContent: 'center' }}>
                    {['⚽️ Football', '🚩 Red Flags', '☕ First Date', '💔 Breakups', '🏝 Travel', '🤔 Am I Overreacting?'].map((tag) => (
                      <Pressable
                        key={tag}
                        onPress={() => handleSelectSuggestion(tag)}
                        style={{
                          paddingHorizontal: 10,
                          paddingVertical: 5,
                          backgroundColor: '#ECE6C2',
                          borderRadius: 4,
                          borderWidth: 1,
                          borderColor: '#000000',
                        }}>
                        <Text style={{ fontSize: 11, fontWeight: '700', color: '#020202' }}>{tag}</Text>
                      </Pressable>
                    ))}
                  </View>
                </View>
              </View>
            )
          }
          renderItem={({ item }) => {
            const isSelfAuthor = Boolean(
              (item.authorId && item.authorId.toLowerCase() === me.data?.user_id?.toLowerCase()) ||
              (item.authorHandle && me.data?.handle && item.authorHandle.toLowerCase() === me.data.handle.toLowerCase())
            );
            return (
              <SearchPostCard
                item={item}
                isSelfAuthor={isSelfAuthor}
                selectedTag={selectedTag}
                onSelectTag={setSelectedTag}
                onPress={() => router.push(`/(app)/post/${item.id}`)}
                onLike={() => like.mutate(item.id)}
                onSave={() => save.mutate(item.id)}
              />
            );
          }}
        />
      ) : (
        <FlatList
          data={advisorList}
          keyExtractor={(item) => item.id}
          keyboardShouldPersistTaps="handled"
          keyboardDismissMode="on-drag"
          contentContainerStyle={{ paddingHorizontal: 16, paddingBottom: insets.bottom + 20 }}
          showsVerticalScrollIndicator={false}
          refreshing={advisors.isRefetching}
          onRefresh={() => advisors.refetch()}
          ListEmptyComponent={
            advisors.isLoading ? (
              <LoadingState />
            ) : advisors.isError ? (
              <ErrorState error={advisors.error} onRetry={() => advisors.refetch()} />
            ) : (
              <View style={{ alignItems: 'center' }}>
                <EmptyState
                  emoji="👥"
                  title="No advisors found"
                  body={
                    advisorSearch
                      ? `No advisors matching "${advisorSearch}". Try searching by city (e.g. Mumbai, Bengaluru) or another interest.`
                      : 'Try searching for an advisor by handle, specialty, or city.'
                  }
                  actionLabel={advisorSearch ? 'Clear Search' : undefined}
                  onAction={handleClear}
                />
                <View style={{ width: '100%', marginTop: 8 }}>
                  <Text
                    style={{
                      fontSize: 12,
                      fontWeight: '800',
                      color: '#020202',
                      marginBottom: 8,
                      textAlign: 'center',
                    }}>
                    Try searching for
                  </Text>
                  <View style={{ flexDirection: 'row', flexWrap: 'wrap', gap: 6, justifyContent: 'center' }}>
                    {['Bengaluru', 'Mumbai', 'Football', 'General Dating', 'Travel'].map((s) => (
                      <Pressable
                        key={s}
                        onPress={() => handleSelectSuggestion(s)}
                        style={{
                          paddingHorizontal: 10,
                          paddingVertical: 5,
                          backgroundColor: '#ECE6C2',
                          borderRadius: 4,
                          borderWidth: 1,
                          borderColor: '#000000',
                        }}>
                        <Text style={{ fontSize: 11, fontWeight: '700', color: '#020202' }}>{s}</Text>
                      </Pressable>
                    ))}
                  </View>
                </View>
              </View>
            )
          }
          renderItem={({ item }) => {
            const isSelfAdvisor = Boolean(
              (item.id && item.id.toLowerCase() === me.data?.user_id?.toLowerCase()) ||
              (item.handle && me.data?.handle && item.handle.toLowerCase() === me.data.handle.toLowerCase())
            );
            return (
              <SearchAdvisorCard
                item={item}
                isSelfAdvisor={isSelfAdvisor}
                onFollow={() => follow.mutate(item.id)}
              />
            );
          }}
        />
      )}
    </View>
  );
}

function SearchPostCard({
  item,
  isSelfAuthor,
  selectedTag,
  onSelectTag,
  onPress,
  onLike,
  onSave,
}: {
  item: FeedPost;
  isSelfAuthor: boolean;
  selectedTag: string | null;
  onSelectTag: (cat: string) => void;
  onPress: () => void;
  onLike: () => void;
  onSave: () => void;
}) {
  const displayHandle = item.authorHandle || (item.author ? item.author.toLowerCase().replace(/\s+/g, '') : 'advisor');

  const [isLiked, setIsLiked] = useState<boolean>(Boolean(item.likedByMe));
  const [localLikeCount, setLocalLikeCount] = useState<number>(item.likeCount ?? 0);
  const displayedLiked = useRef<boolean>(Boolean(item.likedByMe));

  useEffect(() => {
    if (displayedLiked.current !== Boolean(item.likedByMe)) {
      displayedLiked.current = Boolean(item.likedByMe);
      setIsLiked(Boolean(item.likedByMe));
      setLocalLikeCount(item.likeCount ?? 0);
    }
  }, [item.likedByMe, item.likeCount]);

  const [isSaved, setIsSaved] = useState<boolean>(Boolean(item.savedByMe));
  const displayedSaved = useRef<boolean>(Boolean(item.savedByMe));

  useEffect(() => {
    if (displayedSaved.current !== Boolean(item.savedByMe)) {
      displayedSaved.current = Boolean(item.savedByMe);
      setIsSaved(Boolean(item.savedByMe));
    }
  }, [item.savedByMe]);

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

  return (
    <BrutalCard bg="#FFFFFF" shadowOffset={{ x: -1, y: 3 }}>
      {/* Category & Author */}
      <View
        style={{
          flexDirection: 'row',
          alignItems: 'center',
          justifyContent: 'space-between',
          marginBottom: 6,
        }}>
        <Pressable
          unstable_pressDelay={0}
          onPress={() => onSelectTag(item.category)}
          style={{
            backgroundColor: selectedTag === item.category ? '#73BDA8' : '#ECE6C2',
            paddingHorizontal: 8,
            paddingVertical: 2,
            borderRadius: 4,
            borderWidth: 1,
            borderColor: '#000000',
          }}>
          <Text style={{ fontSize: 10, fontWeight: '700', color: '#020202' }}>
            {item.category}
          </Text>
        </Pressable>
        <Pressable
          unstable_pressDelay={0}
          onPress={() => (isSelfAuthor ? router.push('/(app)/me') : router.push(`/(app)/profile/${item.authorId}`))}
          style={{ flexDirection: 'row', alignItems: 'center', gap: 6 }}>
          <BrutalistAvatar
            seed={displayHandle}
            name={item.author}
            imageUrl={item.authorPhotoUrl}
            size={24}
            shape="rounded"
          />
          <Text style={{ fontSize: 12, fontWeight: '700', color: '#020202' }}>
            @{displayHandle}
          </Text>
        </Pressable>
      </View>

      {/* Title & Preview */}
      <Pressable onPress={onPress}>
        <Text
          style={{
            fontSize: 15,
            fontWeight: '900',
            color: '#020202',
            lineHeight: 20,
            marginBottom: 4,
          }}>
          {item.title}
        </Text>
        <Text
          numberOfLines={2}
          style={{ fontSize: 12, color: '#414141', lineHeight: 17, marginBottom: 8 }}>
          {item.question}
        </Text>
      </Pressable>

      {/* Action Bar */}
      <View
        style={{
          flexDirection: 'row',
          alignItems: 'center',
          justifyContent: 'space-between',
          borderTopWidth: 1,
          borderTopColor: '#DFDFE8',
          paddingTop: 8,
        }}>
        <View style={{ flexDirection: 'row', alignItems: 'center', gap: 12 }}>
          <Pressable
            unstable_pressDelay={0}
            hitSlop={{ top: 8, bottom: 8, left: 8, right: 8 }}
            onPress={handleLikePress}
            style={{ flexDirection: 'row', alignItems: 'center', gap: 3 }}>
            <Text style={{ fontSize: 14 }}>{isLiked ? '❤️' : '🤍'}</Text>
            <Text style={{ fontSize: 11, fontWeight: '700', color: '#020202' }}>
              {localLikeCount}
            </Text>
          </Pressable>
          <Pressable
            unstable_pressDelay={0}
            onPress={onPress}
            style={{ flexDirection: 'row', alignItems: 'center', gap: 3 }}>
            <Text style={{ fontSize: 14 }}>💬</Text>
            <Text style={{ fontSize: 11, fontWeight: '700', color: '#020202' }}>
              {item.commentCount} replies
            </Text>
          </Pressable>
          <Pressable
            unstable_pressDelay={0}
            hitSlop={{ top: 8, bottom: 8, left: 8, right: 8 }}
            onPress={handleSavePress}
            style={{ flexDirection: 'row', alignItems: 'center', gap: 3 }}>
            <Text style={{ fontSize: 13 }}>{isSaved ? '🔖' : '📑'}</Text>
          </Pressable>
        </View>

        <Pressable
          unstable_pressDelay={0}
          onPress={onPress}
          style={{
            paddingHorizontal: 10,
            paddingVertical: 3,
            backgroundColor: '#73BDA8',
            borderWidth: 1.5,
            borderColor: '#000000',
            borderRadius: 4,
          }}>
          <Text style={{ fontSize: 11, fontWeight: '800', color: '#020202' }}>Read Advice →</Text>
        </Pressable>
      </View>
    </BrutalCard>
  );
}

function SearchAdvisorCard({
  item,
  isSelfAdvisor,
  onFollow,
}: {
  item: AdvisorPerson;
  isSelfAdvisor: boolean;
  onFollow: () => void;
}) {
  const displayHandle = item.handle || (item.name ? item.name.toLowerCase().replace(/\s+/g, '') : 'advisor');
  const quote = item.recentAdviceQuote?.trim() || item.bio?.trim() || `Advisor specializing in ${item.specialty || 'General Dating'}`;

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
    <BrutalCard bg="#FFFFFF" shadowOffset={{ x: -1, y: 3 }}>
      <View
        style={{
          flexDirection: 'row',
          alignItems: 'center',
          justifyContent: 'space-between',
        }}>
        {/* Advisor Avatar & Details */}
        <Pressable
          unstable_pressDelay={0}
          onPress={() => (isSelfAdvisor ? router.push('/(app)/me') : router.push(`/(app)/profile/${item.id}`))}
          style={{ flexDirection: 'row', alignItems: 'center', gap: 12, flex: 1 }}>
          <BrutalistAvatar
            seed={displayHandle}
            name={item.name}
            imageUrl={item.photoUrl}
            size={48}
            shape="rounded"
            badge={item.rank.includes('Top') ? 'advisor' : 'none'}
          />
          <View style={{ flex: 1, paddingRight: 8 }}>
            <View style={{ flexDirection: 'row', alignItems: 'center', gap: 6 }}>
              <Text
                style={{
                  fontSize: 14,
                  fontWeight: '800',
                  color: '#020202',
                  fontFamily: 'HankenGrotesk-Bold',
                }}>
                {item.name}
              </Text>
            </View>
            <Text style={{ fontSize: 11, color: '#6E6E6E' }}>
              @{displayHandle}{item.city ? ` · ${item.city}` : ''}
            </Text>
            <Text
              numberOfLines={1}
              style={{ fontSize: 11, color: '#020202', marginTop: 2, fontStyle: 'italic' }}>
              "{quote}"
            </Text>
          </View>
        </Pressable>

        {/* Follow Button / Self Badge */}
        {isSelfAdvisor ? (
          <View
            style={{
              paddingHorizontal: 10,
              paddingVertical: 5,
              borderRadius: 5,
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
              paddingHorizontal: 12,
              paddingVertical: 6,
              borderRadius: 5,
              borderWidth: 1.5,
              borderColor: '#000000',
              backgroundColor: isFollowing ? '#ECE6C2' : '#0E9BEA',
              shadowColor: '#000000',
              shadowOffset: { width: 0, height: 1.5 },
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

      {/* Stats Bar */}
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
        <View style={{ flexDirection: 'row', gap: 14 }}>
          <Text style={{ fontSize: 11, fontWeight: '700', color: '#020202' }}>
            {localFollowersCount} <Text style={{ color: '#6E6E6E', fontWeight: '500' }}>Followers</Text>
          </Text>
          <Text style={{ fontSize: 11, fontWeight: '700', color: '#020202' }}>
            {item.adviceGivenCount} <Text style={{ color: '#6E6E6E', fontWeight: '500' }}>Advice Given</Text>
          </Text>
        </View>

        <View
          style={{
            backgroundColor: '#ECE6C2',
            paddingHorizontal: 6,
            paddingVertical: 2,
            borderRadius: 4,
            borderWidth: 1,
            borderColor: '#000000',
          }}>
          <Text style={{ fontSize: 10, fontWeight: '800', color: '#73BDA8' }}>
            {item.helpfulPercent}% Helpful
          </Text>
        </View>
      </View>
    </BrutalCard>
  );
}
