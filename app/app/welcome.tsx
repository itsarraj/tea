import React, { useState } from 'react';
import { Pressable, StatusBar, Text, View } from 'react-native';
import { Link, router } from 'expo-router';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { Feather, Ionicons } from '@expo/vector-icons';

import { BrutalButton, BrutalCard } from '@/components/tea/ui';
import { useGoogleLogin } from '@/hooks/useAuth';

export default function WelcomeScreen() {
  const insets = useSafeAreaInsets();
  const google = useGoogleLogin();
  const [error, setError] = useState<string | null>(null);

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
    <View
      className="flex-1 bg-[#ece6c2] px-6 justify-between"
      style={{ paddingTop: insets.top + 20, paddingBottom: insets.bottom + 20 }}>
      <StatusBar barStyle="dark-content" backgroundColor="#ece6c2" />

      {/* Top Brand Hero */}
      <View className="items-center mt-6">
        <View className="flex-row items-center gap-2 bg-black px-3 py-1 rounded-[2px] mb-4">
          <Text className="text-xs font-black uppercase tracking-widest text-white">
            Neo-Brutalist
          </Text>
        </View>

        <Text className="text-5xl font-black text-black tracking-tight text-center">
          TEA ☕
        </Text>
        <Text className="text-2xl font-black text-black tracking-tight text-center mt-1">
          DATING ADVICE
        </Text>

        <Text className="text-xs font-bold text-[#444] text-center mt-3 max-w-[280px] leading-relaxed">
          Spill dilemmas, cast community verdicts, and follow the sharpest dating advisors. Candid takes. Real community.
        </Text>
      </View>

      {/* Brutalist Value Proposition Card */}
      <BrutalCard variant="white" className="my-6">
        <View className="gap-3.5">
          <View className="flex-row items-start gap-3">
            <View className="w-8 h-8 rounded-[2px] bg-tea-mint border-2 border-black items-center justify-center">
              <Text className="text-sm">🚩</Text>
            </View>
            <View className="flex-1">
              <Text className="text-xs font-black text-black">Red / Green / Valid Verdicts</Text>
              <Text className="text-[11px] font-medium text-[#444] leading-snug">
                Crowdsource honest community takes on real dating scenarios.
              </Text>
            </View>
          </View>

          <View className="flex-row items-start gap-3">
            <View className="w-8 h-8 rounded-[2px] bg-[#32b5ff] border-2 border-black items-center justify-center">
              <Ionicons name="sparkles" size={14} color="#000" />
            </View>
            <View className="flex-1">
              <Text className="text-xs font-black text-black">Dynamic Advisor Avatars</Text>
              <Text className="text-[11px] font-medium text-[#444] leading-snug">
                Expressive procedural monograms or custom photos. Instant and privacy-first.
              </Text>
            </View>
          </View>

          <View className="flex-row items-start gap-3">
            <View className="w-8 h-8 rounded-[2px] bg-tea-red border-2 border-black items-center justify-center">
              <Feather name="award" size={14} color="#fff" />
            </View>
            <View className="flex-1">
              <Text className="text-xs font-black text-black">Advisor Fan Following</Text>
              <Text className="text-[11px] font-medium text-[#444] leading-snug">
                Earn followers for having the highest-rated advice in town.
              </Text>
            </View>
          </View>
        </View>
      </BrutalCard>

      {/* Authentication Actions */}
      <View className="gap-3 mb-4">
        {error ? (
          <Text className="text-center text-xs font-bold text-tea-red mb-1">{error}</Text>
        ) : null}

        <BrutalButton
          label="Enter with Email"
          variant="mint"
          onPress={() => router.push('/login')}
          size="lg"
        />

        <Pressable
          onPress={onGoogle}
          disabled={google.isPending}
          className="h-12 bg-white border-2 border-black rounded-[3px] items-center justify-center flex-row gap-2 active:translate-y-0.5"
          style={{
            shadowColor: '#000',
            shadowOffset: { width: -3, height: 4 },
            shadowOpacity: 1,
            shadowRadius: 0,
            elevation: 4,
            opacity: google.isPending ? 0.6 : 1,
          }}>
          <Feather name="log-in" size={16} color="#000" />
          <Text className="text-sm font-black text-black">
            {google.isPending ? 'Connecting...' : 'Continue with Google'}
          </Text>
        </Pressable>

        <View className="flex-row items-center justify-center gap-1 mt-2">
          <Text className="text-xs font-semibold text-[#555]">New to Tea? </Text>
          <Link href="/register" asChild>
            <Pressable>
              <Text className="text-xs font-black text-black underline">Create Account</Text>
            </Pressable>
          </Link>
        </View>
      </View>
    </View>
  );
}
