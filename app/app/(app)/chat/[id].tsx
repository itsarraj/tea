import React, { useState } from 'react';
import {
  Alert,
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
import { KeyboardAvoidingView } from 'react-native-keyboard-controller';
import Svg, { Path } from 'react-native-svg';
import { Feather } from '@expo/vector-icons';

import { BrutalistAvatar } from '@/components/tea/BrutalistAvatar';
import { BrutalButton } from '@/components/tea/ui';
import { brand } from '@/constants/brand';
import { useChatSocket } from '@/hooks/useChatSocket';
import {
  useAdvisorProfile,
  useBlockUser,
  useConversationMessages,
  useConversations,
  useProfile,
  useReportUser,
  useSendMessage,
} from '@/hooks/useDating';
import { useKeyboard } from '@/hooks/useKeyboard';
import type { ChatMessage } from '@/lib/fixtures';

export default function ChatScreen() {
  const { id } = useLocalSearchParams<{ id: string }>();
  const insets = useSafeAreaInsets();
  const { isKeyboardVisible } = useKeyboard();
  const [text, setText] = useState('');

  const me = useProfile();
  const conversations = useConversations();
  const conversation = (conversations.data ?? []).find((c) => c.id === id || c.peerId === id);
  const activeConversationId = conversation?.id || id;
  const messagesQuery = useConversationMessages(activeConversationId);
  const sendMutation = useSendMessage(activeConversationId);

  const advisorQuery = useAdvisorProfile(!conversation ? id : undefined);

  const peerName = conversation?.name || advisorQuery.data?.name || 'Dating Advisor';
  const peerHandle = conversation?.handle || advisorQuery.data?.handle || peerName;
  const peerId = conversation?.peerId || advisorQuery.data?.id || id;

  const isSelf = Boolean(
    (me.data?.user_id && peerId === me.data.user_id) ||
    (me.data?.handle && peerHandle.toLowerCase() === me.data.handle.toLowerCase()),
  );

  const back = () => (router.canGoBack() ? router.back() : router.replace('/(app)/messages'));

  const { isPeerTyping, sendTyping } = useChatSocket(activeConversationId, peerId);
  const blockUser = useBlockUser();
  const reportUser = useReportUser();

  const handleSafetyAction = () => {
    Alert.alert(
      'Conversation Options',
      `Options for ${peerName}:`,
      [
        {
          text: 'View Advisor Profile',
          onPress: () => peerId && router.push(`/(app)/profile/${peerId}`),
        },
        {
          text: 'Report User',
          style: 'destructive',
          onPress: () => {
            Alert.alert('Report Reason', 'Why are you reporting this user?', [
              { text: 'Harassment / Abusive Messages', onPress: () => sendReport('Harassment') },
              { text: 'Spam / Advertising', onPress: () => sendReport('Spam') },
              { text: 'Inappropriate Content', onPress: () => sendReport('Inappropriate') },
              { text: 'Cancel', style: 'cancel' },
            ]);
          },
        },
        {
          text: `Block ${peerName}`,
          style: 'destructive',
          onPress: () => {
            Alert.alert(
              'Block User?',
              `You will no longer be able to message each other and this conversation will be closed.`,
              [
                { text: 'Cancel', style: 'cancel' },
                {
                  text: 'Block',
                  style: 'destructive',
                  onPress: async () => {
                    try {
                      await blockUser.mutateAsync(peerId);
                      Alert.alert('Blocked', 'User has been blocked.');
                      back();
                    } catch (e) {
                      Alert.alert('Error', e instanceof Error ? e.message : 'Could not block user');
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
    try {
      await reportUser.mutateAsync({
        userId: peerId,
        reason,
        details: `Chat with ${peerName}`,
      });
      Alert.alert('Report Submitted', 'Thank you. Our moderators will review this account.');
    } catch (e) {
      Alert.alert('Error', e instanceof Error ? e.message : 'Could not submit report');
    }
  };

  const messagePages = messagesQuery.data?.pages ?? [];
  const messageList = messagePages.flat();

  const handleSend = () => {
    const trimmed = text.trim();
    if (!trimmed) return;
    setText('');
    sendMutation.mutate(trimmed);
  };

  const sendQuickReaction = (reactionText: string) => {
    sendMutation.mutate(reactionText);
  };

  if (isSelf) {
    return (
      <View
        style={{
          flex: 1,
          backgroundColor: '#ECE6C2',
          alignItems: 'center',
          justifyContent: 'center',
          padding: 24,
          paddingTop: insets.top,
        }}>
        <Text
          style={{
            fontSize: 20,
            fontWeight: '900',
            color: '#000000',
            marginBottom: 8,
            fontFamily: 'HankenGrotesk-Black',
          }}>
          Direct Chat Unavailable
        </Text>
        <Text
          style={{
            fontSize: 13,
            color: '#555555',
            textAlign: 'center',
            marginBottom: 24,
            lineHeight: 18,
          }}>
          You cannot initiate a private advice conversation with your own profile.
        </Text>
        <BrutalButton label="Back to Messages" variant="mint" onPress={back} />
      </View>
    );
  }

  return (
    <View style={{ flex: 1, backgroundColor: '#ECE6C2', paddingTop: insets.top }}>
      <StatusBar barStyle="dark-content" />

      {/* 1. Chat Header Bar (From HTML spec) */}
      <View
        style={{
          flexDirection: 'row',
          alignItems: 'center',
          justifyContent: 'space-between',
          paddingHorizontal: 16,
          paddingVertical: 10,
          backgroundColor: '#ECE6C2',
          borderBottomWidth: 2,
          borderBottomColor: '#000000',
        }}>
        {/* Back Button */}
        <Pressable
          onPress={back}
          style={{
            width: 36,
            height: 36,
            borderRadius: 6,
            backgroundColor: '#ECE6C2',
            borderWidth: 2,
            borderColor: '#000000',
            alignItems: 'center',
            justifyContent: 'center',
            shadowColor: '#000000',
            shadowOffset: { width: -1, height: 2 },
            shadowOpacity: 1,
            shadowRadius: 0,
          }}>
          <Svg width={18} height={18} viewBox="0 0 24 24" fill="none">
            <Path
              d="M15 19l-7-7 7-7"
              stroke="#000000"
              strokeWidth={2.5}
              strokeLinecap="round"
              strokeLinejoin="round"
            />
          </Svg>
        </Pressable>

        {/* Peer Info */}
        <Pressable
          onPress={() => peerId && router.push(`/(app)/profile/${peerId}`)}
          style={{ flexDirection: 'row', alignItems: 'center', gap: 10, flex: 1, marginLeft: 12 }}>
          <BrutalistAvatar
            seed={peerHandle}
            name={peerName}
            imageUrl={conversation?.photoUrl || advisorQuery.data?.photoUrl}
            size={38}
            shape="rounded"
          />
          <View>
            <Text
              style={{
                fontSize: 14,
                fontWeight: '900',
                color: '#020202',
                fontFamily: 'HankenGrotesk-Bold',
              }}>
              {peerName}
            </Text>
            <Text style={{ fontSize: 10, color: '#414141', fontWeight: '500' }}>Active recently · Direct Advice</Text>
          </View>
        </Pressable>

        {/* Right Actions: Badge + Safety Menu */}
        <View style={{ flexDirection: 'row', alignItems: 'center', gap: 6 }}>
          <View
            style={{
              paddingHorizontal: 8,
              paddingVertical: 4,
              backgroundColor: '#73BDA8',
              borderWidth: 1.5,
              borderColor: '#000000',
              borderRadius: 6,
            }}>
            <Text style={{ fontSize: 10, fontWeight: '800', color: '#020202' }}>1-on-1 Tea</Text>
          </View>
          <Pressable
            onPress={handleSafetyAction}
            style={{
              width: 32,
              height: 32,
              borderRadius: 6,
              backgroundColor: '#ECE6C2',
              borderWidth: 1.5,
              borderColor: '#000000',
              alignItems: 'center',
              justifyContent: 'center',
            }}>
            <Feather name="more-vertical" size={16} color="#000000" />
          </Pressable>
        </View>
      </View>

      {/* 2. Messages List with Native Keyboard Elevation */}
      <KeyboardAvoidingView style={{ flex: 1 }} behavior="padding" automaticOffset={true}>
        <View style={{ flex: 1 }}>
          <FlatList
            data={messageList}
            keyExtractor={(item) => item.id}
            inverted
            contentContainerStyle={{ paddingHorizontal: 16, paddingVertical: 14 }}
            showsVerticalScrollIndicator={false}
            ListFooterComponent={
              <View style={{ alignItems: 'center', marginVertical: 10 }}>
                <View
                  style={{
                    backgroundColor: '#ECE6C2',
                    borderWidth: 1.2,
                    borderColor: '#000000',
                    borderRadius: 12,
                    paddingHorizontal: 12,
                    paddingVertical: 3,
                  }}>
                  <Text style={{ fontSize: 11, fontWeight: '600', color: '#414141' }}>Today</Text>
                </View>
              </View>
            }
            renderItem={({ item }) => {
              const isMine = item.mine || item.senderId === 'me';
              return (
                <View
                  style={{
                    alignItems: isMine ? 'flex-end' : 'flex-start',
                    marginVertical: 6,
                  }}>
                  <View style={{ position: 'relative', maxWidth: '82%' }}>
                    {/* Brutalist Hard Shadow Layer */}
                    <View
                      style={{
                        position: 'absolute',
                        top: 2,
                        left: -1,
                        right: 1,
                        bottom: -2,
                        backgroundColor: '#000000',
                        borderRadius: 16,
                      }}
                    />
                    {/* Message Bubble Surface */}
                    <View
                      style={{
                        paddingHorizontal: 16,
                        paddingVertical: 10,
                        borderRadius: 16,
                        borderWidth: 2,
                        borderColor: '#000000',
                        backgroundColor: isMine ? '#73BDA8' : '#ECE6C2',
                      }}>
                      <Text
                        style={{
                          fontSize: 14,
                          fontWeight: '600',
                          color: '#020202',
                          lineHeight: 19,
                          fontFamily: 'HankenGrotesk-Medium',
                        }}>
                        {item.body}
                      </Text>
                    </View>
                  </View>
                </View>
              );
            }}
          />

          {/* Peer Typing Indicator */}
          {isPeerTyping ? (
            <View style={{ paddingHorizontal: 20, paddingVertical: 4 }}>
              <Text style={{ fontSize: 11, fontStyle: 'italic', fontWeight: '700', color: '#6E6E6E' }}>
                {peerName} is typing...
              </Text>
            </View>
          ) : null}

          {/* Quick Reaction Pills */}
          <View style={{ paddingHorizontal: 16, paddingVertical: 6 }}>
            <ScrollView horizontal showsHorizontalScrollIndicator={false} contentContainerStyle={{ gap: 6 }}>
              {['🚩 Red Flag', '💚 Green Flag', '🏃 Run!', '🙌 Solid Advice', '🤔 Ask him directly'].map(
                (quick) => (
                  <Pressable
                    key={quick}
                    unstable_pressDelay={0}
                    onPress={() => sendQuickReaction(quick)}
                    style={{
                      paddingHorizontal: 10,
                      paddingVertical: 4,
                      borderRadius: 14,
                      borderWidth: 1.5,
                      borderColor: '#000000',
                      backgroundColor: '#ECE6C2',
                      shadowColor: '#000000',
                      shadowOffset: { width: 0, height: 1 },
                      shadowOpacity: 1,
                      shadowRadius: 0,
                    }}>
                    <Text style={{ fontSize: 11, fontWeight: '700', color: '#020202' }}>{quick}</Text>
                  </Pressable>
                ),
              )}
            </ScrollView>
          </View>

          {/* 3. Sticky Bottom Input (Matching HTML spec) */}
          <View
            style={{
              paddingHorizontal: 16,
              paddingTop: 8,
              paddingBottom: isKeyboardVisible ? 10 : insets.bottom + 10,
              backgroundColor: '#ECE6C2',
              borderTopWidth: 2,
              borderTopColor: '#000000',
            }}>
            <View style={{ position: 'relative' }}>
              <View
                style={{
                  position: 'absolute',
                  top: 3,
                  left: -1,
                  right: 1,
                  bottom: -3,
                  backgroundColor: '#000000',
                  borderRadius: 20,
                }}
              />
              <View
                style={{
                  height: 46,
                  borderRadius: 20,
                  backgroundColor: '#ECE6C2',
                  borderWidth: 2,
                  borderColor: '#000000',
                  flexDirection: 'row',
                  alignItems: 'center',
                  paddingHorizontal: 14,
                  gap: 8,
                }}>
                <TextInput
                  value={text}
                  onChangeText={(val) => {
                    setText(val);
                    sendTyping();
                  }}
                  placeholder="Message..."
                  placeholderTextColor="#6E6E6E"
                  style={{
                    flex: 1,
                    fontSize: 13,
                    color: '#020202',
                    fontFamily: 'HankenGrotesk-Medium',
                    paddingVertical: 0,
                  }}
                  onSubmitEditing={handleSend}
                />

                <Pressable
                  unstable_pressDelay={0}
                  onPress={handleSend}
                  disabled={!text.trim()}
                  style={{
                    paddingHorizontal: 14,
                    paddingVertical: 6,
                    borderRadius: 14,
                    borderWidth: 1.5,
                    borderColor: '#000000',
                    backgroundColor: text.trim() ? '#73BDA8' : '#DFDFE8',
                    opacity: text.trim() ? 1 : 0.6,
                  }}>
                  <Text style={{ fontSize: 12, fontWeight: '800', color: '#020202' }}>Send</Text>
                </Pressable>
              </View>
            </View>
          </View>
        </View>
      </KeyboardAvoidingView>
    </View>
  );
}
