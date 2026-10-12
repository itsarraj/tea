import React, { useEffect, useState } from 'react';
import {
  Alert,
  BackHandler,
  Pressable,
  StatusBar,
  Text,
  TextInput,
  View,
} from 'react-native';
import { router } from 'expo-router';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { Feather, Ionicons } from '@expo/vector-icons';
import { KeyboardAwareScrollView } from 'react-native-keyboard-controller';

import { BrutalistAvatar } from '@/components/tea/BrutalistAvatar';
import { BrutalButton, BrutalCard, LoadingState } from '@/components/tea/ui';
import { TeaBirthdayField, isValidBirthday } from '@/components/tea/TeaBirthdayPicker';
import { useQueryClient } from '@tanstack/react-query';
import { useLogout, useSession } from '@/hooks/useAuth';
import { datingKeys, usePatchProfile, useProfile } from '@/hooks/useDating';

const STEPS = ['Identity & Age', 'Advisor Persona & Guidelines'] as const;

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

export default function OnboardingScreen() {
  const insets = useSafeAreaInsets();
  const session = useSession();
  const qc = useQueryClient();
  const me = useProfile(Boolean(session.data?.hasToken));
  const patch = usePatchProfile();
  const logout = useLogout();

  const [step, setStep] = useState(0);
  const [name, setName] = useState('');
  const [handle, setHandle] = useState('');
  const [birthday, setBirthday] = useState('2000-01-01');
  const [city, setCity] = useState('');
  const [about, setAbout] = useState('');
  const [seeded, setSeeded] = useState(false);

  useEffect(() => {
    if (!me.data || seeded) return;
    setSeeded(true);
    setName(
      me.data.display_name === 'You' || me.data.display_name.startsWith('User ')
        ? ''
        : me.data.display_name,
    );
    setHandle(me.data.handle || '');
    setBirthday(me.data.birthday || '2000-01-01');
    setCity(me.data.city || '');
    setAbout(me.data.about ? me.data.about.slice(0, 100) : '');
  }, [me.data, seeded]);

  useEffect(() => {
    const sub = BackHandler.addEventListener('hardwareBackPress', () => {
      if (step > 0) {
        setStep((s) => s - 1);
        return true;
      }
      return true;
    });
    return () => sub.remove();
  }, [step]);

  useEffect(() => {
    if (session.isLoading || me.isLoading) return;
    if (!session.data?.hasToken) {
      router.replace('/welcome');
    } else if (me.data?.onboarding_complete) {
      router.replace('/(app)');
    }
  }, [session.isLoading, session.data?.hasToken, me.isLoading, me.data?.onboarding_complete]);

  if (session.isLoading) return <LoadingState message="Checking session..." />;
  if (!session.data?.hasToken) return <LoadingState message="Redirecting to welcome..." />;
  if (me.data?.onboarding_complete) return <LoadingState message="Redirecting to app..." />;
  if (me.isError) {
    return (
      <View className="flex-1 bg-[#ece6c2] items-center justify-center p-6" style={{ paddingTop: insets.top }}>
        <Text className="text-lg font-black text-black mb-2">Failed to load profile</Text>
        <Text className="text-xs font-bold text-[#666] text-center mb-6">
          {me.error instanceof Error ? me.error.message : 'Something went wrong fetching your advisor profile.'}
        </Text>
        <View className="flex-row gap-3">
          <BrutalButton label="Retry" onPress={() => me.refetch()} variant="mint" />
          <BrutalButton
            label="Sign out"
            onPress={async () => {
              try {
                await logout.mutateAsync();
              } catch {}
              router.replace('/welcome');
            }}
            variant="white"
          />
        </View>
      </View>
    );
  }
  if (me.isLoading || !me.data) return <LoadingState message="Preparing your advisor profile..." />;

  const handleNext = async () => {
    if (step === 0) {
      if (name.trim().length < 2) {
        return Alert.alert('Name required', 'Please enter a name or alias (at least 2 letters).');
      }
      const iso = toIsoBirthday(birthday);
      if (!iso || !isValidBirthday(iso)) {
        return Alert.alert('18+ Required', 'Tea Dating Advice is strictly for adults aged 18 and older.');
      }
      try {
        const res = await patch.mutateAsync({
          display_name: name.trim(),
          birthday: iso,
          city: city.trim() || 'Online',
          about: about.trim() || 'Dating Advice Enthusiast',
        });
        if (res?.handle) {
          setHandle(res.handle);
        }
        setStep(1);
      } catch (e) {
        Alert.alert(
          'Unable to continue',
          e instanceof Error ? e.message : 'Please check your information and try again.',
        );
      }
    } else {
      const iso = toIsoBirthday(birthday) || birthday;
      try {
        await patch.mutateAsync({
          display_name: name.trim(),
          handle: handle || undefined,
          birthday: iso,
          city: city.trim() || 'Online',
          about: about.trim() || 'Dating Advice Enthusiast',
          complete_onboarding: true,
        });
        qc.setQueryData(datingKeys.profile, (old: any) =>
          old ? { ...old, onboarding_complete: true } : old,
        );
        router.replace('/(app)');
      } catch (e) {
        Alert.alert('Could not finish', e instanceof Error ? e.message : 'Please try again.');
      }
    }
  };

  return (
    <View className="flex-1 bg-[#ece6c2]" style={{ paddingTop: insets.top }}>
      <StatusBar barStyle="dark-content" backgroundColor="#ece6c2" />

      {/* Screen Header */}
      <View className="flex-row items-center justify-between px-5 py-3 border-b-2 border-black bg-[#ece6c2]">
        {step > 0 ? (
          <Pressable
            key="header-back-button"
            onPress={() => setStep((s) => s - 1)}
            className="w-10 h-10 rounded-[2px] bg-white border-2 border-black items-center justify-center"
            style={({ pressed }) => [
              {
                shadowColor: '#000',
                shadowOffset: { width: -2, height: 2 },
                shadowOpacity: 1,
                shadowRadius: 0,
                elevation: 3,
                transform: pressed ? [{ translateX: -1 }, { translateY: 1 }] : [],
              },
            ]}>
            <Feather name="arrow-left" size={20} color="#000" />
          </Pressable>
        ) : (
          <Pressable
            key="header-signout-button"
            onPress={async () => {
              try {
                await logout.mutateAsync();
              } catch {
                // Ignore, session query update triggers redirect
              }
              router.replace('/welcome');
            }}
            className="h-10 justify-center px-2">
            <Text className="text-xs font-black uppercase text-[#666]">Sign out</Text>
          </Pressable>
        )}

        <View className="flex-row items-center gap-1.5">
          {STEPS.map((s, idx) => (
            <View
              key={s}
              className={`h-2.5 rounded-[1px] border border-black ${
                idx === step ? 'w-8 bg-black' : 'w-4 bg-white'
              }`}
            />
          ))}
        </View>

        <Text className="text-xs font-black text-black">
          Step {step + 1} of {STEPS.length}
        </Text>
      </View>

      <KeyboardAwareScrollView
        bottomOffset={24}
        contentContainerStyle={{
          padding: 20,
          paddingBottom: insets.bottom + 40,
        }}
        keyboardShouldPersistTaps="handled"
        showsVerticalScrollIndicator={false}>
        {step === 0 ? (
          <View>
            <Text className="text-2xl font-black text-black mb-1">Your Identity</Text>
            <Text className="text-xs font-medium text-[#444] mb-5 leading-relaxed">
              Set up your public dating advisor moniker. Your initial monogram avatar is generated automatically, and can be customized with a photo anytime in your profile.
            </Text>

            {/* Input: Display Name */}
            <View className="mb-4">
              <Text className="text-xs font-black uppercase tracking-wider text-black mb-1.5">
                Display Name
              </Text>
              <TextInput
                value={name}
                onChangeText={setName}
                placeholder="e.g. Alex Morgan"
                placeholderTextColor="#777"
                maxLength={30}
                className="h-12 bg-white border-2 border-black rounded-[3px] px-3.5 text-sm font-bold text-black"
                style={{
                  shadowColor: '#000',
                  shadowOffset: { width: -2, height: 2 },
                  shadowOpacity: 1,
                  shadowRadius: 0,
                  elevation: 2,
                }}
              />
            </View>

            {/* Input: Birthday (18+ Verification) */}
            <TeaBirthdayField
              label="Birth Date (18+ Required)"
              value={birthday}
              onChange={setBirthday}
              hint="Only your age is shown. Strict 18+ policy enforced."
            />

            {/* Input: City */}
            <View className="mb-4">
              <Text className="text-xs font-black uppercase tracking-wider text-black mb-1.5">
                City / Location
              </Text>
              <TextInput
                value={city}
                onChangeText={setCity}
                placeholder="e.g. Los Angeles, CA"
                placeholderTextColor="#777"
                maxLength={50}
                className="h-12 bg-white border-2 border-black rounded-[3px] px-3.5 text-sm font-bold text-black"
                style={{
                  shadowColor: '#000',
                  shadowOffset: { width: -2, height: 2 },
                  shadowOpacity: 1,
                  shadowRadius: 0,
                  elevation: 2,
                }}
              />
            </View>

            {/* Input: Bio / Motto */}
            <View className="mb-6">
              <Text className="text-xs font-black uppercase tracking-wider text-black mb-1.5">
                Advice Bio / Motto
              </Text>
              <TextInput
                value={about}
                onChangeText={setAbout}
                placeholder="e.g. Brutally honest takes only. DM for advice."
                placeholderTextColor="#777"
                maxLength={100}
                className="h-12 bg-white border-2 border-black rounded-[3px] px-3.5 text-sm font-medium text-black"
                style={{
                  shadowColor: '#000',
                  shadowOffset: { width: -2, height: 2 },
                  shadowOpacity: 1,
                  shadowRadius: 0,
                  elevation: 2,
                }}
              />
            </View>

            <BrutalButton
              label="Next: Review Advisor Persona"
              variant="mint"
              onPress={handleNext}
              loading={patch.isPending}
              size="lg"
            />
          </View>
        ) : (
          /* Step 1: Reveal advisor avatar and persona */
          <View className="items-center">
            <Text className="text-2xl font-black text-black mb-1">Your Advisor Persona</Text>
            <Text className="text-xs font-medium text-[#444] text-center mb-6 max-w-[300px]">
              Your neo-brutalist monogram avatar is ready! You can also customize your avatar with a photo anytime in your profile.
            </Text>

            <View
              className="p-6 bg-white border-2 border-black rounded-[4px] items-center mb-6 w-full"
              style={{
                shadowColor: '#000',
                shadowOffset: { width: -4, height: 4 },
                shadowOpacity: 1,
                shadowRadius: 0,
                elevation: 5,
              }}>
              <BrutalistAvatar
                name={name || 'Advisor'}
                handle={handle || (name ? name.toLowerCase().replace(/\s+/g, '_') : 'advisor')}
                size={96}
                shape="square"
              />

              <Text className="text-lg font-black text-black mt-3">{name || 'Advisor'}</Text>
              <Text className="text-xs font-bold text-[#666]">
                @{handle || (name ? name.toLowerCase().replace(/\s+/g, '_') : 'advisor')}
              </Text>

              <View className="mt-4 bg-[#ece6c2] border border-black p-2.5 rounded-[2px] w-full flex-row items-center gap-2">
                <Ionicons name="sparkles" size={16} color="#0EA8FF" />
                <Text className="text-xs font-bold text-black flex-1">
                  Procedural Monogram Avatar • Customizable in Profile
                </Text>
              </View>
            </View>

            {/* Core Manifesto */}
            <BrutalCard variant="paper" className="mb-6 w-full">
              <Text className="text-xs font-black uppercase text-black mb-2">
                The Tea Community Oath
              </Text>
              <Text className="text-xs text-[#222] font-medium leading-relaxed">
                1. Thoughtful dating advice: share candid wisdom and helpful perspectives.{'\n'}
                2. Call out red flags honestly, celebrate green flags.{'\n'}
                3. Build your reputation and fan following by giving trusted dating advice.
              </Text>
            </BrutalCard>

            <BrutalButton
              label="Complete Setup & Enter Tea"
              variant="mint"
              onPress={handleNext}
              loading={patch.isPending}
              size="lg"
            />
          </View>
        )}
      </KeyboardAwareScrollView>
    </View>
  );
}
