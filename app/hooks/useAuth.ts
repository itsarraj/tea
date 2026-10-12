import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';

import { getAccessToken, saveTokens } from '@/lib/auth-storage';
import { signInWithGoogle } from '@/lib/google-auth';
import { queryKeys } from '@/lib/queryClient';
import { authApi, type AuthTokens, type UserPublic } from '@/services/authApi';

export function useSession() {
  return useQuery({
    queryKey: queryKeys.session,
    queryFn: async () => {
      const access = await getAccessToken();
      return { hasToken: Boolean(access) };
    },
    staleTime: Infinity,
  });
}

export function useMe(enabled: boolean) {
  return useQuery({
    queryKey: queryKeys.me,
    queryFn: () => authApi.me(),
    enabled,
    staleTime: 60_000,
  });
}

async function persistAuth(data: AuthTokens, qc: ReturnType<typeof useQueryClient>) {
  await saveTokens(data.access_token, data.refresh_token);
  qc.setQueryData(queryKeys.session, { hasToken: true });
  qc.setQueryData(queryKeys.me, data.user);
  qc.invalidateQueries({ queryKey: ['dating'] });
}

export function useLogin() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: (body: { email: string; password: string }) => authApi.login(body),
    onSuccess: (data) => persistAuth(data, qc),
  });
}

export function useRegister() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: (body: {
      name: string;
      email: string;
      password: string;
      birthday?: string;
      phone?: string;
    }) => authApi.register(body),
    onSuccess: (data) => persistAuth(data, qc),
  });
}

export function useGoogleLogin() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: () => signInWithGoogle(),
    onSuccess: (data) => persistAuth(data, qc),
  });
}

export function useLogout() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: () => authApi.logout(),
    onSuccess: () => {
      qc.setQueryData(queryKeys.session, { hasToken: false });
      qc.removeQueries({ queryKey: queryKeys.me });
      qc.removeQueries({ queryKey: ['dating'] });
    },
  });
}

export function usePasswordReset() {
  return useMutation({
    mutationFn: (email: string) => authApi.passwordReset(email),
  });
}

export function useChangePassword() {
  return useMutation({
    mutationFn: (body: { current_password: string; new_password: string }) =>
      authApi.changePassword(body.current_password, body.new_password),
  });
}

export type { UserPublic };
