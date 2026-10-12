import { useEffect } from 'react';
import { ActivityIndicator, Text, View } from 'react-native';
import { router } from 'expo-router';

import { useLogout, useSession } from '@/hooks/useAuth';
import { useProfile } from '@/hooks/useDating';
import { BrutalButton } from '@/components/tea/ui';

export default function Index() {
  const session = useSession();
  const hasToken = Boolean(session.data?.hasToken);
  const profile = useProfile(hasToken);
  const logout = useLogout();

  useEffect(() => {
    if (session.isLoading) return;
    if (!hasToken) {
      router.replace('/welcome');
      return;
    }
    if (profile.isLoading) return;
    if (profile.isError) {
      const msg = profile.error instanceof Error ? profile.error.message.toLowerCase() : '';
      if (
        msg.includes('401') ||
        msg.includes('unauthorized') ||
        msg.includes('log in') ||
        msg.includes('token') ||
        msg.includes('session expired')
      ) {
        logout.mutateAsync().finally(() => {
          router.replace('/welcome');
        });
      }
      return;
    }

    if (profile.data?.onboarding_complete) {
      router.replace('/(app)');
    } else {
      router.replace('/onboarding');
    }
  }, [session.isLoading, hasToken, profile.isLoading, profile.isError, profile.data?.onboarding_complete]);

  if (hasToken && profile.isError) {
    return (
      <View className="flex-1 items-center justify-center bg-[#ece6c2] px-6">
        <Text className="text-xl font-black text-black mb-2">Connection Issue</Text>
        <Text className="text-xs font-bold text-[#555] text-center mb-6">
          {profile.error instanceof Error ? profile.error.message : 'Unable to connect to your dating advisor profile.'}
        </Text>
        <View className="flex-row gap-3">
          <BrutalButton label="Retry" onPress={() => profile.refetch()} variant="mint" />
          <BrutalButton
            label="Sign Out"
            onPress={async () => {
              try {
                await logout.mutateAsync();
              } catch {}
              router.replace('/welcome');
            }}
            variant="white"
          />
        </View>
      </View>
    );
  }

  return (
    <View className="flex-1 items-center justify-center bg-[#ece6c2]">
      <ActivityIndicator color="#020202" />
    </View>
  );
}
