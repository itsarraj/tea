import { useEffect, useRef } from 'react';
import { Platform } from 'react-native';
import { router } from 'expo-router';

import { getPushToken, onNotificationOpened } from '@/lib/native';
import { datingApi } from '@/services/datingApi';

/**
 * Registers the Expo push token once per app session and deep-links taps on
 * "new match" / "new message" notifications.
 */
export function usePushRegistration(enabled: boolean) {
  const done = useRef(false);

  useEffect(() => {
    if (!enabled || done.current) return;
    done.current = true;
    (async () => {
      const token = await getPushToken();
      if (!token) return;
      await datingApi.registerDevice(token, Platform.OS);
    })().catch((e) => {
      if (__DEV__) console.warn('[push] registration failed', e);
    });
  }, [enabled]);

  useEffect(() => {
    if (!enabled) return;
    return onNotificationOpened((data) => {
      const type = data.type as string | undefined;
      const conversationId = data.conversationId as string | undefined;
      if (type === 'message' && conversationId) router.push(`/(app)/chat/${conversationId}`);
      else if (type === 'match') router.push('/(app)/messages');
    });
  }, [enabled]);
}
