import React, { ReactNode, useState, useEffect, useRef } from 'react';
import {
  ActivityIndicator,
  Pressable,
  ScrollView,
  StyleSheet,
  Text,
  View,
  ViewStyle,
} from 'react-native';
import Svg, { Circle, Path, Rect } from 'react-native-svg';
import { brand } from '@/constants/brand';
import { BrutalistAvatar } from '@/components/tea/BrutalistAvatar';

// ==========================================
// 1. NEO-BRUTALIST BUTTON
// ==========================================
interface BrutalButtonProps {
  label: string;
  onPress?: () => void;
  variant?: 'mint' | 'blue' | 'canvas' | 'white' | 'danger' | 'paper' | 'terracotta';
  size?: 'sm' | 'md' | 'lg';
  disabled?: boolean;
  loading?: boolean;
  icon?: ReactNode;
  style?: ViewStyle;
}

export function BrutalButton({
  label,
  onPress,
  variant = 'mint',
  size = 'md',
  disabled = false,
  loading = false,
  icon,
  style,
}: BrutalButtonProps) {
  const bg =
    variant === 'mint'
      ? '#73BDA8'
      : variant === 'blue'
      ? '#0EA8FF'
      : variant === 'canvas' || variant === 'paper'
      ? '#ECE6C2'
      : variant === 'danger'
      ? '#D72A2A'
      : variant === 'terracotta'
      ? '#CC6B49'
      : '#FFFFFF';

  const textColor = variant === 'blue' || variant === 'danger' || variant === 'terracotta' ? '#FFFFFF' : '#020202';
  const height = size === 'sm' ? 32 : size === 'lg' ? 50 : 42;
  const paddingX = size === 'sm' ? 12 : size === 'lg' ? 22 : 16;
  const fontSize = size === 'sm' ? 12 : size === 'lg' ? 16 : 14;
  const shadowDist = size === 'sm' ? 2 : 3;
  const shadowX = -2;
  const shadowY = shadowDist;

  return (
    <Pressable
      unstable_pressDelay={0}
      onPress={onPress}
      disabled={disabled || loading}
      style={({ pressed }) => [
        { position: 'relative' },
        style,
      ]}>
      {({ pressed }) => (
        <View style={{ position: 'relative' }}>
          {/* Brutalist Hard Shadow Layer (Stationary Background) */}
          <View
            pointerEvents="none"
            style={{
              position: 'absolute',
              top: shadowY,
              left: shadowX,
              right: -shadowX,
              bottom: -shadowY,
              backgroundColor: '#000000',
              borderRadius: 6,
            }}
          />
          {/* Front Surface */}
          <View
            style={{
              height,
              paddingHorizontal: paddingX,
              backgroundColor: bg,
              borderRadius: 6,
              borderWidth: 2,
              borderColor: '#000000',
              flexDirection: 'row',
              alignItems: 'center',
              justifyContent: 'center',
              gap: 6,
              opacity: disabled ? 0.6 : 1,
              transform: pressed
                ? [{ translateX: shadowX }, { translateY: shadowY }]
                : [],
            }}>
            {loading ? (
              <ActivityIndicator color={textColor} size="small" />
            ) : (
              <>
                {icon}
                <Text
                  style={{
                    color: textColor,
                    fontSize,
                    fontWeight: '800',
                    fontFamily: 'HankenGrotesk-Bold',
                  }}>
                  {label}
                </Text>
              </>
            )}
          </View>
        </View>
      )}
    </Pressable>
  );
}

// ==========================================
// 2. NEO-BRUTALIST CARD CONTAINER
// ==========================================
interface BrutalCardProps {
  children: ReactNode;
  bg?: string;
  variant?: 'white' | 'paper' | 'canvas' | 'mint' | 'blue';
  shadowOffset?: { x: number; y: number };
  className?: string;
  style?: ViewStyle;
  onPress?: () => void;
}

export function BrutalCard({
  children,
  bg,
  variant = 'white',
  shadowOffset = { x: -1, y: 3 },
  className,
  style,
  onPress,
}: BrutalCardProps) {
  const cardBg =
    bg ||
    (variant === 'white'
      ? '#FFFFFF'
      : variant === 'paper' || variant === 'canvas'
      ? '#ECE6C2'
      : variant === 'mint'
      ? '#73BDA8'
      : variant === 'blue'
      ? '#0EA8FF'
      : '#FFFFFF');

  const content = (
    <View className={className} style={[{ position: 'relative', marginVertical: 6 }, style]}>
      {/* Hard Offset Shadow */}
      <View
        style={{
          position: 'absolute',
          top: shadowOffset.y,
          left: shadowOffset.x,
          right: -shadowOffset.x,
          bottom: -shadowOffset.y,
          backgroundColor: '#000000',
          borderRadius: 10,
        }}
      />
      {/* Card Content Surface */}
      <View
        style={{
          backgroundColor: cardBg,
          borderRadius: 10,
          borderWidth: 2,
          borderColor: '#000000',
          padding: 14,
          overflow: 'hidden',
        }}>
        {children}
      </View>
    </View>
  );

  if (onPress) {
    return (
      <Pressable
        unstable_pressDelay={0}
        onPress={onPress}
        style={({ pressed }) => (pressed ? { opacity: 0.95 } : {})}>
        {content}
      </Pressable>
    );
  }
  return content;
}

// ==========================================
// 3. CATEGORY CHIP / PILL
// ==========================================
interface CategoryPillProps {
  label: string;
  selected?: boolean;
  onPress?: () => void;
  count?: number;
  style?: ViewStyle;
}

export function CategoryPill({ label, selected, onPress, count, style }: CategoryPillProps) {
  return (
    <Pressable
      unstable_pressDelay={0}
      onPress={onPress}
      style={({ pressed }) => [
        {
          flexDirection: 'row',
          alignItems: 'center',
          gap: 5,
          paddingHorizontal: 12,
          paddingVertical: 6,
          backgroundColor: selected ? '#73BDA8' : '#ECE6C2',
          borderWidth: selected ? 2 : 1.5,
          borderColor: '#000000',
          borderRadius: 6,
          // Brutalist shadow
          shadowColor: '#000000',
          shadowOffset: { width: 0, height: selected ? 2 : 1 },
          shadowOpacity: 1,
          shadowRadius: 0,
          elevation: selected ? 2 : 1,
          transform: pressed ? [{ translateY: 1 }] : [],
        },
        style,
      ]}>
      <Text
        style={{
          fontSize: 12,
          fontWeight: selected ? '800' : '600',
          color: '#020202',
          fontFamily: selected ? 'HankenGrotesk-Bold' : 'HankenGrotesk-Medium',
        }}>
        {label}
      </Text>
      {count != null && (
        <View
          style={{
            backgroundColor: selected ? '#020202' : 'rgba(0,0,0,0.1)',
            paddingHorizontal: 5,
            paddingVertical: 1,
            borderRadius: 4,
          }}>
          <Text
            style={{
              fontSize: 10,
              fontWeight: '700',
              color: selected ? '#FFFFFF' : '#020202',
            }}>
            {count}
          </Text>
        </View>
      )}
    </Pressable>
  );
}

// ==========================================
// 4. QUICK NOTES / STATUS RAIL (From HTML spec)
// ==========================================
export interface NoteItem {
  id: string;
  userId?: string;
  author: string;
  name?: string;
  authorPhotoUrl?: string;
  note: string;
  emoji?: string;
  isSelf?: boolean;
}

export function QuickNotesRail({
  notes,
  currentUserPhotoUrl,
  onAddNote,
  onPressNote,
}: {
  notes: NoteItem[];
  currentUserPhotoUrl?: string;
  onAddNote?: () => void;
  onPressNote?: (note: NoteItem) => void;
}) {
  const myNote = notes.find((n) => n.isSelf);
  const otherNotes = notes.filter((n) => !n.isSelf);

  return (
    <ScrollView
      horizontal
      showsHorizontalScrollIndicator={false}
      contentContainerStyle={{ paddingHorizontal: 16, paddingVertical: 10, gap: 14 }}>
      {/* Add / Current User note card */}
      <Pressable
        unstable_pressDelay={0}
        onPress={() => (myNote ? onPressNote?.(myNote) : onAddNote?.())}
        style={{ alignItems: 'center', width: 68 }}>
        <View style={{ position: 'relative' }}>
          <BrutalistAvatar seed="You" name="You" imageUrl={currentUserPhotoUrl} size={54} shape="circle" />
          {myNote?.note ? (
            <View
              style={{
                position: 'absolute',
                top: -8,
                left: -6,
                maxWidth: 80,
                backgroundColor: '#73BDA8',
                borderWidth: 1.2,
                borderColor: '#000000',
                borderRadius: 6,
                paddingHorizontal: 6,
                paddingVertical: 2,
                shadowColor: '#000000',
                shadowOffset: { width: 0, height: 1 },
                shadowOpacity: 1,
                shadowRadius: 0,
              }}>
              <Text numberOfLines={1} style={{ fontSize: 9, fontWeight: '800', color: '#020202' }}>
                {myNote.note} {myNote.emoji || ''}
              </Text>
            </View>
          ) : (
            <View
              style={{
                position: 'absolute',
                bottom: 0,
                right: -2,
                backgroundColor: '#1FA1FF',
                borderWidth: 1.5,
                borderColor: '#000000',
                borderRadius: 999,
                width: 20,
                height: 20,
                alignItems: 'center',
                justifyContent: 'center',
              }}>
              <Text style={{ color: '#FFFFFF', fontSize: 13, fontWeight: '900', lineHeight: 14 }}>+</Text>
            </View>
          )}
        </View>
        <Text
          numberOfLines={1}
          style={{
            marginTop: 6,
            fontSize: 10,
            fontWeight: '600',
            color: '#020202',
            textAlign: 'center',
          }}>
          {myNote ? 'Your note' : 'Leave note'}
        </Text>
      </Pressable>

      {/* Other people's notes */}
      {otherNotes.map((item) => (
        <Pressable
          key={item.id}
          unstable_pressDelay={0}
          onPress={() => onPressNote?.(item)}
          style={{ alignItems: 'center', width: 68 }}>
          <View style={{ position: 'relative' }}>
            <BrutalistAvatar seed={item.author} name={item.name || item.author} imageUrl={item.authorPhotoUrl} size={54} shape="circle" />
            {item.note ? (
              <View
                style={{
                  position: 'absolute',
                  top: -8,
                  left: -6,
                  maxWidth: 80,
                  backgroundColor: '#ECE6C2',
                  borderWidth: 1.2,
                  borderColor: '#000000',
                  borderRadius: 6,
                  paddingHorizontal: 6,
                  paddingVertical: 2,
                  shadowColor: '#000000',
                  shadowOffset: { width: 0, height: 1 },
                  shadowOpacity: 1,
                  shadowRadius: 0,
                }}>
                <Text numberOfLines={1} style={{ fontSize: 9, fontWeight: '700', color: '#020202' }}>
                  {item.note} {item.emoji || ''}
                </Text>
              </View>
            ) : null}
          </View>
          <Text
            numberOfLines={1}
            style={{
              marginTop: 6,
              fontSize: 10,
              fontWeight: '600',
              color: '#020202',
              textAlign: 'center',
            }}>
            {item.name || item.author}
          </Text>
        </Pressable>
      ))}
    </ScrollView>
  );
}

// ==========================================
// 5. COMMUNITY VERDICT BADGE / BAR
// ==========================================
export function VerdictVoteBar({
  redFlagCount = 0,
  greenFlagCount = 0,
  validCount = 0,
  redCount,
  greenCount,
  userVote,
  onVote,
}: {
  redFlagCount?: number;
  greenFlagCount?: number;
  validCount?: number;
  redCount?: number;
  greenCount?: number;
  userVote?: 'red' | 'green' | 'valid' | null;
  onVote?: (vote: 'red' | 'green' | 'valid') => void;
}) {
  const effectiveRed = redCount ?? redFlagCount;
  const effectiveGreen = greenCount ?? greenFlagCount;

  // Pillar 39: Local-first state for 0ms instantaneous UI feedback.
  // The control flips on the exact frame of the tap; React Query and server sync in the background.
  const [localVote, setLocalVote] = useState<'red' | 'green' | 'valid' | null>(userVote ?? null);
  const displayedVote = useRef(userVote ?? null);

  const [counts, setCounts] = useState({
    red: effectiveRed,
    green: effectiveGreen,
    valid: validCount,
  });
  const displayedCounts = useRef({ red: effectiveRed, green: effectiveGreen, valid: validCount });

  // Sync only when parent props disagree (initial load, external update, or mutation error rollback)
  useEffect(() => {
    if (displayedVote.current !== (userVote ?? null)) {
      displayedVote.current = userVote ?? null;
      setLocalVote(userVote ?? null);
    }
  }, [userVote]);

  useEffect(() => {
    displayedCounts.current = { red: effectiveRed, green: effectiveGreen, valid: validCount };
    setCounts({ red: effectiveRed, green: effectiveGreen, valid: validCount });
  }, [effectiveRed, effectiveGreen, validCount]);

  const total = Math.max(1, counts.red + counts.green + counts.valid);
  const redPct = Math.round((counts.red / total) * 100);
  const greenPct = Math.round((counts.green / total) * 100);
  const validPct = Math.max(0, 100 - redPct - greenPct);

  const hasVote = Boolean(localVote);
  const isRed = localVote === 'red';
  const isGreen = localVote === 'green';
  const isValid = localVote === 'valid';

  const handleVotePress = (vote: 'red' | 'green' | 'valid') => {
    const current = displayedVote.current;
    const next = current === vote ? null : vote;

    // 1. Instantaneous local flip (<16ms, on the tap)
    displayedVote.current = next;
    setLocalVote(next);

    setCounts((prev) => {
      let r = prev.red;
      let g = prev.green;
      let v = prev.valid;
      if (current === 'red' && r > 0) r--;
      if (current === 'green' && g > 0) g--;
      if (current === 'valid' && v > 0) v--;
      if (next === 'red') r++;
      if (next === 'green') g++;
      if (next === 'valid') v++;
      return { red: r, green: g, valid: v };
    });

    // 2. Dispatch query cache update and remote persistence in the background
    onVote?.(vote);
  };

  return (
    <View style={{ marginVertical: 8 }}>
      <View
        style={{
          flexDirection: 'row',
          alignItems: 'center',
          justifyContent: 'space-between',
          marginBottom: 6,
        }}>
        <Text style={{ fontSize: 10, fontWeight: '800', color: '#CC6B49' }}>
          🚩 Red: {redPct}%
        </Text>
        <Text style={{ fontSize: 10, fontWeight: '800', color: '#73BDA8' }}>
          💚 Green: {greenPct}%
        </Text>
        <Text style={{ fontSize: 10, fontWeight: '800', color: '#32B5FF' }}>
          🤔 Valid: {validPct}%
        </Text>
      </View>

      {/* Tri-verdict Progress Bar with brutalist black outline */}
      <View
        style={{
          height: 8,
          borderRadius: 4,
          borderWidth: 1.5,
          borderColor: '#000000',
          backgroundColor: '#DFDFE8',
          flexDirection: 'row',
          overflow: 'hidden',
        }}>
        <View style={{ width: `${redPct}%`, backgroundColor: '#CC6B49' }} />
        <View style={{ width: `${greenPct}%`, backgroundColor: '#73BDA8' }} />
        <View style={{ width: `${validPct}%`, backgroundColor: '#32B5FF' }} />
      </View>

      {/* Quick Vote Action Buttons */}
      <View style={{ flexDirection: 'row', gap: 6, marginTop: 8 }}>
        <QuickVoteButton
          label="Red Flag"
          emoji="🚩"
          color="#E0533C"
          isSelected={isRed}
          hasVote={hasVote}
          onPress={() => handleVotePress('red')}
        />
        <QuickVoteButton
          label="Green Flag"
          emoji="💚"
          color="#73BDA8"
          isSelected={isGreen}
          hasVote={hasVote}
          onPress={() => handleVotePress('green')}
        />
        <QuickVoteButton
          label="Overreacting"
          emoji="🤔"
          color="#32B5FF"
          isSelected={isValid}
          hasVote={hasVote}
          onPress={() => handleVotePress('valid')}
        />
      </View>
    </View>
  );
}

function QuickVoteButton({
  label,
  emoji,
  color,
  isSelected,
  hasVote,
  onPress,
}: {
  label: string;
  emoji: string;
  color: string;
  isSelected: boolean;
  hasVote: boolean;
  onPress?: () => void;
}) {
  return (
    <Pressable
      unstable_pressDelay={0}
      hitSlop={{ top: 8, bottom: 8, left: 4, right: 4 }}
      onPress={onPress}
      style={({ pressed }) => [
        {
          flex: 1,
          flexDirection: 'row',
          alignItems: 'center',
          justifyContent: 'center',
          paddingVertical: 7,
          paddingHorizontal: 4,
          borderRadius: 4,
          borderWidth: isSelected ? 2.5 : 1.5,
          borderColor: '#000000',
          backgroundColor: isSelected || pressed ? color : hasVote ? '#F7F6F0' : '#FFFFFF',
          opacity: pressed ? 1 : hasVote && !isSelected ? 0.45 : 1,
          shadowColor: '#000000',
          shadowOffset:
            pressed || isSelected
              ? { width: 0, height: 0 }
              : { width: -1.5, height: 2 },
          shadowOpacity: 1,
          shadowRadius: 0,
          elevation: pressed || isSelected ? 0 : 2,
          transform:
            pressed && isSelected
              ? [{ translateY: 2.5 }, { scale: 0.98 }]
              : pressed || isSelected
              ? [{ translateY: 2 }]
              : [{ translateY: 0 }],
        },
      ]}>
      <View style={{ flexDirection: 'row', alignItems: 'center', justifyContent: 'center', gap: 4 }}>
        <Text style={{ fontSize: 11 }}>{emoji}</Text>
        <Text
          numberOfLines={1}
          style={{
            fontSize: 11,
            fontWeight: isSelected ? '900' : '600',
            color: '#000000',
          }}>
          {label}
        </Text>
      </View>
    </Pressable>
  );
}

// ==========================================
// 6. STATES: LOADING, EMPTY, ERROR
// ==========================================
export function LoadingState({ message = 'Pouring the tea…' }: { message?: string }) {
  return (
    <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center', padding: 32 }}>
      <View
        style={{
          width: 52,
          height: 52,
          borderRadius: 8,
          backgroundColor: '#73BDA8',
          borderWidth: 2,
          borderColor: '#000000',
          alignItems: 'center',
          justifyContent: 'center',
          shadowColor: '#000000',
          shadowOffset: { width: -2, height: 3 },
          shadowOpacity: 1,
          shadowRadius: 0,
          marginBottom: 14,
        }}>
        <ActivityIndicator color="#020202" size="large" />
      </View>
      <Text
        style={{
          fontSize: 14,
          fontWeight: '700',
          color: '#020202',
          fontFamily: 'HankenGrotesk-Bold',
        }}>
        {message}
      </Text>
    </View>
  );
}

export function EmptyState({
  emoji = '🫖',
  icon,
  title = 'No tea yet',
  body,
  description,
  actionLabel,
  onAction,
}: {
  emoji?: string;
  icon?: string;
  title?: string;
  body?: string;
  description?: string;
  actionLabel?: string;
  onAction?: () => void;
}) {
  const displayEmoji =
    icon === 'bell'
      ? '🔔'
      : icon === 'feather'
      ? '🪶'
      : icon === 'message-square' || icon === 'message-circle'
      ? '💬'
      : icon === 'bookmark'
      ? '🔖'
      : emoji;
  const displayText = body || description || 'Be the first to drop some advice or ask a burning dating question.';
  return (
    <View style={{ alignItems: 'center', justifyContent: 'center', padding: 32 }}>
      <View
        style={{
          width: 72,
          height: 72,
          borderRadius: 12,
          backgroundColor: '#ECE6C2',
          borderWidth: 2,
          borderColor: '#000000',
          alignItems: 'center',
          justifyContent: 'center',
          shadowColor: '#000000',
          shadowOffset: { width: -2, height: 4 },
          shadowOpacity: 1,
          shadowRadius: 0,
          marginBottom: 16,
        }}>
        <Text style={{ fontSize: 36 }}>{displayEmoji}</Text>
      </View>
      <Text
        style={{
          fontSize: 18,
          fontWeight: '800',
          color: '#020202',
          textAlign: 'center',
          fontFamily: 'HankenGrotesk-Black',
        }}>
        {title}
      </Text>
      {displayText ? (
        <Text
          style={{
            marginTop: 6,
            fontSize: 13,
            color: '#6E6E6E',
            textAlign: 'center',
            lineHeight: 18,
            fontFamily: 'HankenGrotesk-Regular',
            maxWidth: 260,
          }}>
          {displayText}
        </Text>
      ) : null}
      {actionLabel && onAction ? (
        <View style={{ marginTop: 18 }}>
          <BrutalButton label={actionLabel} onPress={onAction} variant="mint" />
        </View>
      ) : null}
    </View>
  );
}

export function ErrorState({
  error,
  onRetry,
}: {
  error?: unknown;
  onRetry?: () => void;
}) {
  const msg = error instanceof Error ? error.message : 'Could not load data';
  return (
    <EmptyState
      emoji="⚠️"
      title="Spilled the tea!"
      body={msg}
      actionLabel={onRetry ? 'Try Again' : undefined}
      onAction={onRetry}
    />
  );
}

// ==========================================
// 7. SCREEN TOP BAR
// ==========================================
export function TeaScreenHeader({
  title,
  showBack,
  onBack,
  right,
}: {
  title: string;
  showBack?: boolean;
  onBack?: () => void;
  right?: ReactNode;
}) {
  return (
    <View
      style={{
        flexDirection: 'row',
        alignItems: 'center',
        justifyContent: 'space-between',
        paddingHorizontal: 16,
        paddingVertical: 12,
        backgroundColor: '#ECE6C2',
        borderBottomWidth: 2,
        borderBottomColor: '#000000',
      }}>
      <View style={{ flexDirection: 'row', alignItems: 'center', gap: 10 }}>
        {showBack && (
          <Pressable
            onPress={onBack}
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
                stroke="#020202"
                strokeWidth={2.5}
                strokeLinecap="round"
                strokeLinejoin="round"
              />
            </Svg>
          </Pressable>
        )}
        <Text
          style={{
            fontSize: 20,
            fontWeight: '900',
            color: '#020202',
            fontFamily: 'HankenGrotesk-Black',
            letterSpacing: -0.5,
          }}>
          {title}
        </Text>
      </View>
      {right}
    </View>
  );
}
