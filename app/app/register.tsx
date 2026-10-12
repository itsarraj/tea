import React, { useState } from 'react';
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
import { TeaBirthdayField, isValidBirthday } from '@/components/tea/TeaBirthdayPicker';
import { useGoogleLogin, useRegister } from '@/hooks/useAuth';

function toIsoBirthday(raw: string): string | null {
  const s = raw.trim();
  if (/^\d{4}-\d{2}-\d{2}$/.test(s)) return s;
  const m = s.match(/^(\d{1,2})[\/\-.](\d{1,2})[\/\-.](\d{4})$/);
  if (m) {
    const dd = m[1].padStart(2, '0');
    const mm = m[2].padStart(2, '0');
    return `${m[3]}-${mm}-${dd}`;
  }
  return null;
}

export default function RegisterScreen() {
  const insets = useSafeAreaInsets();
  const register = useRegister();
  const google = useGoogleLogin();

  const [name, setName] = useState('');
  const [email, setEmail] = useState('');
  const [birthday, setBirthday] = useState('2000-01-01');
  const [password, setPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const busy = register.isPending || google.isPending;

  const onSubmit = async () => {
    setError(null);
    const iso = toIsoBirthday(birthday);
    if (!iso) {
      setError('Please select a valid birth date.');
      return;
    }
    if (!isValidBirthday(iso)) {
      setError('Tea Dating Advice is strictly for adults aged 18 and older.');
      return;
    }
    try {
      await register.mutateAsync({
        name: name.trim(),
        email: email.trim(),
        birthday: iso,
        password,
      });
      router.replace('/onboarding');
    } catch (e) {
      setError(e instanceof Error ? e.message : 'Registration failed');
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
        <Text className="text-xl font-black text-black">Create Account</Text>
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
                <Text className="text-[10px] font-black uppercase text-black">18+ Only</Text>
              </View>
            </View>
            <Text className="text-sm font-medium text-[#444]">
              Candid dating advice & dilemma verdicts. Create your advisor persona.
            </Text>
          </View>

          <BrutalCard variant="white" className="mb-6">
            <View className="gap-3.5">
              <View>
                <Text className="text-xs font-black uppercase tracking-wider text-black mb-1">
                  Name / Alias
                </Text>
                <TextInput
                  value={name}
                  onChangeText={setName}
                  placeholder="e.g. Alex Morgan"
                  placeholderTextColor="#777"
                  className="h-11 bg-[#ece6c2] border-2 border-black rounded-[3px] px-3.5 text-sm font-bold text-black"
                />
              </View>

              <View>
                <Text className="text-xs font-black uppercase tracking-wider text-black mb-1">
                  Email
                </Text>
                <TextInput
                  value={email}
                  onChangeText={setEmail}
                  placeholder="yourname@gmail.com"
                  placeholderTextColor="#777"
                  keyboardType="email-address"
                  autoCapitalize="none"
                  className="h-11 bg-[#ece6c2] border-2 border-black rounded-[3px] px-3.5 text-sm font-bold text-black"
                />
              </View>

              <TeaBirthdayField
                label="Birth Date (18+ Required)"
                value={birthday}
                onChange={setBirthday}
                hint="Only your age is shown. Strict 18+ policy enforced."
              />

              <View>
                <Text className="text-xs font-black uppercase tracking-wider text-black mb-1">
                  Password
                </Text>
                <View className="h-11 bg-[#ece6c2] border-2 border-black rounded-[3px] px-3.5 flex-row items-center">
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
            </View>

            {error ? (
              <Text className="mt-3 text-xs font-bold text-tea-red">{error}</Text>
            ) : null}

            <View className="mt-5 gap-3">
              <BrutalButton
                label="Sign Up"
                variant="mint"
                onPress={onSubmit}
                loading={register.isPending}
                disabled={busy || !name || !email || !password}
                size="lg"
              />

              <Pressable
                onPress={onGoogle}
                disabled={busy}
                className="h-11 bg-white border-2 border-black rounded-[3px] items-center justify-center flex-row gap-2 active:translate-y-0.5"
                style={{
                  shadowColor: '#000',
                  shadowOffset: { width: -2, height: 3 },
                  shadowOpacity: 1,
                  shadowRadius: 0,
                  elevation: 3,
                  opacity: google.isPending ? 0.6 : 1,
                }}>
                <Feather name="log-in" size={16} color="#000" />
                <Text className="text-xs font-black text-black">
                  {google.isPending ? 'Connecting...' : 'Sign up with Google'}
                </Text>
              </Pressable>
            </View>
          </BrutalCard>
        </View>

        <View className="flex-row items-center justify-center gap-1">
          <Text className="text-xs font-semibold text-[#555]">Already have an account?</Text>
          <Link href="/login" asChild>
            <Pressable>
              <Text className="text-xs font-black text-black underline">Sign In</Text>
            </Pressable>
          </Link>
        </View>
      </KeyboardAwareScrollView>
    </View>
  );
}
