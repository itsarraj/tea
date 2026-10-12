import React, { useState } from 'react';
import { Alert, Pressable, StatusBar, Text, TextInput, View } from 'react-native';
import { router } from 'expo-router';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { KeyboardAwareScrollView } from 'react-native-keyboard-controller';
import { Feather } from '@expo/vector-icons';

import { BrutalButton } from '@/components/tea/ui';
import { useChangePassword } from '@/hooks/useAuth';

function BrutalField({
  label,
  value,
  onChangeText,
  secureTextEntry,
  hint,
  placeholder,
}: {
  label: string;
  value: string;
  onChangeText: (v: string) => void;
  secureTextEntry?: boolean;
  hint?: string;
  placeholder?: string;
}) {
  return (
    <View className="mb-5">
      <Text className="mb-1.5 text-xs font-black uppercase tracking-wider text-black">{label}</Text>
      <TextInput
        value={value}
        onChangeText={onChangeText}
        secureTextEntry={secureTextEntry}
        placeholder={placeholder}
        placeholderTextColor="#888"
        className="h-12 px-4 bg-white border-2 border-black rounded-[3px] text-sm font-bold text-black"
        style={{
          shadowColor: '#000',
          shadowOffset: { width: -1.5, height: 2 },
          shadowOpacity: 1,
          shadowRadius: 0,
          elevation: 2,
        }}
      />
      {hint ? <Text className="mt-1.5 text-[11px] font-bold text-[#666]">{hint}</Text> : null}
    </View>
  );
}

export default function ChangePasswordScreen() {
  const insets = useSafeAreaInsets();
  const change = useChangePassword();
  const [current, setCurrent] = useState('');
  const [next, setNext] = useState('');
  const [confirm, setConfirm] = useState('');
  const back = () => (router.canGoBack() ? router.back() : router.replace('/(app)/settings'));

  const onSubmit = async () => {
    if (next.length < 8) return Alert.alert('Password', 'Use at least 8 characters.');
    if (next !== confirm) return Alert.alert('Password', 'Passwords don’t match.');
    try {
      await change.mutateAsync({ current_password: current, new_password: next });
      Alert.alert('Success', 'Password updated successfully.');
      back();
    } catch (e) {
      Alert.alert('Could not update', e instanceof Error ? e.message : 'Try again');
    }
  };

  return (
    <View className="flex-1 bg-[#ece6c2]" style={{ paddingTop: insets.top }}>
      <StatusBar barStyle="dark-content" backgroundColor="#ece6c2" />

      {/* Screen Header */}
      <View className="flex-row items-center justify-between px-5 py-3 border-b-2 border-black bg-[#ece6c2]">
        <View className="flex-row items-center gap-3">
          <Pressable
            onPress={back}
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
          <Text className="text-xl font-black text-black">Change Password</Text>
        </View>
      </View>

      <KeyboardAwareScrollView
        contentContainerStyle={{
          padding: 16,
          paddingBottom: insets.bottom + 40,
        }}
        bottomOffset={24}
        keyboardShouldPersistTaps="handled"
        showsVerticalScrollIndicator={false}>
        {/* Notice Card */}
        <View
          className="mb-5 p-4 bg-white border-2 border-black rounded-[3px] flex-row items-center gap-3"
          style={{
            shadowColor: '#000',
            shadowOffset: { width: -2, height: 3 },
            shadowOpacity: 1,
            shadowRadius: 0,
            elevation: 3,
          }}>
          <Feather name="shield" size={20} color="#000" />
          <Text className="text-xs font-bold text-black flex-1 leading-4">
            Other devices will stay signed in until their active sessions expire.
          </Text>
        </View>

        <BrutalField
          label="Current password"
          value={current}
          onChangeText={setCurrent}
          secureTextEntry
          placeholder="••••••••"
        />
        <BrutalField
          label="New password"
          value={next}
          onChangeText={setNext}
          secureTextEntry
          hint="Must be at least 8 characters"
          placeholder="••••••••"
        />
        <BrutalField
          label="Confirm new password"
          value={confirm}
          onChangeText={setConfirm}
          secureTextEntry
          placeholder="••••••••"
        />

        <View className="mt-4">
          <BrutalButton
            label="Save Password"
            onPress={onSubmit}
            loading={change.isPending}
            variant="mint"
            size="lg"
          />
        </View>
      </KeyboardAwareScrollView>
    </View>
  );
}
