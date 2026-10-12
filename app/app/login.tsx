import React, { useEffect, useState } from 'react';
import {
  Pressable,
  StatusBar,
  Text,
  TextInput,
  View,
} from 'react-native';
import { Link, router } from 'expo-router';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { KeyboardAwareScrollView } from 'react-native-keyboard-controller';
import { Feather } from '@expo/vector-icons';

import { BrutalButton, BrutalCard } from '@/components/tea/ui';
import { useGoogleLogin, useLogin } from '@/hooks/useAuth';
import { getRememberedEmail, setRememberedEmail } from '@/lib/auth-storage';

export default function LoginScreen() {
  const insets = useSafeAreaInsets();
  const login = useLogin();
  const google = useGoogleLogin();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [remember, setRemember] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const busy = login.isPending || google.isPending;

  useEffect(() => {
    getRememberedEmail().then((saved) => {
      if (saved) {
        setEmail(saved);
        setRemember(true);
      }
    });
  }, []);

  const onSubmit = async () => {
    setError(null);
    try {
      await login.mutateAsync({ email: email.trim(), password });
      await setRememberedEmail(remember ? email.trim() : null);
      router.replace('/(app)');
    } catch (e) {
      setError(e instanceof Error ? e.message : 'Login failed');
    }
  };

  const onGoogle = async () => {
    setError(null);
    try {
      await google.mutateAsync();
      router.replace('/(app)');
    } catch (e) {
      setError(e instanceof Error ? e.message : 'Google sign-in failed');
    }
  };

  return (
    <View className="flex-1 bg-[#ece6c2]" style={{ paddingTop: insets.top }}>
      <StatusBar barStyle="dark-content" backgroundColor="#ece6c2" />

      {/* Screen Header */}
      <View className="flex-row items-center justify-between px-5 py-3 border-b-2 border-black bg-[#ece6c2]">
        <Pressable
          onPress={() => (router.canGoBack() ? router.back() : router.replace('/welcome'))}
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
        <Text className="text-xl font-black text-black">Sign In</Text>
        <View className="w-10" />
      </View>

      <KeyboardAwareScrollView
        contentContainerStyle={{
          flexGrow: 1,
          justifyContent: 'space-between',
          padding: 24,
          paddingBottom: insets.bottom + 20,
        }}
        bottomOffset={24}
        keyboardShouldPersistTaps="handled"
        showsVerticalScrollIndicator={false}>
        <View>
          <View className="mb-6">
            <View className="flex-row items-center gap-2 mb-1">
              <Text className="text-2xl font-black text-black">TEA ☕</Text>
              <View className="bg-tea-mint px-2 py-0.5 border border-black rounded-[2px]">
                <Text className="text-[10px] font-black uppercase text-black">Dating Advice</Text>
              </View>
            </View>
            <Text className="text-sm font-medium text-[#444]">
              Sign in to participate in honest dating discussions.
            </Text>
          </View>

          <BrutalCard variant="white" className="mb-6">
            <View className="gap-4">
              <View>
                <Text className="text-xs font-black uppercase tracking-wider text-black mb-1.5">
                  Email
                </Text>
                <TextInput
                  value={email}
                  onChangeText={setEmail}
                  placeholder="yourname@gmail.com"
                  placeholderTextColor="#777"
                  keyboardType="email-address"
                  autoCapitalize="none"
                  className="h-12 bg-[#ece6c2] border-2 border-black rounded-[3px] px-3.5 text-sm font-bold text-black"
                />
              </View>

              <View>
                <Text className="text-xs font-black uppercase tracking-wider text-black mb-1.5">
                  Password
                </Text>
                <View className="h-12 bg-[#ece6c2] border-2 border-black rounded-[3px] px-3.5 flex-row items-center">
                  <TextInput
                    value={password}
                    onChangeText={setPassword}
                    placeholder="••••••••"
                    placeholderTextColor="#777"
                    secureTextEntry={!showPassword}
                    className="flex-1 text-sm font-bold text-black"
                  />
                  <Pressable onPress={() => setShowPassword(!showPassword)}>
                    <Feather name={showPassword ? 'eye-off' : 'eye'} size={18} color="#000" />
                  </Pressable>
                </View>
              </View>

              <View className="flex-row items-center justify-between mt-1">
                <Pressable
                  onPress={() => setRemember(!remember)}
                  className="flex-row items-center gap-2">
                  <View
                    className={`w-4 h-4 rounded-[2px] border border-black items-center justify-center ${
                      remember ? 'bg-black' : 'bg-white'
                    }`}>
                    {remember ? <Feather name="check" size={12} color="#fff" /> : null}
                  </View>
                  <Text className="text-xs font-bold text-black">Remember me</Text>
                </Pressable>

                <Link href="/reset-password" asChild>
                  <Pressable>
                    <Text className="text-xs font-bold text-black underline">Forgot password?</Text>
                  </Pressable>
                </Link>
              </View>
            </View>

            {error ? (
              <Text className="mt-4 text-xs font-bold text-tea-red">{error}</Text>
            ) : null}

            <View className="mt-5 gap-3">
              <BrutalButton
                label="Sign In"
                variant="mint"
                onPress={onSubmit}
                loading={login.isPending}
                disabled={busy || !email || !password}
                size="lg"
              />

              <Pressable
                onPress={onGoogle}
                disabled={busy}
                className="h-12 bg-white border-2 border-black rounded-[3px] items-center justify-center flex-row gap-2 active:translate-y-0.5"
                style={{
                  shadowColor: '#000',
                  shadowOffset: { width: -2, height: 3 },
                  shadowOpacity: 1,
                  shadowRadius: 0,
                  elevation: 3,
                  opacity: google.isPending ? 0.6 : 1,
                }}>
                <Feather name="log-in" size={16} color="#000" />
                <Text className="text-sm font-black text-black">
                  {google.isPending ? 'Connecting...' : 'Continue with Google'}
                </Text>
              </Pressable>
            </View>
          </BrutalCard>
        </View>

        <View className="flex-row items-center justify-center gap-1">
          <Text className="text-xs font-semibold text-[#555]">Don’t have an account?</Text>
          <Link href="/register" asChild>
            <Pressable>
              <Text className="text-xs font-black text-black underline">Sign Up</Text>
            </Pressable>
          </Link>
        </View>
      </KeyboardAwareScrollView>
    </View>
  );
}
