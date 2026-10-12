import React from 'react';
import { Pressable, Text, View } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import type { Href } from 'expo-router';
import { router, usePathname } from 'expo-router';
import Svg, { Circle, Path, Rect } from 'react-native-svg';

interface TabItem {
  href: Href;
  match: string;
  label: string;
  icon: (active: boolean) => React.ReactNode;
}

const TABS: TabItem[] = [
  {
    href: '/(app)',
    match: '/(app)',
    label: 'Feed',
    icon: (active) => (
      <Svg width={22} height={22} viewBox="0 0 24 24" fill="none">
        <Rect
          x={3}
          y={3}
          width={18}
          height={18}
          rx={3}
          stroke="#000000"
          strokeWidth={active ? 2.5 : 2}
          fill={active ? '#73BDA8' : 'none'}
        />
        <Path d="M7 8h10M7 12h10M7 16h6" stroke="#000000" strokeWidth={2} strokeLinecap="round" />
      </Svg>
    ),
  },
  {
    href: '/(app)/search',
    match: '/search',
    label: 'Search',
    icon: (active) => (
      <Svg width={22} height={22} viewBox="0 0 24 24" fill="none">
        <Circle
          cx={11}
          cy={11}
          r={7}
          stroke="#000000"
          strokeWidth={active ? 2.5 : 2}
          fill={active ? '#32B5FF' : 'none'}
        />
        <Path d="M20 20l-4-4" stroke="#000000" strokeWidth={active ? 2.5 : 2} strokeLinecap="round" />
      </Svg>
    ),
  },
  {
    href: '/(app)/advisors',
    match: '/advisors',
    label: 'Advisors',
    icon: (active) => (
      <Svg width={22} height={22} viewBox="0 0 24 24" fill="none">
        <Path
          d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"
          stroke="#000000"
          strokeWidth={active ? 2.5 : 2}
          fill={active ? '#FFD166' : 'none'}
          strokeLinejoin="round"
        />
      </Svg>
    ),
  },
  {
    href: '/(app)/messages',
    match: '/messages',
    label: 'Messages',
    icon: (active) => (
      <Svg width={22} height={22} viewBox="0 0 24 24" fill="none">
        <Path
          d="M21 11.5a8.38 8.38 0 0 1-.9 3.8 8.5 8.5 0 0 1-7.6 4.7 8.38 8.38 0 0 1-3.8-.9L3 21l1.9-5.7a8.38 8.38 0 0 1-.9-3.8 8.5 8.5 0 0 1 4.7-7.6 8.38 8.38 0 0 1 3.8-.9h.5a8.48 8.48 0 0 1 8 8v.5z"
          stroke="#000000"
          strokeWidth={active ? 2.5 : 2}
          fill={active ? '#73BDA8' : 'none'}
          strokeLinejoin="round"
        />
      </Svg>
    ),
  },
  {
    href: '/(app)/me',
    match: '/me',
    label: 'Profile',
    icon: (active) => (
      <Svg width={22} height={22} viewBox="0 0 24 24" fill="none">
        <Circle
          cx={12}
          cy={7}
          r={4}
          stroke="#000000"
          strokeWidth={active ? 2.5 : 2}
          fill={active ? '#CC6B49' : 'none'}
        />
        <Path
          d="M4 21v-2a4 4 0 0 1 4-4h8a4 4 0 0 1 4 4v2"
          stroke="#000000"
          strokeWidth={active ? 2.5 : 2}
          strokeLinecap="round"
        />
      </Svg>
    ),
  },
];

const HIDDEN_ON = [
  '/chat/',
  '/post/',
  '/profile/',
  '/new-post',
  '/create',
  '/settings',
  '/notifications',
  '/edit-profile',
  '/preferences',
  '/blocked',
  '/change-password',
];

function isTabActive(pathname: string, match: string): boolean {
  const cleanPath = pathname.split('?')[0].replace(/^\/\(app\)/, '') || '/';
  if (match === '/(app)' || match === '/') {
    return cleanPath === '/' || cleanPath === '/index';
  }
  const cleanMatch = match.replace(/^\/\(app\)/, '').replace(/^\//, '');
  const segments = cleanPath.split('/').filter(Boolean);
  return segments[0] === cleanMatch;
}

export function TeaTabBar() {
  const insets = useSafeAreaInsets();
  let pathname = '/(app)';
  try {
    pathname = usePathname();
  } catch {
    // router not mounted yet
  }

  if (HIDDEN_ON.some((p) => pathname.includes(p))) {
    return null;
  }

  const bottomInset = insets.bottom > 0 ? insets.bottom : 8;

  return (
    <View
      style={{
        backgroundColor: '#ECE6C2',
        borderTopWidth: 2.5,
        borderTopColor: '#000000',
        paddingBottom: bottomInset,
        // Neo-brutalist top shadow
        shadowColor: '#000000',
        shadowOffset: { width: 0, height: -2 },
        shadowOpacity: 0.15,
        shadowRadius: 0,
        elevation: 8,
      }}>
      <View
        style={{
          height: 56,
          flexDirection: 'row',
          alignItems: 'center',
          justifyContent: 'space-around',
          paddingHorizontal: 8,
        }}>
        {TABS.map(({ href, match, label, icon }) => {
          const active = isTabActive(pathname, match);
          return (
            <Pressable
              key={match}
              onPress={() => router.replace(href)}
              android_ripple={{ color: 'transparent' }}
              style={{
                flex: 1,
                alignItems: 'center',
                justifyContent: 'center',
                paddingVertical: 4,
              }}>
              <View
                style={{
                  alignItems: 'center',
                  justifyContent: 'center',
                  paddingHorizontal: 10,
                  paddingVertical: 3,
                  borderRadius: 6,
                  borderWidth: active ? 1.5 : 0,
                  borderColor: '#000000',
                  backgroundColor: active ? '#FFFFFF' : 'transparent',
                  shadowColor: '#000000',
                  shadowOffset: active ? { width: -1, height: 2 } : { width: 0, height: 0 },
                  shadowOpacity: active ? 1 : 0,
                  shadowRadius: 0,
                }}>
                {icon(active)}
                <Text
                  style={{
                    fontSize: 10,
                    fontWeight: active ? '800' : '600',
                    color: '#000000',
                    marginTop: 2,
                    fontFamily: active ? 'HankenGrotesk-Bold' : 'HankenGrotesk-Medium',
                  }}>
                  {label}
                </Text>
              </View>
            </Pressable>
          );
        })}
      </View>
    </View>
  );
}
