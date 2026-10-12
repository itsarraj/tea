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

import { BrutalButton, BrutalCard, LoadingState } from '@/components/tea/ui';
import { usePatchProfile, useProfile } from '@/hooks/useDating';
import { INTERESTS } from '@/lib/fixtures';

const SPECIALTIES = [
  'General Dating Advice',
  'Situationships & Mixed Signals',
  'Texting Psychology',
  'First Date Dilemmas',
  'Red Flag Detection',
  'Long-Term Commitment',
];

export default function PreferencesScreen() {
  const insets = useSafeAreaInsets();
  const me = useProfile();
  const patch = usePatchProfile();

  const [selectedTopics, setSelectedTopics] = useState<string[]>([]);
  const [specialty, setSpecialty] = useState<string>(SPECIALTIES[0]);
  const [city, setCity] = useState('');
  const [initialized, setInitialized] = useState(false);

  useEffect(() => {
    if (!me.data || initialized) return;
    setInitialized(true);
    if (me.data.interests && me.data.interests.length > 0) {
      setSelectedTopics(me.data.interests);
    } else if (!me.data.interests) {
      setSelectedTopics(['🚩 Red Flags', '☕ First Date', '💡 Dating Advice']);
    } else {
      setSelectedTopics([]);
    }
    if (me.data.specialty) {
      setSpecialty(me.data.specialty);
    }
    if (me.data.city) {
      setCity(me.data.city);
    }
  }, [me.data, initialized]);

  const toggleTopic = (topic: string) => {
    setSelectedTopics((prev) =>
      prev.includes(topic)
        ? prev.filter((t) => t !== topic)
        : [...prev, topic],
    );
  };

  const back = () => (router.canGoBack() ? router.back() : router.replace('/(app)/me'));

  const savePreferences = async () => {
    try {
      await patch.mutateAsync({
        interests: selectedTopics,
        specialty,
        city: city.trim() || undefined,
      });
      Alert.alert('Saved', 'Your advice topics and preferences have been updated.');
      back();
    } catch (e) {
      Alert.alert('Error', e instanceof Error ? e.message : 'Could not save preferences.');
    }
  };

  if (me.isLoading) return <LoadingState message="Loading preferences..." />;

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
          <Text className="text-xl font-black text-black">Advice Topics</Text>
        </View>

        <View className="bg-black px-2 py-0.5 rounded-[2px]">
          <Text className="text-[10px] font-black uppercase text-white">Tea App</Text>
        </View>
      </View>

      <KeyboardAwareScrollView
        bottomOffset={24}
        contentContainerStyle={{ padding: 20, paddingBottom: insets.bottom + 40 }}
        showsVerticalScrollIndicator={false}>
        {/* Info Banner */}
        <View
          className="mb-5 p-3.5 bg-tea-mint border-2 border-black rounded-[3px]"
          style={{
            shadowColor: '#000',
            shadowOffset: { width: -3, height: 3 },
            shadowOpacity: 1,
            shadowRadius: 0,
            elevation: 3,
          }}>
          <View className="flex-row items-center gap-2 mb-1">
            <Ionicons name="sparkles" size={18} color="#000" />
            <Text className="text-xs font-black uppercase text-black">Feed Customization</Text>
          </View>
          <Text className="text-xs text-black font-medium leading-relaxed">
            Select the dating advice categories you care about most. These topics will shape your dilemma feed and advisor suggestions.
          </Text>
        </View>

        {/* Favorite Advice Topics */}
        <Text className="text-xs font-black uppercase tracking-wider text-black mb-3">
          Favorite Dilemma Topics
        </Text>
        <View className="flex-row flex-wrap gap-2 mb-6">
          {INTERESTS.map((topic) => {
            const isSelected = selectedTopics.includes(topic);
            return (
              <Pressable
                key={topic}
                unstable_pressDelay={0}
                onPress={() => toggleTopic(topic)}
                className={`px-3 py-2 border-2 border-black rounded-[2px] ${
                  isSelected ? 'bg-black' : 'bg-white'
                }`}
                style={{
                  shadowColor: '#000',
                  shadowOffset: isSelected ? { width: -1, height: 1 } : { width: -2, height: 2 },
                  shadowOpacity: 1,
                  shadowRadius: 0,
                  elevation: 2,
                }}>
                <Text
                  className={`text-xs font-black ${
                    isSelected ? 'text-white' : 'text-black'
                  }`}>
                  {topic}
                </Text>
              </Pressable>
            );
          })}
        </View>

        {/* Primary Specialty Area */}
        <Text className="text-xs font-black uppercase tracking-wider text-black mb-3">
          Your Primary Advice Specialty
        </Text>
        <BrutalCard variant="white" className="mb-6 p-2">
          {SPECIALTIES.map((spec, idx) => {
            const isSelected = specialty === spec;
            return (
              <Pressable
                key={spec}
                onPress={() => setSpecialty(spec)}
                className={`flex-row items-center justify-between p-3 rounded-[2px] ${
                  isSelected ? 'bg-tea-mint border border-black' : ''
                } ${idx > 0 && !isSelected ? 'border-t border-[#eee]' : ''}`}>
                <Text className="text-xs font-bold text-black">{spec}</Text>
                {isSelected ? <Feather name="check" size={16} color="#000" /> : null}
              </Pressable>
            );
          })}
        </BrutalCard>

        {/* Local Area Filter */}
        <Text className="text-xs font-black uppercase tracking-wider text-black mb-2">
          City / Locale (Optional)
        </Text>
        <TextInput
          value={city}
          onChangeText={setCity}
          placeholder="e.g. New York, London, Bengaluru"
          placeholderTextColor="#888"
          className="h-12 px-4 bg-white border-2 border-black rounded-[3px] text-sm font-bold text-black mb-8"
          style={{
            shadowColor: '#000',
            shadowOffset: { width: -1.5, height: 2 },
            shadowOpacity: 1,
            shadowRadius: 0,
            elevation: 2,
          }}
        />

        {/* Save Button */}
        <BrutalButton
          label={patch.isPending ? 'Saving Preferences...' : 'Save Preferences'}
          variant="terracotta"
          onPress={savePreferences}
          disabled={patch.isPending}
        />
      </KeyboardAwareScrollView>
    </View>
  );
}
