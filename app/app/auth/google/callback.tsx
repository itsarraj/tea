import { useEffect, useState } from 'react';
import { ActivityIndicator, Text, View } from 'react-native';
import { router, useLocalSearchParams } from 'expo-router';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { useQueryClient } from '@tanstack/react-query';

import { saveTokens } from '@/lib/auth-storage';
import { parseAuthResultUrl } from '@/lib/google-auth';
import { queryKeys } from '@/lib/queryClient';

/**
 * Deep-link landing for `tea://auth/google/callback?...`.
 * WebBrowser.openAuthSessionAsync usually completes before this mounts;
 * this screen is a fallback if the OS opens the link into the app.
 */
export default function GoogleCallbackScreen() {
  const insets = useSafeAreaInsets();
  const params = useLocalSearchParams();
  const qc = useQueryClient();
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    let cancelled = false;
    (async () => {
      const qs = new URLSearchParams();
      for (const [k, v] of Object.entries(params)) {
        if (typeof v === 'string') qs.set(k, v);
        else if (Array.isArray(v) && v[0]) qs.set(k, v[0]);
      }
      const fakeUrl = `tea://auth/google/callback?${qs.toString()}`;
      const parsed = parseAuthResultUrl(fakeUrl);
      if ('error' in parsed) {
        if (!cancelled) setError(parsed.error);
        return;
      }
      await saveTokens(parsed.access_token, parsed.refresh_token);
      qc.setQueryData(queryKeys.session, { hasToken: true });
      qc.setQueryData(queryKeys.me, parsed.user);
      if (!cancelled) router.replace('/(app)');
    })().catch((e) => {
      if (!cancelled) setError(e instanceof Error ? e.message : 'Google sign-in failed');
    });
    return () => {
      cancelled = true;
    };
  }, [params, qc]);

  return (
    <View
      className="flex-1 items-center justify-center bg-[#ece6c2] px-6"
      style={{ paddingTop: insets.top }}>
      {error ? (
        <Text className="text-center text-sm font-bold text-tea-red">{error}</Text>
      ) : (
        <>
          <ActivityIndicator color="#020202" size="large" />
          <Text className="mt-4 text-sm font-bold text-black">Finishing Google sign-in…</Text>
        </>
      )}
    </View>
  );
}
