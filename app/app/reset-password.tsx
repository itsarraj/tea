import React, { useEffect, useState } from 'react';
import {
  Pressable,
  StatusBar,
  Text,
  TextInput,
  View,
} from 'react-native';
import { Link, router, useLocalSearchParams } from 'expo-router';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { useMutation } from '@tanstack/react-query';
import { KeyboardAwareScrollView } from 'react-native-keyboard-controller';
import { Feather, Ionicons } from '@expo/vector-icons';

import { BrutalButton, BrutalCard } from '@/components/tea/ui';
import { usePasswordReset, useSession } from '@/hooks/useAuth';
import { authApi } from '@/services/authApi';

/**
 * Two modes on one route:
 *   /reset-password                 request a link (email form)
 *   /reset-password?token=…         choose a new password (deep link from email or pasted code)
 * Also reachable while signed in from Settings → Reset password.
 */
export default function ResetPasswordScreen() {
  const insets = useSafeAreaInsets();
  const params = useLocalSearchParams<{ token?: string; email?: string }>();
  const session = useSession();
  const reset = usePasswordReset();
  const [email, setEmail] = useState(params.email ?? '');

  const [token, setToken] = useState(params.token ?? '');
  const [password, setPassword] = useState('');
  const [confirmPw, setConfirmPw] = useState('');
  const [mode, setMode] = useState<'request' | 'confirm'>(
    params.token || params.email ? 'confirm' : 'request',
  );
  const [msg, setMsg] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (params.token) {
      setToken(params.token);
      setMode('confirm');
    }
  }, [params.token]);

  const confirm = useMutation({
    mutationFn: () => authApi.passwordResetConfirm(extractToken(token), password),
  });

  const onRequest = async () => {
    setError(null);
    setMsg(null);
    try {
      await reset.mutateAsync(email.trim());
      setMsg('If that email exists, a reset code was sent. Check your inbox or paste it below.');
      setMode('confirm');
    } catch (e) {
      setError(e instanceof Error ? e.message : 'Request failed');
    }
  };

  const onConfirm = async () => {
    setError(null);
    setMsg(null);
    if (!extractToken(token)) return setError('Paste the reset code from the email');
    if (password.length < 8) return setError('Use at least 8 characters');
    if (password !== confirmPw) return setError('Passwords don’t match');
    try {
      await confirm.mutateAsync();
      setMsg('Password updated successfully! Redirecting...');
      setTimeout(() => {
        if (session.data?.hasToken) router.replace('/(app)/settings');
        else router.replace('/login');
      }, 900);
    } catch (e) {
      setError(e instanceof Error ? e.message : 'Reset failed — the link or code may have expired');
    }
  };

  const busy = reset.isPending || confirm.isPending;

  return (
    <View className="flex-1 bg-[#ece6c2]" style={{ paddingTop: insets.top }}>
      <StatusBar barStyle="dark-content" backgroundColor="#ece6c2" />

      {/* Screen Header */}
      <View className="flex-row items-center justify-between px-5 py-3 border-b-2 border-black bg-[#ece6c2]">
        <Pressable
          onPress={() =>
            router.canGoBack()
              ? router.back()
              : router.replace(session.data?.hasToken ? '/(app)/settings' : '/login')
          }
          className="w-10 h-10 rounded-[2px] bg-white border-2 border-black items-center justify-center active:translate-y-0.5"
          style={{
            shadowColor: '#000',
            shadowOffset: { width: -2, height: 2 },
            shadowOpacity: 1,
            shadowRadius: 0,
            elevation: 3,
          }}>
          <Feather name="arrow-left" size={20} color="#000" />
        </Pressable>

        <Text className="text-xl font-black text-black">
          {mode === 'request' ? 'Reset Password' : 'New Password'}
        </Text>

        <View className="w-10" />
      </View>

      <KeyboardAwareScrollView
        contentContainerStyle={{
          padding: 20,
          paddingBottom: insets.bottom + 32,
        }}
        bottomOffset={24}
        keyboardShouldPersistTaps="handled"
        showsVerticalScrollIndicator={false}>
        {mode === 'request' ? (
          <>
            <View className="mb-6">
              <Text className="text-3xl font-black text-black tracking-tight">Forgot password?</Text>
              <Text className="text-xs font-semibold text-[#555] mt-1">
                Enter your email address and we’ll send you a password recovery code.
              </Text>
            </View>

            <BrutalCard variant="white" className="p-4 mb-6">
              <Text className="text-xs font-black uppercase text-black mb-1.5">Email Address</Text>
              <TextInput
                autoCapitalize="none"
                keyboardType="email-address"
                value={email}
                onChangeText={setEmail}
                placeholder="yourname@domain.com"
                placeholderTextColor="#888"
                className="h-12 bg-[#faf8ed] border-2 border-black px-3 font-bold text-sm text-black rounded-[2px]"
              />

              <Feedback error={error} msg={msg} />

              <View className="mt-5">
                <BrutalButton
                  label={busy ? 'Sending code…' : 'Send Reset Code'}
                  variant="mint"
                  onPress={onRequest}
                  disabled={!email.trim() || busy}
                />
              </View>

              <Pressable onPress={() => setMode('confirm')} className="mt-4 items-center">
                <Text className="text-xs font-black text-black underline">
                  I already have a reset code
                </Text>
              </Pressable>
            </BrutalCard>
          </>
        ) : (
          <>
            <View className="mb-6">
              <Text className="text-3xl font-black text-black tracking-tight">Set New Password</Text>
              <Text className="text-xs font-semibold text-[#555] mt-1">
                {email ? `A reset code was sent to ${email}. ` : ''}
                Paste your reset code below and create your new secure password.
              </Text>
            </View>

            <BrutalCard variant="white" className="p-4 mb-6">
              <Text className="text-xs font-black uppercase text-black mb-1.5">Reset Code</Text>
              <TextInput
                autoCapitalize="none"
                autoCorrect={false}
                value={token}
                onChangeText={setToken}
                placeholder="Paste code or link"
                placeholderTextColor="#888"
                className="h-12 bg-[#faf8ed] border-2 border-black px-3 font-bold text-sm text-black rounded-[2px] mb-4"
              />

              <Text className="text-xs font-black uppercase text-black mb-1.5">New Password</Text>
              <TextInput
                secureTextEntry
                value={password}
                onChangeText={setPassword}
                placeholder="At least 8 characters"
                placeholderTextColor="#888"
                className="h-12 bg-[#faf8ed] border-2 border-black px-3 font-bold text-sm text-black rounded-[2px] mb-4"
              />

              <Text className="text-xs font-black uppercase text-black mb-1.5">Confirm Password</Text>
              <TextInput
                secureTextEntry
                value={confirmPw}
                onChangeText={setConfirmPw}
                placeholder="Repeat new password"
                placeholderTextColor="#888"
                className="h-12 bg-[#faf8ed] border-2 border-black px-3 font-bold text-sm text-black rounded-[2px]"
              />

              <Feedback error={error} msg={msg} />

              <View className="mt-5">
                <BrutalButton
                  label={busy ? 'Saving password…' : 'Update Password'}
                  variant="mint"
                  onPress={onConfirm}
                  disabled={busy}
                />
              </View>

              <Pressable
                onPress={() => {
                  setMode('request');
                  setError(null);
                  setMsg(null);
                }}
                className="mt-4 items-center">
                <Text className="text-xs font-black text-black underline">
                  {email ? 'Send another code' : 'Request a code instead'}
                </Text>
              </Pressable>
            </BrutalCard>
          </>
        )}

        {!session.data?.hasToken ? (
          <Link href="/login" asChild>
            <Pressable className="items-center py-2">
              <Text className="text-xs font-black text-black">Back to Log In</Text>
            </Pressable>
          </Link>
        ) : null}
      </KeyboardAwareScrollView>
    </View>
  );
}

/** Accepts the raw token or the full emailed link (…/reset-password?token=XYZ). */
function extractToken(raw: string): string {
  const s = raw.trim();
  const m = s.match(/[?&]token=([^&#\s]+)/);
  return (m ? decodeURIComponent(m[1]) : s).trim();
}

function Feedback({ error, msg }: { error: string | null; msg: string | null }) {
  if (error) {
    return (
      <View className="mt-3 p-2.5 bg-[#fce8e6] border-2 border-tea-red rounded-[2px] flex-row items-center gap-2">
        <Ionicons name="alert-circle" size={16} color="#cc6b49" />
        <Text className="text-xs font-bold text-tea-red flex-1">{error}</Text>
      </View>
    );
  }
  if (msg) {
    return (
      <View className="mt-3 p-2.5 bg-[#eafaf4] border-2 border-[#73bda8] rounded-[2px] flex-row items-center gap-2">
        <Ionicons name="checkmark-circle" size={16} color="#73bda8" />
        <Text className="text-xs font-bold text-black flex-1">{msg}</Text>
      </View>
    );
  }
  return null;
}
