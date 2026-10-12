import '@/lib/font-patch';
import '../global.css';

import { QueryClientProvider } from '@tanstack/react-query';
import { Stack } from 'expo-router';
import * as SplashScreen from 'expo-splash-screen';
import { StatusBar } from 'expo-status-bar';
import { useEffect } from 'react';
import { View } from 'react-native';
import { GestureHandlerRootView } from 'react-native-gesture-handler';
import { useFonts } from 'expo-font';

import { KeyboardProvider } from 'react-native-keyboard-controller';

import { brand } from '@/constants/brand';
import { queryClient } from '@/lib/queryClient';
import { useSession } from '@/hooks/useAuth';
import { OfflineBanner } from '@/components/tea/OfflineBanner';

SplashScreen.preventAutoHideAsync().catch(() => undefined);

function Bootstrap({ children }: { children: React.ReactNode }) {
  const session = useSession();
  const [fontsLoaded, fontError] = useFonts({
    'HankenGrotesk': require('@/assets/fonts/HankenGrotesk-Regular.ttf'),
    'HankenGrotesk-Regular': require('@/assets/fonts/HankenGrotesk-Regular.ttf'),
    'HankenGrotesk-Light': require('@/assets/fonts/HankenGrotesk-Light.ttf'),
    'HankenGrotesk-Medium': require('@/assets/fonts/HankenGrotesk-Medium.ttf'),
    'HankenGrotesk-SemiBold': require('@/assets/fonts/HankenGrotesk-SemiBold.ttf'),
    'HankenGrotesk-Bold': require('@/assets/fonts/HankenGrotesk-Bold.ttf'),
    'HankenGrotesk-ExtraBold': require('@/assets/fonts/HankenGrotesk-ExtraBold.ttf'),
    'HankenGrotesk-Thin': require('@/assets/fonts/HankenGrotesk-Thin.ttf'),
    'HankenGrotesk-Black': require('@/assets/fonts/HankenGrotesk-Black.ttf'),
  });

  useEffect(() => {
    if (!session.isLoading && (fontsLoaded || fontError)) {
      SplashScreen.hideAsync().catch(() => undefined);
    }
  }, [session.isLoading, fontsLoaded, fontError]);

  if (session.isLoading || (!fontsLoaded && !fontError)) {
    return null;
  }

  return <>{children}</>;
}

export default function RootLayout() {
  return (
    <GestureHandlerRootView style={{ flex: 1 }}>
      <KeyboardProvider>
        <QueryClientProvider client={queryClient}>
          <Bootstrap>
            <View className="flex-1 bg-[#ece6c2]">
              <StatusBar style="dark" />
              <OfflineBanner />
              <Stack screenOptions={{ headerShown: false, contentStyle: { backgroundColor: brand.canvas } }} />
            </View>
          </Bootstrap>
        </QueryClientProvider>
      </KeyboardProvider>
    </GestureHandlerRootView>
  );
}

