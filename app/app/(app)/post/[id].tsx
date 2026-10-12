import React, { useState, useEffect, useRef } from 'react';
import {
  Alert,
  FlatList,
  Pressable,
  Share,
  StatusBar,
  Text,
  TextInput,
  View,
} from 'react-native';
import { router, useLocalSearchParams } from 'expo-router';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { Feather, Ionicons } from '@expo/vector-icons';
import { KeyboardAvoidingView } from 'react-native-keyboard-controller';

import { BrutalistAvatar } from '@/components/tea/BrutalistAvatar';
import { BrutalButton, BrutalCard, EmptyState, LoadingState, VerdictVoteBar } from '@/components/tea/ui';
import {
  useAddComment,
  useBlockUser,
  useComments,
  usePost,
  useProfile,
  useReportUser,
  useToggleFollow,
  useToggleLike,
  useToggleSave,
  useVoteVerdict,
} from '@/hooks/useDating';
import { useKeyboard } from '@/hooks/useKeyboard';
import type { FeedComment } from '@/lib/fixtures';

export default function PostDetailScreen() {
  const { id } = useLocalSearchParams<{ id: string }>();
  const insets = useSafeAreaInsets();
  const { isKeyboardVisible } = useKeyboard();

  const me = useProfile();
  const postQuery = usePost(id);
  const commentsQuery = useComments(id);
  const addComment = useAddComment(id);
  const toggleLike = useToggleLike();
  const toggleSave = useToggleSave();
  const voteVerdict = useVoteVerdict();
  const toggleFollow = useToggleFollow();
  const blockUser = useBlockUser();
  const reportUser = useReportUser();

  const [commentText, setCommentText] = useState('');

  const post = postQuery.data;
  const comments = commentsQuery.data ?? [];
  const isSelf = Boolean(post && me.data?.user_id && post.authorId === me.data.user_id);

  // Pillar 39: Local-first state for 0ms micro-interactions
  const [isFollowed, setIsFollowed] = useState(Boolean(post?.followedByMe));
  const displayedFollowed = useRef(Boolean(post?.followedByMe));
  useEffect(() => {
    if (displayedFollowed.current !== Boolean(post?.followedByMe)) {
      displayedFollowed.current = Boolean(post?.followedByMe);
      setIsFollowed(Boolean(post?.followedByMe));
    }
  }, [post?.followedByMe]);

  const [isLiked, setIsLiked] = useState<boolean>(Boolean(post?.likedByMe));
  const [localLikeCount, setLocalLikeCount] = useState<number>(post?.likeCount ?? 0);
  const displayedLiked = useRef<boolean>(Boolean(post?.likedByMe));
  useEffect(() => {
    if (displayedLiked.current !== Boolean(post?.likedByMe)) {
      displayedLiked.current = Boolean(post?.likedByMe);
      setIsLiked(Boolean(post?.likedByMe));
      setLocalLikeCount(post?.likeCount ?? 0);
    }
  }, [post?.likedByMe, post?.likeCount]);

  const [isSaved, setIsSaved] = useState<boolean>(Boolean(post?.savedByMe));
  const displayedSaved = useRef<boolean>(Boolean(post?.savedByMe));
  useEffect(() => {
    if (displayedSaved.current !== Boolean(post?.savedByMe)) {
      displayedSaved.current = Boolean(post?.savedByMe);
      setIsSaved(Boolean(post?.savedByMe));
    }
  }, [post?.savedByMe]);

  const handleFollowPress = () => {
    if (!post?.authorId) return;
    const next = !displayedFollowed.current;
    displayedFollowed.current = next;
    setIsFollowed(next);
    toggleFollow.mutate(post.authorId);
  };

  const handleLikePress = () => {
    if (!post?.id) return;
    const next = !displayedLiked.current;
    displayedLiked.current = next;
    setIsLiked(next);
    setLocalLikeCount((prev: number) => (next ? prev + 1 : Math.max(0, prev - 1)));
    toggleLike.mutate(post.id);
  };

  const handleSavePress = () => {
    if (!post?.id) return;
    const next = !displayedSaved.current;
    displayedSaved.current = next;
    setIsSaved(next);
    toggleSave.mutate(post.id);
  };

  const back = () => (router.canGoBack() ? router.back() : router.replace('/(app)'));

  const handleSafetyAction = () => {
    if (!post) return;
    if (isSelf) {
      Alert.alert('Your Dilemma', 'You published this dating dilemma to the community.', [
        {
          text: 'Share Dilemma',
          onPress: () => {
            Share.share({
              message: `"${post.title}" — What's your verdict on Tea Dating Advice?`,
            }).catch(() => {});
          },
        },
        { text: 'View Profile', onPress: () => router.push('/(app)/me') },
        { text: 'Close', style: 'cancel' },
      ]);
      return;
    }
    Alert.alert(
      'Dilemma Options',
      `Options for @${post.authorHandle || post.author}:`,
      [
        {
          text: 'Share Dilemma',
          onPress: () => {
            Share.share({
              message: `"${post.title}" — What's your verdict on Tea Dating Advice?`,
            }).catch(() => {});
          },
        },
        {
          text: 'Report Inappropriate Content',
          style: 'destructive',
          onPress: () => {
            Alert.alert('Report Reason', 'Why are you reporting this dilemma?', [
              { text: 'Harassment / Hate', onPress: () => sendReport('Harassment') },
              { text: 'Spam / Scam', onPress: () => sendReport('Spam') },
              { text: 'Inappropriate Content', onPress: () => sendReport('Inappropriate') },
              { text: 'Cancel', style: 'cancel' },
            ]);
          },
        },
        {
          text: `Block @${post.authorHandle || post.author}`,
          style: 'destructive',
          onPress: () => {
            Alert.alert(
              'Block User?',
              `You will no longer see dilemmas or receive messages from @${post.authorHandle || post.author}.`,
              [
                { text: 'Cancel', style: 'cancel' },
                {
                  text: 'Block',
                  style: 'destructive',
                  onPress: async () => {
                    try {
                      await blockUser.mutateAsync(post.authorId);
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
    if (!post) return;
    try {
      await reportUser.mutateAsync({
        userId: post.authorId,
        reason,
        details: `Post: ${post.id} - ${post.title}`,
      });
      Alert.alert('Report Submitted', 'Thank you. Our moderators will review this content.');
    } catch (e) {
      Alert.alert('Error', e instanceof Error ? e.message : 'Could not submit report');
    }
  };

  const handleSendComment = () => {
    const text = commentText.trim();
    if (!text || addComment.isPending) return;
    setCommentText('');
    addComment.mutate(text);
  };

  const handleVote = (vote: 'red' | 'green' | 'valid') => {
    const targetId = post?.id || id;
    if (!targetId) return;
    voteVerdict.mutate({ postId: targetId, vote });
  };

  if (postQuery.isLoading) {
    return <LoadingState message="Fetching dating situation..." />;
  }

  if (!post) {
    return (
      <View className="flex-1 bg-[#ece6c2] items-center justify-center p-6" style={{ paddingTop: insets.top }}>
        <StatusBar barStyle="dark-content" backgroundColor="#ece6c2" />
        <View
          className="bg-white border-2 border-black rounded-[4px] p-6 items-center max-w-sm w-full"
          style={{
            shadowColor: '#000',
            shadowOffset: { width: -2, height: 4 },
            shadowOpacity: 1,
            shadowRadius: 0,
            elevation: 4,
          }}>
          <Text className="text-4xl mb-3">☕</Text>
          <Text className="text-base font-black text-black mb-1.5 text-center">Post not found</Text>
          <Text className="text-xs font-semibold text-[#666] text-center mb-5 leading-relaxed">
            This dating dilemma may have been deleted, moved, or the link has expired.
          </Text>
          <BrutalButton label="Go back to feed" onPress={back} variant="mint" />
        </View>
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
          <View className="bg-[#fdfbef] px-2.5 py-1 border border-black rounded-[2px]">
            <Text className="text-xs font-black uppercase text-black">{post.category}</Text>
          </View>
        </View>

        <View className="flex-row items-center gap-2">
          {/* Bookmark / Save */}
          <Pressable
            unstable_pressDelay={0}
            onPress={handleSavePress}
            className="w-10 h-10 rounded-[2px] bg-white border-2 border-black items-center justify-center active:translate-y-0.5"
            style={{
              shadowColor: '#000',
              shadowOffset: { width: -2, height: 2 },
              shadowOpacity: 1,
              shadowRadius: 0,
              elevation: 3,
            }}>
            <Ionicons
              name={isSaved ? 'bookmark' : 'bookmark-outline'}
              size={18}
              color={isSaved ? '#cc6b49' : '#000'}
            />
          </Pressable>

          {/* Safety Menu: Report / Block */}
          <Pressable
            unstable_pressDelay={0}
            onPress={handleSafetyAction}
            className="w-10 h-10 rounded-[2px] bg-white border-2 border-black items-center justify-center active:translate-y-0.5"
            style={{
              shadowColor: '#000',
              shadowOffset: { width: -2, height: 2 },
              shadowOpacity: 1,
              shadowRadius: 0,
              elevation: 3,
            }}>
            <Feather name="more-vertical" size={18} color="#000" />
          </Pressable>
        </View>
      </View>

      <KeyboardAvoidingView style={{ flex: 1 }} behavior="padding" automaticOffset={true}>
        <FlatList
          data={comments}
          keyExtractor={(item) => item.id}
          showsVerticalScrollIndicator={false}
          contentContainerStyle={{ padding: 18, paddingBottom: 30 }}
          ListHeaderComponent={
            <View className="mb-4">
              {/* Main Post Dilemma Card */}
              <BrutalCard variant="white" className="mb-4">
                {/* Author Info */}
                <View className="flex-row items-center justify-between mb-3 pb-3 border-b border-black/10">
                  <Pressable
                    onPress={() => {
                      if (isSelf) {
                        router.push('/(app)/me');
                      } else {
                        const target = post.authorId || post.authorHandle;
                        if (target) router.push(`/(app)/profile/${target}` as any);
                      }
                    }}
                    className="flex-row items-center gap-2.5 flex-1">
                    <BrutalistAvatar
                      name={post.author}
                      handle={post.authorHandle}
                      imageUrl={post.authorPhotoUrl}
                      size={44}
                      shape="square"
                    />
                    <View className="flex-1">
                      <View className="flex-row items-center gap-1.5 flex-wrap">
                        <Text className="text-sm font-black text-black">{post.author}</Text>
                        {post.authorRank ? (
                          <View className="bg-tea-mint px-1.5 py-0.2 border border-black rounded-[2px]">
                            <Text className="text-[9px] font-black uppercase text-black">
                              {post.authorRank}
                            </Text>
                          </View>
                        ) : null}
                      </View>
                      <Text className="text-[11px] font-semibold text-[#666]">
                        @{post.authorHandle || 'advisor'} • {(post.authorFollowers ?? 0).toLocaleString()} fans
                      </Text>
                    </View>
                  </Pressable>

                  {isSelf ? (
                    <View className="px-2.5 py-1 bg-tea-mint border border-black rounded-[2px]">
                      <Text className="text-[10px] font-black uppercase text-black">You (Author)</Text>
                    </View>
                  ) : (
                    <Pressable
                      unstable_pressDelay={0}
                      onPress={handleFollowPress}
                      className={`px-3 py-1.5 rounded-[2px] border-2 border-black active:translate-y-0.5 ${
                        isFollowed ? 'bg-[#ece6c2]' : 'bg-black'
                      }`}
                      style={{
                        shadowColor: '#000',
                        shadowOffset: { width: -2, height: 2 },
                        shadowOpacity: 1,
                        shadowRadius: 0,
                        elevation: 2,
                      }}>
                      <Text
                        className={`text-xs font-black ${
                          isFollowed ? 'text-black' : 'text-white'
                        }`}>
                        {isFollowed ? 'Following' : '+ Follow'}
                      </Text>
                    </Pressable>
                  )}
                </View>

                {/* Question & Story */}
                <Text className="text-lg font-black text-black leading-snug mb-2">{post.title}</Text>
                <Text className="text-sm text-[#222] font-medium leading-relaxed mb-4">
                  {post.question}
                </Text>

                {/* Verdict Voting Bar */}
                <View className="mb-4">
                  <Text className="text-[11px] font-black uppercase tracking-wider text-[#444] mb-1.5">
                    Cast Your Community Verdict:
                  </Text>
                  <VerdictVoteBar
                    redCount={post.redFlagCount}
                    greenCount={post.greenFlagCount}
                    validCount={post.validCount}
                    userVote={post.userVote || post.myVote}
                    onVote={handleVote}
                  />
                </View>

                {/* Action Stats Bar */}
                <View className="flex-row items-center justify-between pt-3 border-t-2 border-black">
                  <Pressable
                    unstable_pressDelay={0}
                    hitSlop={{ top: 8, bottom: 8, left: 8, right: 8 }}
                    onPress={handleLikePress}
                    className={`flex-row items-center gap-1.5 px-3 py-1.5 border border-black rounded-[2px] active:translate-y-0.5 ${
                      isLiked ? 'bg-tea-red/20' : 'bg-[#ece6c2]'
                    }`}>
                    <Ionicons
                      name={isLiked ? 'heart' : 'heart-outline'}
                      size={16}
                      color={isLiked ? '#cc6b49' : '#000'}
                    />
                    <Text className="text-xs font-black text-black">
                      {localLikeCount} {localLikeCount === 1 ? 'Upvote' : 'Upvotes'}
                    </Text>
                  </Pressable>

                  <View className="flex-row items-center gap-2">
                    <Text className="text-xs font-bold text-[#666]">
                      {comments.length} {comments.length === 1 ? 'Advisor Reply' : 'Advisor Replies'}
                    </Text>
                  </View>
                </View>
              </BrutalCard>

              {/* Discussion Title Banner */}
              <View className="flex-row items-center justify-between px-1 mb-2">
                <Text className="text-xs font-black uppercase tracking-wider text-black">
                  Spilled Advice ({comments.length})
                </Text>
                <Text className="text-[10px] font-bold text-[#666]">Community Verdicts</Text>
              </View>
            </View>
          }
          ListEmptyComponent={
            commentsQuery.isLoading ? (
              <LoadingState message="Fetching replies..." />
            ) : (
              <EmptyState
                icon="message-circle"
                title="No advice spilled yet"
                description="Give your honest verdict and help solve this dating dilemma."
              />
            )
          }
          renderItem={({ item }) => (
            <CommentCard
              comment={item}
              onPressAuthor={() => {
                if (item.userId === me.data?.user_id) {
                  router.push('/(app)/me');
                } else if (item.userId) {
                  router.push(`/(app)/profile/${item.userId}`);
                }
              }}
            />
          )}
        />

        {/* Input Bar */}
        <View
          className="border-t-2 border-black bg-white px-4 py-3 flex-row items-center gap-2"
          style={{ paddingBottom: isKeyboardVisible ? 10 : insets.bottom + 10 }}>
          <TextInput
            value={commentText}
            onChangeText={setCommentText}
            placeholder="Spill your advice here..."
            placeholderTextColor="#777"
            maxLength={600}
            className="flex-1 h-11 bg-[#ece6c2] border-2 border-black px-3.5 text-sm font-medium text-black rounded-[2px]"
            onSubmitEditing={handleSendComment}
          />
          <Pressable
            unstable_pressDelay={0}
            onPress={handleSendComment}
            disabled={!commentText.trim() || addComment.isPending}
            className="h-11 px-4 bg-[#73bda8] border-2 border-black rounded-[2px] items-center justify-center active:translate-y-0.5"
            style={{
              shadowColor: '#000',
              shadowOffset: { width: -2, height: 2 },
              shadowOpacity: 1,
              shadowRadius: 0,
              elevation: 3,
              opacity: commentText.trim() ? 1 : 0.5,
            }}>
            <Text className="text-xs font-black uppercase text-black">Spill</Text>
          </Pressable>
        </View>
      </KeyboardAvoidingView>
    </View>
  );
}

function CommentCard({
  comment,
  onPressAuthor,
}: {
  comment: FeedComment;
  onPressAuthor: () => void;
}) {
  return (
    <View
      className="mb-3 p-3.5 bg-white border-2 border-black rounded-[3px]"
      style={{
        shadowColor: '#000',
        shadowOffset: { width: -2, height: 3 },
        shadowOpacity: 1,
        shadowRadius: 0,
        elevation: 3,
      }}>
      <View className="flex-row items-center justify-between mb-2">
        <Pressable onPress={onPressAuthor} className="flex-row items-center gap-2 flex-1">
          <BrutalistAvatar
            name={comment.name}
            imageUrl={comment.photoUrl}
            size={32}
            shape="square"
          />
          <View>
            <View className="flex-row items-center gap-1.5">
              <Text className="text-xs font-black text-black">{comment.name}</Text>
              {comment.advisorRank ? (
                <View className="bg-tea-mint px-1 rounded-[2px] border border-black">
                  <Text className="text-[9px] font-black uppercase text-black">
                    {comment.advisorRank}
                  </Text>
                </View>
              ) : null}
            </View>
          </View>
        </Pressable>

        <Text className="text-[10px] font-semibold text-[#666]">
          {new Date(comment.createdAt).toLocaleDateString([], { month: 'short', day: 'numeric' })}
        </Text>
      </View>

      <Text className="text-xs text-black font-medium leading-relaxed">{comment.body}</Text>
    </View>
  );
}
