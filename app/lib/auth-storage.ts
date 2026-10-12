import * as SecureStore from 'expo-secure-store';

const ACCESS = 'tea_access';
const REFRESH = 'tea_refresh';
const REMEMBER_EMAIL = 'tea_remember_email';

export async function getAccessToken(): Promise<string | null> {
  try {
    return await SecureStore.getItemAsync(ACCESS);
  } catch {
    return null;
  }
}

export async function getRefreshToken(): Promise<string | null> {
  try {
    return await SecureStore.getItemAsync(REFRESH);
  } catch {
    return null;
  }
}

export async function saveTokens(access: string, refresh: string): Promise<void> {
  try {
    await SecureStore.setItemAsync(ACCESS, access);
    await SecureStore.setItemAsync(REFRESH, refresh);
  } catch {
    /* SecureStore missing in this binary — session memory-only until rebuild */
  }
}

export async function clearTokens(): Promise<void> {
  try {
    await SecureStore.deleteItemAsync(ACCESS);
    await SecureStore.deleteItemAsync(REFRESH);
  } catch {
    /* ignore */
  }
}

export async function getRememberedEmail(): Promise<string | null> {
  try {
    return await SecureStore.getItemAsync(REMEMBER_EMAIL);
  } catch {
    return null;
  }
}

export async function setRememberedEmail(email: string | null): Promise<void> {
  try {
    if (email) {
      await SecureStore.setItemAsync(REMEMBER_EMAIL, email);
    } else {
      await SecureStore.deleteItemAsync(REMEMBER_EMAIL);
    }
  } catch {
    /* ignore */
  }
}
