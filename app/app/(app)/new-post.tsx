import React, { useState } from 'react';
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

import { BrutalButton, BrutalCard } from '@/components/tea/ui';
import { useCreatePost } from '@/hooks/useDating';
import { INTERESTS } from '@/lib/fixtures';

const TEA_CATEGORIES = INTERESTS;

export default function NewPostScreen() {
  const insets = useSafeAreaInsets();
  const create = useCreatePost();

  const [category, setCategory] = useState<string>(TEA_CATEGORIES[0]);
  const [title, setTitle] = useState('');
  const [question, setQuestion] = useState('');

  const back = () => (router.canGoBack() ? router.back() : router.replace('/(app)'));

  const submit = async () => {
    if (title.trim().length < 4) {
      return Alert.alert('Add a title', 'Please give your dating dilemma a quick headline.');
    }
    if (question.trim().length < 15) {
      return Alert.alert('More context needed', 'Please explain what happened in a bit more detail (min 15 characters).');
    }
    try {
      await create.mutateAsync({
        title: title.trim(),
        category,
        question: question.trim(),
      });
      back();
    } catch (e) {
      Alert.alert('Could not post', e instanceof Error ? e.message : 'Please try again.');
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
          <Text className="text-xl font-black text-black">Spill Dating Tea</Text>
        </View>

        <View className="bg-tea-mint px-2.5 py-1 border border-black rounded-[2px]">
          <Text className="text-[10px] font-black uppercase text-black">Advice Request</Text>
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
        {/* Community Advice Guidelines */}
        <View className="mb-4 p-3 bg-white border-2 border-black rounded-[3px] flex-row items-center gap-2.5"
          style={{
            shadowColor: '#000',
            shadowOffset: { width: -2, height: 2 },
            shadowOpacity: 1,
            shadowRadius: 0,
            elevation: 2,
          }}>
          <Ionicons name="bulb-outline" size={20} color="#0EA8FF" />
          <Text className="text-xs font-bold text-black flex-1 leading-snug">
            Community Advice Dilemma: Provide honest details so advisors can vote and share genuine dating wisdom.
          </Text>
        </View>

        {/* Category Picker */}
        <Text className="text-xs font-black uppercase tracking-wider text-black mb-2">
          Select Topic Category
        </Text>
        <View className="flex-row flex-wrap gap-2 mb-4">
          {TEA_CATEGORIES.map((cat) => {
            const isSelected = category === cat;
            return (
              <Pressable
                key={cat}
                onPress={() => setCategory(cat)}
                className={`px-3 py-1.5 border-2 border-black rounded-[2px] active:translate-y-0.5 ${
                  isSelected ? 'bg-black' : 'bg-white'
                }`}
                style={{
                  shadowColor: '#000',
                  shadowOffset: { width: -2, height: 2 },
                  shadowOpacity: 1,
                  shadowRadius: 0,
                  elevation: 2,
                }}>
                <Text
                  className={`text-xs font-black uppercase ${
                    isSelected ? 'text-white' : 'text-black'
                  }`}>
                  {cat}
                </Text>
              </Pressable>
            );
          })}
        </View>

        {/* Title Input */}
        <Text className="text-xs font-black uppercase tracking-wider text-black mb-1.5">
          Dilemma Headline
        </Text>
        <TextInput
          value={title}
          onChangeText={setTitle}
          placeholder="e.g. He asked me to split a $4 coffee on date 1..."
          placeholderTextColor="#777"
          maxLength={80}
          className="h-12 bg-white border-2 border-black rounded-[3px] px-3.5 text-sm font-bold text-black mb-1"
          style={{
            shadowColor: '#000',
            shadowOffset: { width: -2, height: 2 },
            shadowOpacity: 1,
            shadowRadius: 0,
            elevation: 2,
          }}
        />
        <Text className="text-[10px] font-bold text-[#666] text-right mb-4">
          {title.length}/80
        </Text>

        {/* Body Question Input */}
        <Text className="text-xs font-black uppercase tracking-wider text-black mb-1.5">
          The Full Story & Question
        </Text>
        <TextInput
          value={question}
          onChangeText={setQuestion}
          placeholder="Describe the situation in detail. What happened? What did they say? Ask the community for honest verdicts (Red Flag, Green Flag, or Valid?)..."
          placeholderTextColor="#777"
          multiline
          numberOfLines={6}
          textAlignVertical="top"
          maxLength={1000}
          className="min-h-[140px] bg-white border-2 border-black rounded-[3px] p-3.5 text-sm font-medium text-black leading-relaxed mb-1"
          style={{
            shadowColor: '#000',
            shadowOffset: { width: -2, height: 2 },
            shadowOpacity: 1,
            shadowRadius: 0,
            elevation: 2,
          }}
        />
        <Text className="text-[10px] font-bold text-[#666] text-right mb-6">
          {question.length}/1000
        </Text>

        {/* Submit Button */}
        <BrutalButton
          label="Publish Advice Dilemma"
          variant="mint"
          onPress={submit}
          loading={create.isPending}
          size="lg"
        />
      </KeyboardAwareScrollView>
    </View>
  );
}
