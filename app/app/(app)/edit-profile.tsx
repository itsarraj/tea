import React, { useEffect, useState } from 'react';
import {
  Alert,
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
import { BrutalButton, LoadingState } from '@/components/tea/ui';
import { usePatchProfile, useProfile } from '@/hooks/useDating';
import { pickPhoto } from '@/lib/native';
import { datingApi } from '@/services/datingApi';

export default function EditProfileScreen() {
  const insets = useSafeAreaInsets();
  const me = useProfile();
  const patch = usePatchProfile();

  const [name, setName] = useState('');
  const [handle, setHandle] = useState('');
  const [about, setAbout] = useState('');
  const [city, setCity] = useState('');
  const [uploading, setUploading] = useState(false);

  useEffect(() => {
    if (!me.data) return;
    setName(me.data.display_name || '');
    setHandle(me.data.handle || '');
    setAbout(me.data.about || '');
    setCity(me.data.city || '');
  }, [me.data]);

  const handlePickPhoto = async () => {
    try {
      const picked = await pickPhoto('library');
      if (!picked) return;
      setUploading(true);
      await datingApi.uploadPhoto(picked.uri, picked.mimeType, picked.fileName);
      await me.refetch();
      Alert.alert('Avatar Updated', 'Your profile photo has been updated successfully.');
    } catch (e) {
      Alert.alert('Upload Error', e instanceof Error ? e.message : 'Could not upload photo.');
    } finally {
      setUploading(false);
    }
  };

  const back = () => (router.canGoBack() ? router.back() : router.replace('/(app)/me'));

  const save = async () => {
    if (name.trim().length < 2) {
      return Alert.alert('Name required', 'Please provide a display name with at least 2 characters.');
    }
    try {
      await patch.mutateAsync({
        display_name: name.trim(),
        about: about.trim(),
        city: city.trim(),
      });
      back();
    } catch (e) {
      Alert.alert('Could not save', e instanceof Error ? e.message : 'Please try again.');
    }
  };

  if (me.isLoading) return <LoadingState message="Loading profile..." />;
  const p = me.data;

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
          <Text className="text-xl font-black text-black">Edit Bio & Dossier</Text>
        </View>

        <View className="bg-tea-mint px-2 py-0.5 border border-black rounded-[2px]">
          <Text className="text-[10px] font-black uppercase text-black">Advisor Profile</Text>
        </View>
      </View>

      <KeyboardAwareScrollView
        bottomOffset={24}
        contentContainerStyle={{
          padding: 20,
          paddingBottom: insets.bottom + 40,
        }}
        keyboardShouldPersistTaps="handled"
        showsVerticalScrollIndicator={false}>
        {/* Avatar Section */}
        <View
          className="mb-6 p-4 bg-white border-2 border-black rounded-[3px] items-center"
          style={{
            shadowColor: '#000',
            shadowOffset: { width: -3, height: 3 },
            shadowOpacity: 1,
            shadowRadius: 0,
            elevation: 3,
          }}>
          <BrutalistAvatar
            name={name || p?.display_name || 'User'}
            handle={handle || p?.handle || 'user'}
            imageUrl={p?.photos?.[0]?.url}
            size={76}
            shape="square"
          />

          <Pressable
            onPress={handlePickPhoto}
            disabled={uploading}
            className="mt-3 flex-row items-center gap-1.5 bg-[#32b5ff] px-3.5 py-1.5 border-2 border-black rounded-[2px] active:translate-y-0.5"
            style={{
              shadowColor: '#000',
              shadowOffset: { width: -1.5, height: 2 },
              shadowOpacity: 1,
              shadowRadius: 0,
              elevation: 2,
            }}>
            <Feather name="camera" size={14} color="#000" />
            <Text className="text-xs font-black uppercase tracking-wider text-black">
              {uploading ? 'Uploading...' : 'Change Avatar'}
            </Text>
          </Pressable>

          <Text className="mt-2 text-center text-[11px] font-semibold text-[#555] leading-relaxed">
            Select a photo from your gallery. If removed or unavailable, your procedural monogram avatar is used automatically.
          </Text>
        </View>

        {/* Form Fields */}
        <View className="gap-4 mb-6">
          <View>
            <Text className="text-xs font-black uppercase tracking-wider text-black mb-1.5">
              Display Name
            </Text>
            <TextInput
              value={name}
              onChangeText={setName}
              maxLength={40}
              placeholder="e.g. Sam Rivera"
              placeholderTextColor="#777"
              className="h-12 bg-white border-2 border-black rounded-[3px] px-3.5 text-sm font-bold text-black"
            />
          </View>

          <View>
            <Text className="text-xs font-black uppercase tracking-wider text-black mb-1.5">
              Handle
            </Text>
            <View className="h-12 bg-[#e2dcbe] border-2 border-black rounded-[3px] px-3.5 flex-row items-center justify-between">
              <Text className="text-sm font-bold text-black">
                @{handle || p?.handle || (name ? name.toLowerCase().replace(/\s+/g, '_') : 'advisor')}
              </Text>
              <Text className="text-[10px] font-black uppercase text-[#666]">Permanent</Text>
            </View>
          </View>

          <View>
            <Text className="text-xs font-black uppercase tracking-wider text-black mb-1.5">
              City / Base
            </Text>
            <TextInput
              value={city}
              onChangeText={setCity}
              maxLength={60}
              placeholder="e.g. Los Angeles, CA"
              placeholderTextColor="#777"
              className="h-12 bg-white border-2 border-black rounded-[3px] px-3.5 text-sm font-bold text-black"
            />
          </View>

          <View>
            <Text className="text-xs font-black uppercase tracking-wider text-black mb-1.5">
              Advisor Bio / Dating Philosophy
            </Text>
            <TextInput
              value={about}
              onChangeText={(t) => setAbout(t.slice(0, 180))}
              multiline
              numberOfLines={4}
              textAlignVertical="top"
              placeholder="Tell others your perspective on dating, red flags you spot, or why people should follow your advice..."
              placeholderTextColor="#777"
              className="min-h-[100px] bg-white border-2 border-black rounded-[3px] p-3 text-sm font-medium text-black leading-relaxed"
            />
            <Text className="text-[10px] font-bold text-[#666] text-right mt-1">
              {about.length}/180
            </Text>
          </View>
        </View>

        {/* Save Button */}
        <BrutalButton
          label="Save Profile"
          variant="mint"
          onPress={save}
          loading={patch.isPending}
          size="lg"
        />
      </KeyboardAwareScrollView>
    </View>
  );
}
