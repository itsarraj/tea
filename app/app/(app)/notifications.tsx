import React, { useEffect, useRef, useState } from 'react';
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
import { EmptyState, LoadingState } from '@/components/tea/ui';
import {
  useConfirmNotification,
  useDeleteNotification,
  useNotifications,
  useProfile,
  useToggleFollow,
} from '@/hooks/useDating';
import type { NotificationItem } from '@/lib/fixtures';

export default function NotificationsScreen() {
  const insets = useSafeAreaInsets();
  const me = useProfile();
  const notifications = useNotifications();
  const confirmMut = useConfirmNotification();
  const deleteMut = useDeleteNotification();
  const toggleFollow = useToggleFollow();

  const [filterRequestsOnly, setFilterRequestsOnly] = useState(false);
  const [followedSet, setFollowedSet] = useState<Record<string, boolean>>({});

  const items = notifications.data ?? [];
  const followRequests = items.filter((n) => n.type === 'follow_request' && !n.confirmed);

  const displayedItems = filterRequestsOnly
    ? items.filter((n) => n.type === 'follow_request')
    : items;

  // Group items by Section (Today vs Earlier)
  const isToday = (n: NotificationItem) => {
    if (n.section) return n.section === 'Today';
    const t = n.time?.toLowerCase() || '';
    if (t.includes('d') || t.includes('w') || t.includes('mo') || t.includes('y')) return false;
    return true;
  };

  const todayItems = displayedItems.filter(isToday);
  const earlierItems = displayedItems.filter((n) => !isToday(n));

  const handleFollow = (handle: string, actorId?: string) => {
    setFollowedSet((prev) => ({ ...prev, [handle]: !prev[handle] }));
    toggleFollow.mutate(actorId || handle);
  };

  return (
    <View className="flex-1 bg-[#ece6c2]" style={{ paddingTop: insets.top }}>
      <StatusBar barStyle="dark-content" backgroundColor="#ece6c2" />

      {/* Screen Header */}
      <View className="flex-row items-center justify-between px-5 pt-3 pb-3 border-b-2 border-black bg-[#ece6c2]">
        <View className="flex-row items-center gap-3">
          <Pressable
            onPress={() => (router.canGoBack() ? router.back() : router.replace('/(app)'))}
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
          <Text className="text-xl font-bold text-black">Notifications</Text>
        </View>

        <View className="bg-black px-2.5 py-1 rounded-[2px]">
          <Text className="text-[10px] font-black uppercase text-white tracking-widest">
            {items.length} Alerts
          </Text>
        </View>
      </View>

      <ScrollView
        showsVerticalScrollIndicator={false}
        contentContainerStyle={{ paddingBottom: insets.bottom + 40 }}>
        {/* Follow Requests Banner (Direct match to inspiration snippet) */}
        <Pressable
          onPress={() => setFilterRequestsOnly(!filterRequestsOnly)}
          className={`mx-5 mt-4 p-3 rounded-[3px] border-2 border-black flex-row items-center justify-between active:translate-y-0.5 ${
            filterRequestsOnly ? 'bg-tea-mint' : 'bg-white'
          }`}
          style={{
            shadowColor: '#000',
            shadowOffset: { width: -2, height: 3 },
            shadowOpacity: 1,
            shadowRadius: 0,
            elevation: 3,
          }}>
          <View className="flex-row items-center gap-3">
            {/* Red Circle Badge from inspiration snippet */}
            <View className="w-8 h-8 rounded-full bg-[#d72a2a] border border-black items-center justify-center">
              <Text className="text-[10px] font-bold text-white">
                {followRequests.length > 99 ? '99+' : followRequests.length}
              </Text>
            </View>

            <View>
              <Text className="text-xs font-bold text-black">Follow Requests</Text>
              <Text className="text-[11px] text-[#444] mt-0.5">Approve or ignore requests</Text>
            </View>
          </View>

          <View className="flex-row items-center gap-1.5">
            {filterRequestsOnly ? (
              <View className="bg-black px-2 py-0.5 rounded-[2px]">
                <Text className="text-[10px] font-black uppercase text-white">Viewing</Text>
              </View>
            ) : null}
            <Feather
              name={filterRequestsOnly ? 'check-circle' : 'chevron-right'}
              size={18}
              color="#000"
            />
          </View>
        </Pressable>

        {notifications.isLoading ? (
          <LoadingState message="Fetching notifications..." />
        ) : displayedItems.length === 0 ? (
          <View className="py-16 px-6 items-center">
            <EmptyState
              icon="bell"
              title="All caught up!"
              description="No notifications right now. Spilling new dating advice will get your community talking."
            />
          </View>
        ) : (
          <View className="mt-2">
            {/* Section: Today */}
            {todayItems.length > 0 ? (
              <View>
                <Text className="px-5 pt-4 pb-2 text-sm font-bold text-black">Today</Text>
                <View className="px-5 gap-3">
                  {todayItems.map((item) => (
                    <InspirationNotificationRow
                      key={item.id}
                      item={item}
                      isFollowed={Boolean(followedSet[item.actorHandle] ?? item.followedBack)}
                      onFollow={() => handleFollow(item.actorHandle, item.actorId)}
                      onConfirm={() => confirmMut.mutate(item.id)}
                      onDelete={() => deleteMut.mutate(item.id)}
                      currentUserId={me.data?.user_id}
                      currentUserHandle={me.data?.handle}
                    />
                  ))}
                </View>
              </View>
            ) : null}

            {/* Section: Earlier */}
            {earlierItems.length > 0 ? (
              <View className="mt-4">
                <Text className="px-5 pt-4 pb-2 text-sm font-bold text-black">Earlier</Text>
                <View className="px-5 gap-3">
                  {earlierItems.map((item) => (
                    <InspirationNotificationRow
                      key={item.id}
                      item={item}
                      isFollowed={Boolean(followedSet[item.actorHandle] ?? item.followedBack)}
                      onFollow={() => handleFollow(item.actorHandle, item.actorId)}
                      onConfirm={() => confirmMut.mutate(item.id)}
                      onDelete={() => deleteMut.mutate(item.id)}
                      currentUserId={me.data?.user_id}
                      currentUserHandle={me.data?.handle}
                    />
                  ))}
                </View>
              </View>
            ) : null}
          </View>
        )}
      </ScrollView>
    </View>
  );
}

function InspirationNotificationRow({
  item,
  isFollowed,
  onFollow,
  onConfirm,
  onDelete,
  currentUserId,
  currentUserHandle,
}: {
  item: NotificationItem;
  isFollowed: boolean;
  onFollow: () => void;
  onConfirm: () => void;
  onDelete: () => void;
  currentUserId?: string;
  currentUserHandle?: string;
}) {
  const isRequest = item.type === 'follow_request';
  const isLike = item.type === 'like';
  const isFollow = item.type === 'follow';

  // Pillar 39: Local-first state for 0ms instantaneous UI feedback
  const [localFollowed, setLocalFollowed] = useState(isFollowed);
  const [localConfirmed, setLocalConfirmed] = useState(Boolean(item.confirmed));
  const [localDeleted, setLocalDeleted] = useState(false);
  const displayedFollowed = useRef(isFollowed);

  useEffect(() => {
    if (displayedFollowed.current !== isFollowed) {
      displayedFollowed.current = isFollowed;
      setLocalFollowed(isFollowed);
    }
  }, [isFollowed]);

  useEffect(() => {
    setLocalConfirmed(Boolean(item.confirmed));
  }, [item.confirmed]);

  if (localDeleted) return null;

  const handleFollowPress = () => {
    const next = !displayedFollowed.current;
    displayedFollowed.current = next;
    setLocalFollowed(next);
    onFollow();
  };

  const handleConfirmPress = () => {
    setLocalConfirmed(true);
    onConfirm();
  };

  const handleDeletePress = () => {
    setLocalDeleted(true);
    onDelete();
  };

  const isSelf = Boolean(
    (item.actorId && item.actorId === currentUserId) ||
    (item.actorHandle && item.actorHandle === currentUserHandle)
  );

  const navigateToActor = () => {
    if (isSelf) {
      router.push('/(app)/me');
    } else if (item.actorId || item.actorHandle) {
      router.push(`/(app)/profile/${item.actorId || item.actorHandle}` as any);
    }
  };

  return (
    <View
      className="p-3 bg-white border-2 border-black rounded-[3px] flex-row items-center justify-between gap-3"
      style={{
        shadowColor: '#000',
        shadowOffset: { width: -1.5, height: 2.5 },
        shadowOpacity: 1,
        shadowRadius: 0,
        elevation: 2,
      }}>
      {/* Actor Avatar */}
      <Pressable
        onPress={navigateToActor}
        className="active:opacity-80">
        <BrutalistAvatar
          name={item.actorName}
          handle={item.actorHandle}
          imageUrl={item.actorPhotoUrl}
          size={40}
          shape="square"
        />
      </Pressable>

      {/* Narrative Text */}
      <Pressable
        className="flex-1"
        onPress={() => {
          if (item.postId) {
            router.push(`/(app)/post/${item.postId}` as any);
          } else {
            navigateToActor();
          }
        }}>
        <Text className="text-xs text-black leading-snug">
          <Text className="font-bold text-black">{item.actorHandle} </Text>
          <Text className="font-medium text-[#222]">{item.text}</Text>
          <Text className="text-[11px] font-normal text-[#555]"> · {item.time}</Text>
        </Text>
      </Pressable>

      {/* Right Action Elements matching inspiration structure */}
      {isRequest ? (
        (localConfirmed || item.confirmed) ? (
          <View className="bg-tea-mint px-2.5 py-1 border border-black rounded-[3px]">
            <Text className="text-[10px] font-black uppercase text-black">Approved</Text>
          </View>
        ) : (
          <View className="flex-row items-center gap-2">
            {/* Confirm button: bg-[#0e9bea] border-[1.5px] border-black with shadow */}
            <Pressable
              unstable_pressDelay={0}
              onPress={handleConfirmPress}
              className="w-[66px] h-[28px] rounded-[3px] bg-[#0e9bea] border-[1.5px] border-black items-center justify-center active:translate-y-0.5"
              style={{
                shadowColor: '#000',
                shadowOffset: { width: 0, height: 2 },
                shadowOpacity: 1,
                shadowRadius: 0,
                elevation: 2,
              }}>
              <Text className="text-xs font-medium text-white">Confirm</Text>
            </Pressable>

            {/* Delete button: bg-[#ece6c2] border-[1.5px] border-black with shadow */}
            <Pressable
              unstable_pressDelay={0}
              onPress={handleDeletePress}
              className="w-[58px] h-[28px] rounded-[3px] bg-[#ece6c2] border-[1.5px] border-black items-center justify-center active:translate-y-0.5"
              style={{
                shadowColor: '#000',
                shadowOffset: { width: 0, height: 2 },
                shadowOpacity: 1,
                shadowRadius: 0,
                elevation: 2,
              }}>
              <Text className="text-xs font-medium text-black">Delete</Text>
            </Pressable>
          </View>
        )
      ) : isFollow ? (
        isSelf ? (
          <View className="px-2 py-1 bg-tea-mint border border-black rounded-[3px]">
            <Text className="text-[10px] font-black uppercase text-black">YOU</Text>
          </View>
        ) : (
          /* Follow button: bg-[#0e9bea] border-[1.5px] border-black with shadow */
          <Pressable
            unstable_pressDelay={0}
            onPress={handleFollowPress}
            className={`w-[68px] h-[28px] rounded-[3px] border-[1.5px] border-black items-center justify-center active:translate-y-0.5 ${
              localFollowed ? 'bg-[#ece6c2]' : 'bg-[#0e9bea]'
            }`}
            style={{
              shadowColor: '#000',
              shadowOffset: { width: 0, height: 2 },
              shadowOpacity: 1,
              shadowRadius: 0,
              elevation: 2,
            }}>
            <Text
              className={`text-xs font-medium ${
                localFollowed ? 'text-black' : 'text-white'
              }`}>
              {localFollowed ? 'Following' : 'Follow'}
            </Text>
          </Pressable>
        )
      ) : isLike ? (
        /* Strictly Text-Only Post Preview Thumbnail (replacing photo thumbnail in snippet) */
        <Pressable
          onPress={() => {
            if (item.postId) {
              router.push(`/(app)/post/${item.postId}` as any);
            } else {
              router.push('/(app)');
            }
          }}
          className="w-12 h-11 bg-[#dfdfe8] border-[1.5px] border-black rounded-[3px] items-center justify-center p-1 active:translate-y-0.5"
          style={{
            shadowColor: '#000',
            shadowOffset: { width: 0, height: 1.5 },
            shadowOpacity: 1,
            shadowRadius: 0,
            elevation: 2,
          }}>
          <Text className="text-[10px] font-black text-black">☕</Text>
          <Text
            numberOfLines={1}
            className="text-[8px] font-black uppercase text-black text-center mt-0.5">
            {item.postCategory || 'Post'}
          </Text>
        </Pressable>
      ) : (
        <View className="w-8 h-8 rounded-full bg-[#ece6c2] border border-black items-center justify-center">
          <Ionicons name="chatbubble-ellipses" size={14} color="#0ea8ff" />
        </View>
      )}
    </View>
  );
}
