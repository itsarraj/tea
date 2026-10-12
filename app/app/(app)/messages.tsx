import React, { useState } from 'react';
import {
  FlatList,
  Pressable,
  ScrollView,
  StatusBar,
  Text,
  TextInput,
  View,
} from 'react-native';
import { router } from 'expo-router';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import Svg, { Circle, Path, Rect } from 'react-native-svg';

import { BrutalistAvatar } from '@/components/tea/BrutalistAvatar';
import { EmptyState, ErrorState, LoadingState, QuickNotesRail, type NoteItem } from '@/components/tea/ui';
import { QuickNoteModal } from '@/components/tea/QuickNoteModal';
import { brand } from '@/constants/brand';
import { useConversations, useProfile, useStories } from '@/hooks/useDating';
import type { ConversationItem } from '@/lib/fixtures';

export default function MessagesScreen() {
  const insets = useSafeAreaInsets();
  const [search, setSearch] = useState('');
  const [activeTab, setActiveTab] = useState<'messages' | 'requests'>('messages');
  const [noteModal, setNoteModal] = useState<{
    visible: boolean;
    mode: 'create' | 'view';
    note?: NoteItem;
  }>({ visible: false, mode: 'create' });

  const profile = useProfile();
  const conversations = useConversations();
  const stories = useStories();

  const allRows = conversations.data ?? [];
  const rows = allRows.filter((c) => {
    if (activeTab === 'requests') {
      if (c.requestStatus !== 'request') return false;
    } else {
      if (c.requestStatus === 'request') return false;
    }
    if (!search.trim()) return true;
    const q = search.toLowerCase().trim();
    return c.name.toLowerCase().includes(q) || c.preview.toLowerCase().includes(q);
  });

  const requestCount = allRows.filter((c) => c.requestStatus === 'request').length;

  return (
    <View style={{ flex: 1, backgroundColor: brand.canvas, paddingTop: insets.top }}>
      <StatusBar barStyle="dark-content" />

      {/* Top Header Bar from HTML */}
      <View
        style={{
          flexDirection: 'row',
          alignItems: 'center',
          justifyContent: 'space-between',
          paddingHorizontal: 20,
          paddingVertical: 12,
          backgroundColor: '#ECE6C2',
        }}>
        <Text
          style={{
            fontSize: 18,
            fontWeight: '900',
            color: '#020202',
            fontFamily: 'HankenGrotesk-Black',
          }}>
          {profile.data?.handle ? `@${profile.data.handle}` : profile.data?.display_name || 'Messages'}
        </Text>

        <View style={{ flexDirection: 'row', alignItems: 'center', gap: 16 }}>
          {/* New message / plus icon */}
          <Pressable
            onPress={() => router.push('/(app)/search')}
            style={{
              width: 32,
              height: 32,
              borderRadius: 6,
              borderWidth: 2,
              borderColor: '#000000',
              backgroundColor: '#ECE6C2',
              alignItems: 'center',
              justifyContent: 'center',
              shadowColor: '#000000',
              shadowOffset: { width: 0, height: 1.5 },
              shadowOpacity: 1,
              shadowRadius: 0,
            }}>
            <Text style={{ fontSize: 18, fontWeight: '900', color: '#020202', lineHeight: 20 }}>+</Text>
          </Pressable>
        </View>
      </View>

      {/* Search Input Box (Matching HTML spec) */}
      <View style={{ paddingHorizontal: 20, paddingBottom: 10, backgroundColor: '#ECE6C2' }}>
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
              height: 36,
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
              value={search}
              onChangeText={setSearch}
              placeholder="Search"
              placeholderTextColor="#6E6E6E"
              style={{
                flex: 1,
                fontSize: 12,
                color: '#020202',
                fontFamily: 'HankenGrotesk-Medium',
                paddingVertical: 0,
              }}
            />
          </View>
        </View>
      </View>

      {/* Quick Notes Rail (From HTML spec) */}
      <View style={{ borderBottomWidth: 1.5, borderBottomColor: '#000000', backgroundColor: '#ECE6C2' }}>
        <QuickNotesRail
          notes={stories.data ?? []}
          currentUserPhotoUrl={profile.data?.photos?.[0]?.url}
          onAddNote={() => setNoteModal({ visible: true, mode: 'create' })}
          onPressNote={(n) => setNoteModal({ visible: true, mode: 'view', note: n })}
        />
      </View>

      {/* Messages Header & Requests Link (From HTML spec) */}
      <View
        style={{
          flexDirection: 'row',
          alignItems: 'center',
          justifyContent: 'space-between',
          paddingHorizontal: 20,
          paddingVertical: 12,
          backgroundColor: '#ECE6C2',
          borderBottomWidth: 1,
          borderBottomColor: '#DFDFE8',
        }}>
        <Pressable onPress={() => setActiveTab('messages')}>
          <Text
            style={{
              fontSize: 16,
              fontWeight: '800',
              color: '#020202',
              fontFamily: 'HankenGrotesk-Bold',
              borderBottomWidth: activeTab === 'messages' ? 2 : 0,
              borderBottomColor: '#000000',
              paddingBottom: 2,
            }}>
            Messages
          </Text>
        </Pressable>

        <Pressable onPress={() => setActiveTab('requests')}>
          <Text
            style={{
              fontSize: 13,
              fontWeight: '700',
              color: activeTab === 'requests' ? '#020202' : '#0EA8FF',
              fontFamily: 'HankenGrotesk-Bold',
              borderBottomWidth: activeTab === 'requests' ? 2 : 0,
              borderBottomColor: '#0EA8FF',
              paddingBottom: 2,
            }}>
            Requests ({requestCount})
          </Text>
        </Pressable>
      </View>

      {/* Conversation Thread List (From HTML spec) */}
      <FlatList
        data={rows}
        keyExtractor={(item) => item.id}
        contentContainerStyle={{ paddingHorizontal: 16, paddingBottom: insets.bottom + 20 }}
        showsVerticalScrollIndicator={false}
        refreshing={conversations.isRefetching}
        onRefresh={() => conversations.refetch()}
        ListEmptyComponent={
          conversations.isLoading ? (
            <LoadingState message="Loading advice chats…" />
          ) : conversations.isError ? (
            <ErrorState error={conversations.error} onRetry={() => conversations.refetch()} />
          ) : (
            <EmptyState
              emoji="💬"
              title="No chats yet"
              body="Reach out to an advisor or wait for someone to ask your advice."
              actionLabel="Discover Advisors"
              onAction={() => router.push('/(app)/advisors')}
            />
          )
        }
        renderItem={({ item }) => (
          <Pressable
            onPress={() => router.push(`/(app)/chat/${item.id}`)}
            style={({ pressed }) => ({
              borderBottomWidth: 1,
              borderBottomColor: 'rgba(0,0,0,0.08)',
              backgroundColor: pressed ? 'rgba(0,0,0,0.03)' : 'transparent',
            })}>
            <View
              style={{
                flexDirection: 'row',
                alignItems: 'center',
                justifyContent: 'space-between',
                paddingVertical: 14,
                paddingHorizontal: 8,
              }}>
              <View style={{ flexDirection: 'row', alignItems: 'center', gap: 14, flex: 1, marginRight: 12 }}>
                {/* Permanent Avatar */}
                <BrutalistAvatar
                  seed={item.handle || item.name}
                  name={item.name}
                  imageUrl={item.photoUrl}
                  size={48}
                  shape="rounded"
                />

                <View style={{ flex: 1 }}>
                  <Text
                    style={{
                      fontSize: 14,
                      fontWeight: item.unread ? '900' : '700',
                      color: '#020202',
                      fontFamily: item.unread ? 'HankenGrotesk-Bold' : 'HankenGrotesk-SemiBold',
                    }}>
                    {item.name}
                  </Text>
                  <Text
                    numberOfLines={1}
                    style={{
                      fontSize: 12,
                      color: item.unread ? '#020202' : '#6E6E6E',
                      fontWeight: item.unread ? '600' : '400',
                      marginTop: 2,
                    }}>
                    {item.preview}
                  </Text>
                </View>
              </View>

              <View style={{ alignItems: 'flex-end', justifyContent: 'center', gap: 6 }}>
                <Text
                  style={{
                    fontSize: 11,
                    color: item.unread ? '#0EA8FF' : '#888888',
                    fontWeight: item.unread ? '700' : '500',
                  }}>
                  {item.time}
                </Text>

                <View style={{ flexDirection: 'row', alignItems: 'center', gap: 8 }}>
                  {/* Blue Unread Dot */}
                  {item.unread && (
                    <View
                      style={{
                        width: 8,
                        height: 8,
                        borderRadius: 4,
                        backgroundColor: '#0EA8FF',
                      }}
                    />
                  )}

                  {/* Chat action icon */}
                  <View
                    style={{
                      width: 28,
                      height: 28,
                      borderRadius: 6,
                      backgroundColor: '#ECE6C2',
                      borderWidth: 1.5,
                      borderColor: '#000000',
                      alignItems: 'center',
                      justifyContent: 'center',
                    }}>
                    <Svg width={14} height={14} viewBox="0 0 24 24" fill="none">
                      <Path
                        d="M21 11.5a8.38 8.38 0 0 1-.9 3.8 8.5 8.5 0 0 1-7.6 4.7 8.38 8.38 0 0 1-3.8-.9L3 21l1.9-5.7a8.38 8.38 0 0 1-.9-3.8 8.5 8.5 0 0 1 4.7-7.6 8.38 8.38 0 0 1 3.8-.9h.5a8.48 8.48 0 0 1 8 8v.5z"
                        stroke="#000000"
                        strokeWidth={2}
                        fill="#73BDA8"
                      />
                    </Svg>
                  </View>
                </View>
              </View>
            </View>
          </Pressable>
        )}
      />

      <QuickNoteModal
        visible={noteModal.visible}
        mode={noteModal.mode}
        note={noteModal.note}
        currentUserPhotoUrl={profile.data?.photos?.[0]?.url}
        onClose={() => setNoteModal((prev) => ({ ...prev, visible: false }))}
      />
    </View>
  );
}
