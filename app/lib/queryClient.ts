import { QueryClient } from '@tanstack/react-query';

/**
 * Perf baseline:
 * - Auth/me queries: no window-focus refetch spam
 * - Short retry for flaky mobile networks
 * - Tokens never live in the query cache — only SecureStore
 */
export const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      staleTime: 60_000,
      gcTime: 5 * 60_000,
      retry: 1,
      refetchOnWindowFocus: false,
      refetchOnReconnect: true,
    },
    mutations: {
      retry: 0,
    },
  },
});

export const queryKeys = {
  me: ['me'] as const,
  session: ['session'] as const,
};
