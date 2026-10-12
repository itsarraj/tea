import { BFF_API_URL, BFF_API_VERSION } from '@/constants/config';
import { clearTokens, getAccessToken, getRefreshToken, saveTokens } from '@/lib/auth-storage';
import { queryClient, queryKeys } from '@/lib/queryClient';

function baseUrl(): string {
  const root = BFF_API_URL.replace(/\/$/, '');
  return `${root}/api/${BFF_API_VERSION}`;
}

const DEFAULT_TIMEOUT_MS = 10_000;

async function fetchWithTimeout(
  url: string,
  init?: RequestInit,
  timeoutMs = DEFAULT_TIMEOUT_MS,
): Promise<Response> {
  const controller = new AbortController();
  const timer = setTimeout(() => {
    controller.abort(new Error('Network request timed out'));
  }, timeoutMs);

  try {
    const res = await fetch(url, {
      ...init,
      signal: init?.signal ?? controller.signal,
    });
    return res;
  } finally {
    clearTimeout(timer);
  }
}

export type ApiError = { error?: string; message?: string };

export type UserPublic = {
  id: string;
  email: string;
  name: string;
  email_verified: boolean;
  created_at: string;
};

export type AuthTokens = {
  access_token: string;
  refresh_token: string;
  expires_in: number;
  user: UserPublic;
};

/** Concurrent 401 refresh latch queue */
let isRefreshing = false;
let failedQueue: Array<{
  resolve: (token: string) => void;
  reject: (error: unknown) => void;
}> = [];

function processQueue(error: unknown, token: string | null = null) {
  failedQueue.forEach((prom) => {
    if (error || !token) prom.reject(error);
    else prom.resolve(token);
  });
  failedQueue = [];
}

async function parseJson<T>(res: Response): Promise<T> {
  const text = await res.text();
  if (!text) return {} as T;
  try {
    return JSON.parse(text) as T;
  } catch {
    throw new Error(text || `HTTP ${res.status}`);
  }
}

export async function apiRequest<T>(
  path: string,
  init?: RequestInit & { skipAuth?: boolean; _retried?: boolean },
): Promise<T> {
  const headers: Record<string, string> = {
    ...(init?.headers as Record<string, string> | undefined),
  };
  if (!(init?.body instanceof FormData)) headers['Content-Type'] = 'application/json';

  if (!init?.skipAuth) {
    // 1. If refresh is actively in flight, park this request in the failedQueue
    if (isRefreshing && !init?._retried) {
      try {
        const freshToken = await new Promise<string>((resolve, reject) => {
          failedQueue.push({ resolve, reject });
        });
        headers.Authorization = `Bearer ${freshToken}`;
        return apiRequest<T>(path, { ...init, headers, _retried: true });
      } catch (err) {
        throw err;
      }
    }

    const token = await getAccessToken();
    if (!token) {
      queryClient.setQueryData(queryKeys.session, { hasToken: false });
      throw new Error('Please log in.');
    }
    headers.Authorization = `Bearer ${token}`;
  }

  const res = await fetchWithTimeout(`${baseUrl()}${path.startsWith('/') ? path : `/${path}`}`, {
    ...init,
    headers,
  });

  // 2. Intercept 401 Unauthorized
  if (res.status === 401 && !init?.skipAuth && !init?._retried) {
    if (isRefreshing) {
      // Another request already triggered refresh, wait in queue
      try {
        const freshToken = await new Promise<string>((resolve, reject) => {
          failedQueue.push({ resolve, reject });
        });
        headers.Authorization = `Bearer ${freshToken}`;
        return apiRequest<T>(path, { ...init, headers, _retried: true });
      } catch (err) {
        throw err;
      }
    }

    isRefreshing = true;
    try {
      const refreshToken = await getRefreshToken();
      if (!refreshToken) {
        throw new Error('No refresh token available');
      }

      const refreshRes = await fetchWithTimeout(`${baseUrl()}/auth/refresh`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ refresh_token: refreshToken }),
      });

      if (!refreshRes.ok) {
        throw new Error(`Refresh failed with HTTP ${refreshRes.status}`);
      }

      const data = (await refreshRes.json()) as AuthTokens;
      await saveTokens(data.access_token, data.refresh_token);
      queryClient.setQueryData(queryKeys.session, { hasToken: true });

      processQueue(null, data.access_token);

      headers.Authorization = `Bearer ${data.access_token}`;
      return apiRequest<T>(path, { ...init, headers, _retried: true });
    } catch (refreshErr) {
      processQueue(refreshErr, null);
      await clearTokens();
      queryClient.setQueryData(queryKeys.session, { hasToken: false });
      queryClient.removeQueries({ queryKey: queryKeys.me });
      throw refreshErr;
    } finally {
      isRefreshing = false;
    }
  }

  if (!res.ok) {
    const body = await parseJson<ApiError>(res).catch(
      (): ApiError => ({ error: `HTTP ${res.status}` }),
    );
    throw new Error(body.message || body.error || `HTTP ${res.status}`);
  }
  return parseJson<T>(res);
}

export const authApi = {
  register: (body: {
    name: string;
    email: string;
    password: string;
    birthday?: string;
    phone?: string;
  }) =>
    apiRequest<AuthTokens>('/auth/register', {
      method: 'POST',
      body: JSON.stringify(body),
      skipAuth: true,
    }),
  login: (body: { email: string; password: string }) =>
    apiRequest<AuthTokens>('/auth/login', {
      method: 'POST',
      body: JSON.stringify(body),
      skipAuth: true,
    }),
  refresh: (refresh_token: string) =>
    apiRequest<AuthTokens>('/auth/refresh', {
      method: 'POST',
      body: JSON.stringify({ refresh_token }),
      skipAuth: true,
    }),
  logout: async () => {
    const refresh = await getRefreshToken();
    try {
      await apiRequest('/auth/logout', {
        method: 'POST',
        body: JSON.stringify({ refresh_token: refresh }),
      });
    } catch {
      /* still clear local */
    }
    await clearTokens();
  },
  me: () => apiRequest<UserPublic>('/user/me'),
  passwordReset: (email: string) =>
    apiRequest<{ ok: boolean }>('/auth/password-reset', {
      method: 'POST',
      body: JSON.stringify({ email }),
      skipAuth: true,
    }),
  passwordResetConfirm: (token: string, new_password: string) =>
    apiRequest<{ ok: boolean }>('/auth/password-reset/confirm', {
      method: 'POST',
      body: JSON.stringify({ token, new_password }),
      skipAuth: true,
    }),
  verifyEmail: (token: string) =>
    apiRequest<{ ok: boolean }>(`/auth/verify-email/${encodeURIComponent(token)}`, {
      skipAuth: true,
    }),
  google: (id_token: string) =>
    apiRequest<AuthTokens>('/auth/google', {
      method: 'POST',
      body: JSON.stringify({ id_token }),
      skipAuth: true,
    }),
  phoneStart: (phone: string) =>
    apiRequest<{ ok: boolean; message?: string }>('/auth/phone/start', {
      method: 'POST',
      body: JSON.stringify({ phone }),
      skipAuth: true,
    }),
  phoneVerify: (phone: string, code: string) =>
    apiRequest<AuthTokens>('/auth/phone/verify', {
      method: 'POST',
      body: JSON.stringify({ phone, code }),
      skipAuth: true,
    }),
  changePassword: (current_password: string, new_password: string) =>
    apiRequest<{ ok: boolean }>('/user/change-password', {
      method: 'POST',
      body: JSON.stringify({ current_password, new_password }),
    }),
};
