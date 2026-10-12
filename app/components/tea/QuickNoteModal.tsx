import React, { useEffect, useState } from 'react';
import {
  Alert,
  Modal,
  Pressable,
  ScrollView,
  Text,
  TextInput,
  View,
} from 'react-native';
import { router } from 'expo-router';
import { Feather, Ionicons } from '@expo/vector-icons';
import { KeyboardAvoidingView } from 'react-native-keyboard-controller';

import { BrutalistAvatar } from '@/components/tea/BrutalistAvatar';
import { BrutalButton, BrutalCard } from '@/components/tea/ui';
import { useAddNote } from '@/hooks/useDating';
import type { NoteItem } from '@/components/tea/ui';

const PRESET_EMOJIS = ['✨', '☕', '🚩', '💡', '💔', '🔥', '💭', '🍸', '👀', '💅', '🎯', '🧸'];

export interface QuickNoteModalProps {
  visible: boolean;
  mode: 'create' | 'view';
  note?: NoteItem;
  currentUserPhotoUrl?: string;
  onClose: () => void;
}

export function QuickNoteModal({
  visible,
  mode: initialMode,
  note,
  currentUserPhotoUrl,
  onClose,
}: QuickNoteModalProps) {
  const [currentMode, setCurrentMode] = useState<'create' | 'view'>(initialMode);
  const [noteText, setNoteText] = useState('');
  const [selectedEmoji, setSelectedEmoji] = useState('✨');
  const addNote = useAddNote();

  useEffect(() => {
    setCurrentMode(initialMode);
    if (initialMode === 'create') {
      if (note?.isSelf) {
        setNoteText(note.note || '');
        setSelectedEmoji(note.emoji || '✨');
      } else {
        setNoteText('');
        setSelectedEmoji('✨');
      }
    }
  }, [initialMode, note, visible]);

  const handlePostNote = async () => {
    const trimmed = noteText.trim();
    if (!trimmed) {
      Alert.alert('Note required', 'Please write a short note (up to 100 characters).');
      return;
    }
    try {
      await addNote.mutateAsync({ note: trimmed, emoji: selectedEmoji });
      Alert.alert('Note Posted', 'Your quick note is now visible on the rail.');
      onClose();
    } catch (e) {
      Alert.alert('Error', e instanceof Error ? e.message : 'Could not post note.');
    }
  };

  const handleViewProfile = () => {
    onClose();
    if (note) {
      const target = note.userId || note.author;
      router.push(`/(app)/profile/${target}` as any);
    }
  };

  const handleSearchMentions = () => {
    onClose();
    if (note) {
      router.push(`/(app)/search?query=${encodeURIComponent(note.author)}` as any);
    }
  };

  return (
    <Modal
      visible={visible}
      transparent
      animationType="fade"
      onRequestClose={onClose}>
      <View
        style={{
          flex: 1,
          backgroundColor: 'rgba(0, 0, 0, 0.6)',
          justifyContent: 'center',
          alignItems: 'center',
          padding: 20,
        }}>
        <Pressable
          style={{ position: 'absolute', top: 0, bottom: 0, left: 0, right: 0 }}
          onPress={onClose}
        />

        <KeyboardAvoidingView
          behavior="padding"
          automaticOffset={true}
          style={{ width: '100%', alignItems: 'center' }}>
          <View
            style={{
              width: '100%',
              maxWidth: 380,
            backgroundColor: '#ECE6C2',
            borderWidth: 2.5,
            borderColor: '#000000',
            borderRadius: 4,
            padding: 20,
            shadowColor: '#000000',
            shadowOffset: { width: -4, height: 5 },
            shadowOpacity: 1,
            shadowRadius: 0,
            elevation: 8,
          }}>
          {currentMode === 'view' && note ? (
            /* ---- VIEW NOTE MODE ---- */
            <View>
              {/* Header: Author + Close */}
              <View
                style={{
                  flexDirection: 'row',
                  alignItems: 'center',
                  justifyContent: 'space-between',
                  marginBottom: 16,
                }}>
                <View style={{ flexDirection: 'row', alignItems: 'center', gap: 12 }}>
                  <BrutalistAvatar
                    seed={note.author}
                    name={note.name || note.author}
                    imageUrl={note.authorPhotoUrl}
                    size={46}
                    shape="circle"
                  />
                  <View>
                    <Text
                      style={{
                        fontSize: 15,
                        fontWeight: '900',
                        color: '#020202',
                        fontFamily: 'HankenGrotesk-Black',
                      }}>
                      {note.name || note.author}
                    </Text>
                    <Text style={{ fontSize: 11, fontWeight: '600', color: '#666666' }}>
                      @{note.author} {note.isSelf ? '· You' : ''}
                    </Text>
                  </View>
                </View>

                <Pressable
                  onPress={onClose}
                  style={{
                    width: 32,
                    height: 32,
                    borderRadius: 2,
                    backgroundColor: '#FFFFFF',
                    borderWidth: 1.5,
                    borderColor: '#000000',
                    alignItems: 'center',
                    justifyContent: 'center',
                  }}>
                  <Feather name="x" size={18} color="#000000" />
                </Pressable>
              </View>

              {/* Note Bubble Card */}
              <View
                style={{
                  backgroundColor: '#FFFFFF',
                  borderWidth: 2,
                  borderColor: '#000000',
                  borderRadius: 4,
                  padding: 16,
                  marginBottom: 18,
                  shadowColor: '#000000',
                  shadowOffset: { width: -2, height: 3 },
                  shadowOpacity: 1,
                  shadowRadius: 0,
                }}>
                <View
                  style={{
                    flexDirection: 'row',
                    alignItems: 'center',
                    justifyContent: 'space-between',
                    marginBottom: 8,
                  }}>
                  <View
                    style={{
                      backgroundColor: note.isSelf ? '#73BDA8' : '#32B5FF',
                      borderWidth: 1,
                      borderColor: '#000000',
                      borderRadius: 2,
                      paddingHorizontal: 6,
                      paddingVertical: 1,
                    }}>
                    <Text style={{ fontSize: 9, fontWeight: '900', color: '#000000', textTransform: 'uppercase' }}>
                      {note.isSelf ? 'Your Note' : 'Advisor Status'}
                    </Text>
                  </View>
                  <Text style={{ fontSize: 20 }}>{note.emoji || '✨'}</Text>
                </View>

                <Text
                  style={{
                    fontSize: 16,
                    fontWeight: '800',
                    color: '#020202',
                    lineHeight: 22,
                    fontFamily: 'HankenGrotesk-Bold',
                  }}>
                  "{note.note}"
                </Text>
              </View>

              {/* Action Buttons */}
              <View style={{ gap: 10 }}>
                {note.isSelf ? (
                  <BrutalButton
                    label="Update / Leave New Note"
                    variant="mint"
                    onPress={() => setCurrentMode('create')}
                    size="md"
                  />
                ) : (
                  <>
                    <BrutalButton
                      label="View Advisor Profile"
                      variant="mint"
                      onPress={handleViewProfile}
                      size="md"
                    />
                    <BrutalButton
                      label={`Search @${note.author}`}
                      variant="paper"
                      onPress={handleSearchMentions}
                      size="sm"
                    />
                  </>
                )}
              </View>
            </View>
          ) : (
            /* ---- CREATE / EDIT NOTE MODE ---- */
            <View>
              {/* Header */}
              <View
                style={{
                  flexDirection: 'row',
                  alignItems: 'center',
                  justifyContent: 'space-between',
                  marginBottom: 12,
                }}>
                <View style={{ flexDirection: 'row', alignItems: 'center', gap: 8 }}>
                  <Text style={{ fontSize: 18, fontWeight: '900', color: '#000000' }}>
                    Leave Quick Note
                  </Text>
                  <Text style={{ fontSize: 18 }}>{selectedEmoji}</Text>
                </View>

                <Pressable
                  onPress={onClose}
                  style={{
                    width: 32,
                    height: 32,
                    borderRadius: 2,
                    backgroundColor: '#FFFFFF',
                    borderWidth: 1.5,
                    borderColor: '#000000',
                    alignItems: 'center',
                    justifyContent: 'center',
                  }}>
                  <Feather name="x" size={18} color="#000000" />
                </Pressable>
              </View>

              <Text
                style={{
                  fontSize: 11,
                  fontWeight: '600',
                  color: '#555555',
                  marginBottom: 12,
                  lineHeight: 15,
                }}>
                Share a thought, status, or hot dating take with your followers (max 100 characters).
              </Text>

              {/* Text Input */}
              <View
                style={{
                  backgroundColor: '#FFFFFF',
                  borderWidth: 2,
                  borderColor: '#000000',
                  borderRadius: 3,
                  padding: 10,
                  marginBottom: 10,
                  shadowColor: '#000000',
                  shadowOffset: { width: -1.5, height: 2 },
                  shadowOpacity: 1,
                  shadowRadius: 0,
                }}>
                <TextInput
                  value={noteText}
                  onChangeText={setNoteText}
                  maxLength={100}
                  multiline
                  numberOfLines={3}
                  placeholder="What's your current dating vibe?..."
                  placeholderTextColor="#888888"
                  style={{
                    fontSize: 13,
                    fontWeight: '700',
                    color: '#020202',
                    minHeight: 60,
                    textAlignVertical: 'top',
                  }}
                />
                <Text
                  style={{
                    fontSize: 10,
                    fontWeight: '700',
                    color: noteText.length >= 95 ? '#CC6B49' : '#888888',
                    textAlign: 'right',
                    marginTop: 4,
                  }}>
                  {noteText.length}/100
                </Text>
              </View>

              {/* Emoji Selector Carousel */}
              <Text
                style={{
                  fontSize: 10,
                  fontWeight: '900',
                  color: '#000000',
                  textTransform: 'uppercase',
                  letterSpacing: 0.5,
                  marginBottom: 6,
                }}>
                Select Status Mood
              </Text>
              <ScrollView
                horizontal
                showsHorizontalScrollIndicator={false}
                contentContainerStyle={{ gap: 6, paddingBottom: 14 }}>
                {PRESET_EMOJIS.map((emoji) => {
                  const isSelected = selectedEmoji === emoji;
                  return (
                    <Pressable
                      key={emoji}
                      onPress={() => setSelectedEmoji(emoji)}
                      style={{
                        width: 38,
                        height: 38,
                        borderRadius: 3,
                        backgroundColor: isSelected ? '#73BDA8' : '#FFFFFF',
                        borderWidth: 1.5,
                        borderColor: '#000000',
                        alignItems: 'center',
                        justifyContent: 'center',
                        shadowColor: '#000000',
                        shadowOffset: { width: -1, height: isSelected ? 1 : 2 },
                        shadowOpacity: 1,
                        shadowRadius: 0,
                        transform: [{ translateY: isSelected ? 1 : 0 }],
                      }}>
                      <Text style={{ fontSize: 18 }}>{emoji}</Text>
                    </Pressable>
                  );
                })}
              </ScrollView>

              {/* Action Buttons */}
              <View style={{ gap: 8, marginTop: 4 }}>
                <BrutalButton
                  label="Share Note"
                  variant="mint"
                  onPress={handlePostNote}
                  loading={addNote.isPending}
                  disabled={addNote.isPending || noteText.trim().length === 0}
                  size="md"
                />
                <Pressable
                  onPress={onClose}
                  style={{ paddingVertical: 6, alignItems: 'center' }}>
                  <Text style={{ fontSize: 12, fontWeight: '700', color: '#666666' }}>Cancel</Text>
                </Pressable>
              </View>
            </View>
          )}
        </View>
        </KeyboardAvoidingView>
      </View>
    </Modal>
  );
}
