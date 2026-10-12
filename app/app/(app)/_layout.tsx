import { useEffect } from 'react';
import { router, Tabs } from 'expo-router';
import { ActivityIndicator, View } from 'react-native';

import { TeaTabBar } from '@/components/tea/TeaTabBar';
import { brand } from '@/constants/brand';
import { useSession } from '@/hooks/useAuth';
import { useProfile } from '@/hooks/useDating';
import { usePushRegistration } from '@/hooks/usePushRegistration';

import { useAppSettings } from '@/hooks/useAppSettings';

export default function AppLayout() {
  const session = useSession();
  const hasToken = Boolean(session.data?.hasToken);
  const profile = useProfile(hasToken);
  const { settings } = useAppSettings();
  usePushRegistration(hasToken && profile.data?.onboarding_complete === true && settings.pushEnabled);

  useEffect(() => {
    if (session.isLoading || (hasToken && profile.isLoading)) return;
    if (!hasToken) {
      router.replace('/welcome');
    } else if (profile.data && !profile.data.onboarding_complete) {
      router.replace('/onboarding');
    }
  }, [session.isLoading, hasToken, profile.isLoading, profile.data?.onboarding_complete]);

  if (
    session.isLoading ||
    (hasToken && profile.isLoading) ||
    !hasToken ||
    (profile.data && !profile.data.onboarding_complete)
  ) {
    return (
      <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center', backgroundColor: brand.canvas }}>
        <ActivityIndicator color="#020202" size="large" />
      </View>
    );
  }

  return (
    <Tabs
      backBehavior="history"
      tabBar={() => <TeaTabBar />}
      screenOptions={{
        headerShown: false,
        sceneStyle: { backgroundColor: brand.canvas },
      }}>
      <Tabs.Screen name="index" options={{ title: 'Feed' }} />
      <Tabs.Screen name="search" options={{ title: 'Search' }} />
      <Tabs.Screen name="advisors" options={{ title: 'Advisors' }} />
      <Tabs.Screen name="messages" options={{ title: 'Messages' }} />
      <Tabs.Screen name="me" options={{ title: 'Profile' }} />

      {/* Hidden / Modal routes */}
      <Tabs.Screen name="notifications" options={{ href: null }} />
      <Tabs.Screen name="create" options={{ href: null }} />
      <Tabs.Screen name="settings" options={{ href: null }} />
      <Tabs.Screen name="edit-profile" options={{ href: null }} />
      <Tabs.Screen name="preferences" options={{ href: null }} />
      <Tabs.Screen name="blocked" options={{ href: null }} />
      <Tabs.Screen name="new-post" options={{ href: null }} />
      <Tabs.Screen name="change-password" options={{ href: null }} />
      <Tabs.Screen name="profile/[id]" options={{ href: null }} />
      <Tabs.Screen name="chat/[id]" options={{ href: null }} />
      <Tabs.Screen name="post/[id]" options={{ href: null }} />
    </Tabs>
  );
}
