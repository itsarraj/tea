import React from 'react';
import { StyleSheet, Text, View } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { useFixtureMode } from '@/lib/fixture-mode';

export function OfflineBanner() {
  const { active, reason } = useFixtureMode();
  if (!active) return null;

  return (
    <View style={styles.container}>
      <Ionicons name="cloud-offline" size={14} color="#000000" />
      <Text style={styles.text} numberOfLines={1}>
        OFFLINE DEMO MODE • BFF UNREACHABLE{reason ? ` (${reason})` : ''} • SERVING LOCAL DATA
      </Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    backgroundColor: '#FFD166',
    borderBottomWidth: 2,
    borderBottomColor: '#000000',
    paddingVertical: 5,
    paddingHorizontal: 10,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    gap: 6,
    zIndex: 9999,
  },
  text: {
    fontSize: 10,
    fontWeight: '900',
    color: '#000000',
    textTransform: 'uppercase',
    letterSpacing: 0.5,
  },
});
