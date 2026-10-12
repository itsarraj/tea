import React, { useEffect, useState } from 'react';
import { ActivityIndicator, Pressable, StatusBar, Text, View } from 'react-native';
import { router, useLocalSearchParams } from 'expo-router';
import { useSafeAreaInsets } from 'react-native-safe-area-context';

import { authApi } from '@/services/authApi';
import { BrutalButton, BrutalCard } from '@/components/tea/ui';

export default function VerifyEmailScreen() {
  const { token } = useLocalSearchParams<{ token: string }>();
  const insets = useSafeAreaInsets();
  const [state, setState] = useState<{ status: 'pending' | 'ok' | 'error'; message: string }>({
    status: 'pending',
    message: 'Verifying your email…',
  });

  useEffect(() => {
    if (!token) {
      setState({ status: 'error', message: 'Missing or expired verification token.' });
      return;
    }
    authApi
      .verifyEmail(String(token))
      .then(() =>
        setState({
          status: 'ok',
          message: 'Your email has been verified! You can now sign in to Tea.',
        }),
      )
      .catch((e) =>
        setState({
          status: 'error',
          message: e instanceof Error ? e.message : 'Verification failed.',
        }),
      );
  }, [token]);

  return (
    <View
      className="flex-1 items-center justify-center bg-[#ece6c2] px-6"
      style={{ paddingTop: insets.top, paddingBottom: insets.bottom }}>
      <StatusBar barStyle="dark-content" backgroundColor="#ece6c2" />

      <BrutalCard variant="white" className="w-full max-w-[340px] items-center p-6">
        <View className="mb-4 w-14 h-14 rounded-[3px] bg-[#ece6c2] border-2 border-black items-center justify-center">
          {state.status === 'pending' ? (
            <ActivityIndicator color="#020202" />
          ) : (
            <Text className="text-2xl">{state.status === 'ok' ? '☕' : '⚠️'}</Text>
          )}
        </View>

        <Text className="text-xl font-black text-black text-center mb-2">
          {state.status === 'pending'
            ? 'Verifying Email'
            : state.status === 'ok'
            ? 'Email Verified'
            : 'Verification Failed'}
        </Text>

        <Text className="text-xs font-semibold text-[#444] text-center mb-6 leading-relaxed">
          {state.message}
        </Text>

        <View className="w-full">
          <BrutalButton
            label="Go to Sign In"
            variant="mint"
            onPress={() => router.replace('/login')}
            size="md"
          />
        </View>
      </BrutalCard>
    </View>
  );
}
