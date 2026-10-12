import React, { useState } from 'react';
import { Image, StyleSheet, Text, View } from 'react-native';
import { brutalistAvatarScheme, initials } from '@/constants/theme';
import { mediaUrl } from '@/constants/config';

export type AvatarSize = 'xs' | 'sm' | 'md' | 'lg' | 'xl' | 'hero' | number;

const SIZE_MAP = {
  xs: 28,
  sm: 36,
  md: 44,
  lg: 56,
  xl: 72,
  hero: 92,
} as const;

// Deterministic brutalist glyphs for avatar variety
const GLYPHS = ['▲', '■', '●', '✦', '★', '◆', '✶', '⚡', '✿', '⬡'] as const;

function getGlyph(seed: string): string {
  let h = 0;
  for (let i = 0; i < seed.length; i++) h = (h * 17 + seed.charCodeAt(i)) >>> 0;
  return GLYPHS[h % GLYPHS.length];
}

interface BrutalistAvatarProps {
  seed?: string;
  name?: string;
  handle?: string;
  imageUrl?: string | null;
  photoUrl?: string | null;
  size?: AvatarSize;
  shape?: 'square' | 'circle' | 'rounded';
  badge?: 'verified' | 'advisor' | 'red_flag' | 'none';
  showLock?: boolean;
  showLockBadge?: boolean;
  style?: any;
}

export function BrutalistAvatar({
  seed,
  name,
  handle,
  imageUrl,
  photoUrl,
  size = 'md',
  shape = 'rounded',
  badge = 'none',
  showLock = false,
  showLockBadge = false,
  style,
}: BrutalistAvatarProps) {
  const [imageError, setImageError] = useState(false);
  const effectiveUrl = mediaUrl(imageUrl || photoUrl);
  const showImage = Boolean(effectiveUrl && !imageError);

  const effectiveSeed = seed || handle || name || 'tea';
  const effectiveLock = showLock || showLockBadge;
  const px = typeof size === 'number' ? size : SIZE_MAP[size] || 44;
  const displayName = name || handle || effectiveSeed || 'Tea';
  const scheme = brutalistAvatarScheme(effectiveSeed);
  const glyph = getGlyph(effectiveSeed);
  const userInitials = initials(displayName);

  const borderRadius =
    shape === 'circle'
      ? px / 2
      : shape === 'square'
      ? 2
      : Math.max(6, Math.round(px * 0.22));

  const borderWidth = px >= 56 ? 2.5 : 2;
  const shadowOffset = px >= 56 ? -2 : -1;
  const shadowDist = px >= 56 ? 3 : 2;

  return (
    <View style={[{ width: px, height: px }, style]}>
      {/* Brutalist Hard Drop Shadow Layer */}
      <View
        style={{
          position: 'absolute',
          top: shadowDist,
          left: shadowOffset,
          width: px,
          height: px,
          borderRadius,
          backgroundColor: '#000000',
        }}
      />

      {/* Main Avatar Container */}
      <View
        style={{
          width: px,
          height: px,
          borderRadius,
          borderWidth,
          borderColor: '#000000',
          backgroundColor: scheme.bg,
          alignItems: 'center',
          justifyContent: 'center',
          overflow: 'hidden',
        }}>
        {showImage ? (
          <Image
            source={{ uri: effectiveUrl! }}
            style={StyleSheet.absoluteFill}
            resizeMode="cover"
            onError={() => setImageError(true)}
          />
        ) : (
          <>
            {/* Subtle geometric background watermark */}
            <Text
              style={{
                position: 'absolute',
                opacity: 0.15,
                fontSize: px * 0.65,
                color: scheme.text,
                fontWeight: '900',
                textAlign: 'center',
              }}>
              {glyph}
            </Text>

            {/* Primary Initials / Monogram */}
            <Text
              style={{
                color: scheme.text,
                fontWeight: '900',
                fontSize: px * 0.38,
                letterSpacing: -0.5,
                fontFamily: 'HankenGrotesk-Black',
              }}>
              {userInitials}
            </Text>
          </>
        )}
      </View>

      {/* Status / Badge Overlay */}
      {badge === 'verified' && (
        <View
          style={{
            position: 'absolute',
            bottom: -2,
            right: -2,
            width: Math.max(14, px * 0.3),
            height: Math.max(14, px * 0.3),
            borderRadius: Math.max(7, (px * 0.3) / 2),
            backgroundColor: '#0EA8FF',
            borderWidth: 1.5,
            borderColor: '#000000',
            alignItems: 'center',
            justifyContent: 'center',
          }}>
          <Text style={{ color: '#FFFFFF', fontSize: Math.max(7, px * 0.16), fontWeight: '900' }}>✓</Text>
        </View>
      )}

      {badge === 'advisor' && (
        <View
          style={{
            position: 'absolute',
            top: -3,
            right: -3,
            width: Math.max(14, px * 0.32),
            height: Math.max(14, px * 0.32),
            borderRadius: Math.max(7, (px * 0.32) / 2),
            backgroundColor: '#32B5FF',
            borderWidth: 1.5,
            borderColor: '#000000',
            alignItems: 'center',
            justifyContent: 'center',
          }}>
          <Text style={{ color: '#000000', fontSize: Math.max(8, px * 0.18), fontWeight: '900' }}>★</Text>
        </View>
      )}

      {badge === 'red_flag' && (
        <View
          style={{
            position: 'absolute',
            bottom: -1,
            right: -1,
            width: Math.max(12, px * 0.26),
            height: Math.max(12, px * 0.26),
            borderRadius: 999,
            backgroundColor: '#CC6B49',
            borderWidth: 1.2,
            borderColor: '#000000',
          }}
        />
      )}

      {/* Permanent Lock Indicator */}
      {effectiveLock && (
        <View
          style={{
            position: 'absolute',
            bottom: -4,
            left: -4,
            backgroundColor: '#ECE6C2',
            borderWidth: 1.5,
            borderColor: '#000000',
            borderRadius: 6,
            paddingHorizontal: 3,
            paddingVertical: 1,
            flexDirection: 'row',
            alignItems: 'center',
          }}>
          <Text style={{ fontSize: 9 }}>🔒</Text>
        </View>
      )}
    </View>
  );
}
