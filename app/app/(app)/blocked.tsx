import React from 'react';
import { Pressable, ScrollView, StatusBar, Text, View } from 'react-native';
import { router } from 'expo-router';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { Feather } from '@expo/vector-icons';

import { BrutalistAvatar } from '@/components/tea/BrutalistAvatar';
import { EmptyState, LoadingState } from '@/components/tea/ui';
import { useBlockedUsers, useUnblockUser } from '@/hooks/useDating';

export default function BlockedScreen() {
  const insets = useSafeAreaInsets();
  const blocked = useBlockedUsers();
  const unblock = useUnblockUser();
  const back = () => (router.canGoBack() ? router.back() : router.replace('/(app)/settings'));

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
          <Text className="text-xl font-black text-black">Blocked Users</Text>
        </View>

        <View className="bg-black px-2.5 py-1 rounded-[2px]">
          <Text className="text-[10px] font-black uppercase text-white tracking-widest">
            {blocked.data?.length ?? 0} Blocked
          </Text>
        </View>
      </View>

      {blocked.isLoading ? (
        <LoadingState message="Loading blocked users..." />
      ) : !blocked.data?.length ? (
        <View className="flex-1 items-center justify-center p-6">
          <EmptyState
            icon="shield"
            title="No blocked users"
            description="People you block won’t see your dilemmas, advice, or be able to message you."
          />
        </View>
      ) : (
        <ScrollView
          contentContainerStyle={{ padding: 16, paddingBottom: insets.bottom + 40 }}
          showsVerticalScrollIndicator={false}>
          {blocked.data.map((p) => (
            <View
              key={p.id}
              className="mb-3 p-4 bg-white border-2 border-black rounded-[3px] flex-row items-center justify-between gap-3"
              style={{
                shadowColor: '#000',
                shadowOffset: { width: -2, height: 3 },
                shadowOpacity: 1,
                shadowRadius: 0,
                elevation: 3,
              }}>
              <View className="flex-row items-center gap-3 flex-1">
                <BrutalistAvatar
                  name={p.name}
                  handle={p.handle}
                  imageUrl={p.photoUrl || p.photos?.[0]?.url}
                  size={42}
                  shape="square"
                />
                <View className="flex-1">
                  <Text className="text-sm font-black text-black">{p.name}</Text>
                  {p.handle ? (
                    <Text className="text-xs font-semibold text-[#666]">@{p.handle}</Text>
                  ) : null}
                </View>
              </View>

              <Pressable
                onPress={() => unblock.mutate(p.id)}
                disabled={unblock.isPending}
                className="px-3.5 py-1.5 bg-[#73bda8] border-2 border-black rounded-[2px] active:translate-y-0.5"
                style={{
                  shadowColor: '#000',
                  shadowOffset: { width: -1.5, height: 1.5 },
                  shadowOpacity: 1,
                  shadowRadius: 0,
                  elevation: 2,
                }}>
                <Text className="text-xs font-black uppercase text-black">Unblock</Text>
              </Pressable>
            </View>
          ))}
        </ScrollView>
      )}
    </View>
  );
}
