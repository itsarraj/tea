import Constants from 'expo-constants';
import { Platform } from 'react-native';

const LOCAL_DEV_API_BASE = 'http://localhost:8000';
const PROD_API_BASE = 'https://tea.kraftisium.xyz';

function useLocalBff(): boolean {
  return process.env.EXPO_PUBLIC_USE_LOCAL_BFF === '1';
}

function rewriteLocalhostForDevice(url: string): string {
  if (process.env.EXPO_PUBLIC_DEV_TRANSPORT === 'adb') return url;
  if (Platform.OS === 'android' && __DEV__) {
    try {
      const u = new URL(url);
      if (u.hostname === 'localhost' || u.hostname === '127.0.0.1') {
        u.hostname = process.env.EXPO_PUBLIC_ANDROID_EMULATOR_HOST?.trim() || '10.0.2.2';
        return u.href.replace(/\/$/, '');
      }
    } catch {
      /* ignore */
    }
  }
  return url.replace(/\/$/, '');
}

function resolveRawBffUrl(): string {
  if (__DEV__ && useLocalBff()) {
    return rewriteLocalhostForDevice(LOCAL_DEV_API_BASE);
  }

  const fromEnv = process.env.EXPO_PUBLIC_BFF_API_URL?.trim();
  if (fromEnv) return rewriteLocalhostForDevice(fromEnv.replace(/\/$/, ''));

  const fromExtra = (Constants.expoConfig?.extra as { bffApiUrl?: string } | undefined)?.bffApiUrl;
  if (typeof fromExtra === 'string' && fromExtra.trim()) {
    return rewriteLocalhostForDevice(fromExtra.trim().replace(/\/$/, ''));
  }

  return PROD_API_BASE;
}

export const BFF_API_URL = resolveRawBffUrl();
export const BFF_API_VERSION = process.env.EXPO_PUBLIC_BFF_API_VERSION ?? 'v1';

export function apiUrl(endpoint: string): string {
  const base = BFF_API_URL.replace(/\/$/, '');
  const path = endpoint.startsWith('/') ? endpoint : `/${endpoint}`;
  return `${base}/api/${BFF_API_VERSION}${path}`;
}

export function mediaUrl(url?: string | null): string | null {
  if (!url) return null;
  if (url.startsWith('file://') || url.startsWith('content://') || url.startsWith('data:')) {
    return url;
  }
  if (url.startsWith('http://') || url.startsWith('https://')) {
    return rewriteLocalhostForDevice(url);
  }
  const base = BFF_API_URL.replace(/\/$/, '');
  const path = url.startsWith('/') ? url : `/${url}`;
  return `${base}${path}`;
}

if (__DEV__) {
  console.log('[Tea] BFF_API_URL =', BFF_API_URL);
}
