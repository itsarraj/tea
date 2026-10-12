import Constants from 'expo-constants';
import { makeRedirectUri } from 'expo-auth-session';
import * as WebBrowser from 'expo-web-browser';

import { apiUrl } from '@/constants/config';
import type { AuthTokens, UserPublic } from '@/services/authApi';

WebBrowser.maybeCompleteAuthSession();

function googleCallbackRedirectUri(): string {
  const scheme = Constants.expoConfig?.scheme;
  const activeScheme =
    typeof scheme === 'string'
      ? scheme
      : Array.isArray(scheme) && scheme[0]
        ? scheme[0]
        : 'tea';

  return makeRedirectUri({
    scheme: activeScheme,
    path: 'auth/google/callback',
  });
}

export function parseAuthResultUrl(resultUrl: string): AuthTokens | { error: string } {
  let url: URL;
  try {
    url = new URL(resultUrl);
  } catch {
    return { error: 'Invalid Google sign-in response' };
  }

  const params = new URLSearchParams(
    url.hash.startsWith('#') ? url.hash.slice(1) : url.search.slice(1),
  );

  const error = params.get('error');
  if (error) {
    return { error: decodeURIComponent(error) };
  }

  const access_token = params.get('access_token');
  const refresh_token = params.get('refresh_token');
  const expires_in = params.get('expires_in');
  const userRaw = params.get('user');

  if (!access_token || !refresh_token || !userRaw) {
    return { error: 'Invalid Google sign-in response' };
  }

  try {
    const user = JSON.parse(userRaw) as UserPublic;
    return {
      access_token,
      refresh_token,
      expires_in: Number(expires_in || 0),
      user,
    };
  } catch {
    return { error: 'Invalid Google sign-in response' };
  }
}

export async function signInWithGoogle(): Promise<AuthTokens> {
  const redirectTo = googleCallbackRedirectUri();
  const authUrl = `${apiUrl('/auth/google')}?redirect_to=${encodeURIComponent(redirectTo)}`;

  const result = await WebBrowser.openAuthSessionAsync(authUrl, redirectTo);

  if (result.type !== 'success' || !result.url) {
    throw new Error('Google sign-in was cancelled');
  }

  const parsed = parseAuthResultUrl(result.url);
  if ('error' in parsed) {
    throw new Error(parsed.error);
  }

  return parsed;
}
