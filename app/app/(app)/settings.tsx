import React, { useEffect, useRef, useState } from 'react';
import {
  Alert,
  Animated,
  InteractionManager,
  Linking,
  Platform,
  Pressable,
  ScrollView,
  StatusBar,
  Text,
  Vibration,
  View,
} from 'react-native';
import * as Device from 'expo-device';
import { router } from 'expo-router';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { useQueryClient } from '@tanstack/react-query';
import { Feather, Ionicons } from '@expo/vector-icons';

import { BrutalButton, BrutalCard, LoadingState } from '@/components/tea/ui';
import { useLogout, usePasswordReset } from '@/hooks/useAuth';
import { useBlockedUsers, useDeleteAccount, useProfile } from '@/hooks/useDating';
import { clearTokens } from '@/lib/auth-storage';
import { queryKeys } from '@/lib/queryClient';
import { BFF_API_URL } from '@/constants/config';
import { getPushToken, isPushConfigured } from '@/lib/native';
import { datingApi } from '@/services/datingApi';
import { isFixtureMode } from '@/lib/fixture-mode';
import { useAppSettings } from '@/hooks/useAppSettings';

const isSyntheticEmail = (email: string) =>
  email.endsWith('@teadating.local') ||
  email.endsWith('@teadating.mock');

export default function SettingsScreen() {
  const insets = useSafeAreaInsets();
  const me = useProfile();
  const blocked = useBlockedUsers();
  const logout = useLogout();
  const reset = usePasswordReset();
  const del = useDeleteAccount();
  const qc = useQueryClient();
  const { settings, updateSettings } = useAppSettings();

  const [resetSent, setResetSent] = useState(false);
  const pushSyncGen = useRef(0);

  const back = () => (router.canGoBack() ? router.back() : router.replace('/(app)/me'));

  const signOut = async () => {
    try {
      await logout.mutateAsync();
      qc.clear();
      router.replace('/welcome');
    } catch {
      router.replace('/welcome');
    }
  };

  const buzz = () => {
    if (!settings.hapticsEnabled || Platform.OS !== 'android') return;
    requestAnimationFrame(() => Vibration.vibrate(12));
  };

  const handleToggle = (patch: Partial<Parameters<typeof updateSettings>[0]>) => {
    updateSettings(patch);
    buzz();
  };

  const handleTogglePush = (nextVal: boolean) => {
    updateSettings({ pushEnabled: nextVal });
    buzz();
    const gen = ++pushSyncGen.current;
    InteractionManager.runAfterInteractions(() => {
      void (async () => {
        try {
          if (!Device.isDevice || !isPushConfigured()) return;
          const token = await getPushToken();
          if (gen !== pushSyncGen.current) return;
          if (!token) {
            if (nextVal) {
              updateSettings({ pushEnabled: false });
              Alert.alert(
                'Notifications are off',
                'Allow notifications for Tea in system settings to turn this on.',
              );
            }
            return;
          }
          if (nextVal) await datingApi.registerDevice(token, Platform.OS);
          else await datingApi.unregisterDevice(token);
        } catch (e) {
          if (gen !== pushSyncGen.current) return;
          updateSettings({ pushEnabled: !nextVal });
          Alert.alert('Could not update notifications', 'The switch was reverted. Try again.');
          if (__DEV__) console.warn('Push toggle error:', e);
        }
      })();
    });
  };

  const handleChooseDmAccess = () => {
    Alert.alert(
      'Direct Message Access',
      'Who can initiate private advice requests with you?',
      [
        {
          text: 'Everyone in Community',
          onPress: () => updateSettings({ dmPermission: 'everyone' }),
        },
        {
          text: 'Followers & Top Advisors Only',
          onPress: () => updateSettings({ dmPermission: 'followers' }),
        },
        { text: 'Cancel', style: 'cancel' },
      ],
    );
  };

  const handleClearCache = () => {
    Alert.alert(
      'Clear App Cache',
      'This will reset cached dilemma feeds, advisor leaderboards, and temporary media so fresh data is loaded from the server.',
      [
        { text: 'Cancel', style: 'cancel' },
        {
          text: 'Clear Cache',
          style: 'destructive',
          onPress: () => {
            qc.clear();
            Alert.alert('Cache Cleared', 'Local data cache has been refreshed from the server.');
          },
        },
      ],
    );
  };

  const handleExportData = () => {
    Alert.alert(
      'Request Personal Archive (GDPR)',
      'Under data privacy regulations, you can request an export archive containing your profile, dilemma posts, comments, and community verdicts.',
      [
        { text: 'Cancel', style: 'cancel' },
        {
          text: 'Request Archive',
          onPress: () => {
            const subject = encodeURIComponent(`Data Export Request [User ID: ${p?.user_id || 'N/A'}]`);
            const body = encodeURIComponent(
              `Hello Tea Privacy Team,\n\nPlease prepare a complete archive of all personal data, dilemma posts, and advice records associated with my account.\n\nUser ID: ${p?.user_id || 'N/A'}\nHandle: @${p?.handle || 'N/A'}\nEmail: ${p?.email || 'N/A'}`
            );
            Linking.openURL(`mailto:privacy@teadating.app?subject=${subject}&body=${body}`).catch(() => {
              Alert.alert('Request Noted', 'Please email privacy@teadating.app to process your data export request.');
            });
          },
        },
      ],
    );
  };

  const contactSupport = () => {
    const url = 'mailto:support@teadating.app?subject=Tea%20Dating%20Advice%20Support';
    Linking.openURL(url).catch(() => {
      Alert.alert(
        'Contact Support',
        'You can reach our team anytime by emailing support@teadating.app.',
      );
    });
  };

  const reportBug = () => {
    const subject = encodeURIComponent(`Tea App Bug Report [${Platform.OS.toUpperCase()}]`);
    const diagnostics = `\n\n--- System Diagnostics ---\nPlatform: ${Platform.OS}\nApp Version: 1.0.0\nUser ID: ${p?.user_id || 'N/A'}\nHandle: @${p?.handle || 'N/A'}\nMode: ${isFixtureMode() ? 'Offline Demo' : 'Live BFF'}\nBFF URL: ${BFF_API_URL}`;
    const body = encodeURIComponent(`Please describe the issue you encountered:\n\n[Describe what happened here]${diagnostics}`);
    Linking.openURL(`mailto:support@teadating.app?subject=${subject}&body=${body}`).catch(() => {
      Alert.alert('Report an Issue', 'Please email support@teadating.app with details of the issue.');
    });
  };

  const sendReset = (email: string, purpose: 'reset' | 'set') => {
    const title = purpose === 'set' ? 'Set a password' : 'Reset password';
    Alert.alert(
      title,
      `We’ll email a reset code to ${email}.`,
      [
        { text: 'Cancel', style: 'cancel' },
        {
          text: 'Send code',
          onPress: async () => {
            try {
              await reset.mutateAsync(email);
              setResetSent(true);
              Alert.alert('Code sent', 'Check your inbox for the reset code.', [
                {
                  text: 'Enter code',
                  onPress: () => router.push({ pathname: '/reset-password', params: { email } }),
                },
              ]);
            } catch (e) {
              Alert.alert('Could not send', e instanceof Error ? e.message : 'Try again');
            }
          },
        },
      ],
    );
  };

  const deleteAccount = () =>
    Alert.alert(
      'Delete account?',
      'All your spilled advice posts, verdicts, and messages will be permanently deleted.',
      [
        { text: 'Cancel', style: 'cancel' },
        {
          text: 'Delete',
          style: 'destructive',
          onPress: async () => {
            try {
              await del.mutateAsync();
              await clearTokens();
              qc.clear();
              qc.setQueryData(queryKeys.session, { hasToken: false });
              router.replace('/welcome');
            } catch (e) {
              Alert.alert('Could not delete', e instanceof Error ? e.message : 'Try again');
            }
          },
        },
      ],
    );

  if (me.isLoading) return <LoadingState message="Loading settings..." />;
  const p = me.data;
  const realEmail = p && !isSyntheticEmail(p.email);

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
          <Text className="text-xl font-black text-black">Settings</Text>
        </View>

        <View className="bg-black px-2 py-0.5 rounded-[2px]">
          <Text className="text-[10px] font-black uppercase text-white">Tea App</Text>
        </View>
      </View>

      <ScrollView
        showsVerticalScrollIndicator={false}
        contentContainerStyle={{ padding: 20, paddingBottom: insets.bottom + 40 }}>
        {/* Community Guidelines */}
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
            <Ionicons name="shield-checkmark" size={18} color="#000" />
            <Text className="text-xs font-black uppercase text-black">Community Trust & Privacy</Text>
          </View>
          <Text className="text-xs text-black font-medium leading-relaxed">
            • Candid, supportive dating advice and honest dilemma verdicts.{'\n'}
            • Privacy-first: permissionless system photo picker protects your media.{'\n'}
            • Respectful community: harassment and toxic behavior are strictly moderated.
          </Text>
        </View>

        {/* 1. Account Section */}
        <Text className="text-xs font-black uppercase tracking-wider text-black mb-2">Account</Text>
        <BrutalCard variant="white" className="mb-5 p-0 overflow-hidden">
          <BrutalRow
            label="Username / Handle"
            value={p?.handle ? `@${p.handle}` : '@advisor'}
          />
          <BrutalRow
            label="Email"
            value={realEmail ? p?.email : 'None'}
          />
          <BrutalRow
            label="Phone Number"
            value={p?.phone || 'Not linked'}
            hint="Used for SMS recovery & account protection"
            onPress={() =>
              Alert.alert(
                'Phone Security',
                p?.phone
                  ? `Your phone number (${p.phone}) is linked to your account.`
                  : 'Phone login can be set up using SMS verification on supported mobile networks.',
              )
            }
          />
          <BrutalRow
            label="Account ID"
            value={p?.user_id ? `${p.user_id.slice(0, 8)}...` : 'Unknown'}
            hint="Tap to view your unique system user identifier"
            onPress={() =>
              Alert.alert(
                'Account ID',
                `Your unique Account ID is:\n\n${p?.user_id || 'N/A'}\n\nProvide this ID when contacting support or requesting data archive assistance.`,
              )
            }
          />
          <BrutalRow
            label="Verified Age & Birthday"
            value={p?.age ? `${p.age} yrs · Verified` : (p?.birthday ? `${p.birthday} · Verified` : '18+ Verified')}
            hint="Enforcing strict adult community standards"
          />
          <BrutalRow
            label="Edit Profile & Bio"
            hint="Update your display moniker, bio, city & avatar photo"
            onPress={() => router.push('/(app)/edit-profile')}
          />
        </BrutalCard>

        {/* 2. Feed & Advice Preferences */}
        <Text className="text-xs font-black uppercase tracking-wider text-black mb-2">
          Feed & Advice Preferences
        </Text>
        <BrutalCard variant="white" className="mb-5 p-0 overflow-hidden">
          <BrutalRow
            label="Dilemma Topics & Specialties"
            value={p?.specialty || `${p?.interests?.length || 0} topics`}
            hint="Select favorite categories to shape your feed"
            onPress={() => router.push('/(app)/preferences')}
          />
          <BrutalRow
            label="Advice Locale / City"
            value={p?.city || 'Global'}
            hint="Filter nearby dilemma discussions"
            onPress={() => router.push('/(app)/preferences')}
          />
          <BrutalToggleRow
            label="Blur Sensitive Dilemmas"
            hint="Require tap to reveal dilemmas containing sensitive themes"
            value={settings.sensitiveContentFilter}
            onValueChange={(val) => handleToggle({ sensitiveContentFilter: val })}
          />
        </BrutalCard>

        {/* 3. Notifications & Alerts */}
        <Text className="text-xs font-black uppercase tracking-wider text-black mb-2">
          Notifications & Alerts
        </Text>
        <BrutalCard variant="white" className="mb-5 p-0 overflow-hidden">
          <BrutalToggleRow
            label="Push Notifications"
            hint="Get alerts for advice replies and fan requests"
            value={settings.pushEnabled}
            onValueChange={handleTogglePush}
          />
          <BrutalToggleRow
            label="Dilemma Verdict Alerts"
            hint="Notify when community votes on your dilemmas"
            value={settings.verdictAlerts}
            onValueChange={(val) => handleToggle({ verdictAlerts: val })}
          />
          <BrutalToggleRow
            label="Advisor Message Alerts"
            hint="Notify for 1-on-1 private advice replies"
            value={settings.dmAlerts}
            onValueChange={(val) => handleToggle({ dmAlerts: val })}
          />
          <BrutalToggleRow
            label="Haptic & Touch Feedback"
            hint="Tactile vibrations on verdicts and actions"
            value={settings.hapticsEnabled}
            onValueChange={(val) => handleToggle({ hapticsEnabled: val })}
          />
        </BrutalCard>

        {/* 4. Privacy & Safety */}
        <Text className="text-xs font-black uppercase tracking-wider text-black mb-2">
          Privacy & Communication
        </Text>
        <BrutalCard variant="white" className="mb-5 p-0 overflow-hidden">
          <BrutalRow
            label="Direct Message Access"
            value={settings.dmPermission === 'everyone' ? 'Everyone' : 'Followers Only'}
            hint="Control who can message you directly"
            onPress={handleChooseDmAccess}
          />
          <BrutalRow
            label="Blocked Users"
            value={`${blocked.data?.length ?? 0} Blocked`}
            hint="Manage blocked profiles"
            onPress={() => router.push('/(app)/blocked')}
          />
          <BrutalRow
            label="Request Personal Data (GDPR)"
            hint="Receive an archive of your profile, posts & verdicts"
            onPress={handleExportData}
          />
          <BrutalRow
            label="18+ Adult Policy"
            value="Enforced"
            hint="Minors strictly prohibited"
          />
        </BrutalCard>

        {/* 5. Security */}
        <Text className="text-xs font-black uppercase tracking-wider text-black mb-2">Security</Text>
        <BrutalCard variant="white" className="mb-5 p-0 overflow-hidden">
          {p?.has_password ? (
            <BrutalRow
              label="Change Password"
              onPress={() => router.push('/(app)/change-password')}
            />
          ) : null}
          {realEmail ? (
            <BrutalRow
              label={p?.has_password ? 'Reset Password' : 'Set Password'}
              hint="We will email a reset code"
              value={resetSent ? 'Sent' : undefined}
              onPress={() => sendReset(p?.email || '', p?.has_password ? 'reset' : 'set')}
            />
          ) : null}
          <BrutalRow
            label="Enter Reset Code"
            onPress={() =>
              router.push({
                pathname: '/reset-password',
                params: realEmail ? { email: p?.email } : {},
              })
            }
          />
          <BrutalRow
            label="Active Device Session"
            value="Current Device"
            hint="Access token stored securely in device keychain"
            onPress={() => {
              Alert.alert(
                'Active Session',
                `Logged in on ${Platform.OS === 'android' ? 'Android' : Platform.OS === 'ios' ? 'iOS' : 'Web/Expo'}.\n\nTokens are cryptographically secured using hardware-backed SecureStore.`,
                [
                  { text: 'Close', style: 'cancel' },
                  { text: 'Sign Out Session', style: 'destructive', onPress: signOut },
                ],
              );
            }}
          />
        </BrutalCard>

        {/* 6. Help, Support & Diagnostics */}
        <Text className="text-xs font-black uppercase tracking-wider text-black mb-2">
          Help, Support & Diagnostics
        </Text>
        <BrutalCard variant="white" className="mb-5 p-0 overflow-hidden">
          <BrutalRow
            label="Contact Support & Feedback"
            hint="Email the Tea team directly (support@teadating.app)"
            onPress={contactSupport}
          />
          <BrutalRow
            label="Report a Problem / Bug"
            hint="Send diagnostic details to developer team"
            onPress={reportBug}
          />
          <BrutalRow
            label="Clear App Cache"
            hint="Reset cached dilemma queries and local images"
            onPress={handleClearCache}
          />
          <BrutalRow
            label="Connection Mode"
            value={isFixtureMode() ? 'Offline Demo' : 'Live BFF'}
            hint={isFixtureMode() ? 'Serving local fixtures' : 'Connected to Actix-web backend'}
          />
        </BrutalCard>

        {/* 7. Safety & Legal */}
        <Text className="text-xs font-black uppercase tracking-wider text-black mb-2">Safety & Policy</Text>
        <BrutalCard variant="white" className="mb-5 p-0 overflow-hidden">
          <BrutalRow
            label="Privacy Policy"
            onPress={() => Linking.openURL(`${BFF_API_URL}/api/v1/legal/privacy`)}
          />
          <BrutalRow
            label="Terms of Service"
            onPress={() => Linking.openURL(`${BFF_API_URL}/api/v1/legal/terms`)}
          />
          <BrutalRow
            label="Safety Standards & CSAE Policy"
            onPress={() => Linking.openURL(`${BFF_API_URL}/api/v1/legal/safety`)}
          />
          <BrutalRow
            label="Web Deletion Portal"
            onPress={() => Linking.openURL(`${BFF_API_URL}/api/v1/legal/delete-account`)}
          />
        </BrutalCard>

        {/* 8. Session Actions */}
        <View className="gap-3 mt-2">
          <BrutalButton
            label="Sign Out"
            variant="paper"
            onPress={signOut}
          />

          <Pressable
            onPress={deleteAccount}
            className="h-11 bg-white border-2 border-tea-red rounded-[3px] items-center justify-center active:translate-y-0.5"
            style={{
              shadowColor: '#cc6b49',
              shadowOffset: { width: -2, height: 3 },
              shadowOpacity: 1,
              shadowRadius: 0,
              elevation: 2,
            }}>
            <Text className="text-xs font-black uppercase text-tea-red">Delete Account</Text>
          </Pressable>
        </View>

        <View className="mt-8 items-center justify-center">
          <Text className="text-xs font-black uppercase text-black">Tea Dating Advice</Text>
          <Text className="text-[10px] font-bold text-[#666]">v1.0.0 • Neo-Brutalist Dating Advice</Text>
          <Text className="text-[9px] font-semibold text-[#888] mt-0.5">
            Running on {Platform.OS} · Zero Media Permissions
          </Text>
        </View>
      </ScrollView>
    </View>
  );
}

function slideSwitch(anim: Animated.Value, on: boolean) {
  Animated.spring(anim, {
    toValue: on ? 20 : 0,
    bounciness: 4,
    speed: 22,
    useNativeDriver: true,
  }).start();
}

function BrutalSwitch({ on, translateX }: { on: boolean; translateX: Animated.Value }) {
  return (
    <View
      pointerEvents="none"
      style={{
        width: 44,
        height: 24,
        borderRadius: 12,
        borderWidth: 2,
        borderColor: '#000000',
        backgroundColor: on ? '#73BDA8' : '#DFDFDF',
        justifyContent: 'center',
        paddingHorizontal: 2,
      }}>
      <Animated.View
        style={{
          width: 16,
          height: 16,
          borderRadius: 8,
          borderWidth: 1.5,
          borderColor: '#000000',
          backgroundColor: '#FFFFFF',
          transform: [{ translateX }],
        }}
      />
    </View>
  );
}

function BrutalToggleRow({
  label,
  hint,
  value,
  onValueChange,
  disabled,
}: {
  label: string;
  hint?: string;
  value: boolean;
  onValueChange: (v: boolean) => void;
  disabled?: boolean;
}) {
  const displayed = useRef(value);
  const [on, setOn] = useState(value);
  const translateX = useRef(new Animated.Value(value ? 20 : 0)).current;

  useEffect(() => {
    if (displayed.current === value) return;
    displayed.current = value;
    setOn(value);
    slideSwitch(translateX, value);
  }, [translateX, value]);

  const toggle = () => {
    if (disabled) return;
    const next = !displayed.current;
    displayed.current = next;
    setOn(next);
    slideSwitch(translateX, next);
    onValueChange(next);
  };

  return (
    <Pressable
      unstable_pressDelay={0}
      onPress={toggle}
      disabled={disabled}
      className="flex-row items-center justify-between p-3.5 border-b border-black/10 last:border-b-0 active:bg-black/[0.03]"
      style={{ opacity: disabled ? 0.6 : 1 }}>
      <View className="flex-1 pr-3">
        <Text className="text-xs font-black text-black">{label}</Text>
        {hint ? <Text className="text-[10px] font-semibold text-[#666] mt-0.5">{hint}</Text> : null}
      </View>
      <BrutalSwitch on={on} translateX={translateX} />
    </Pressable>
  );
}

function BrutalRow({
  label,
  value,
  hint,
  onPress,
}: {
  label: string;
  value?: string;
  hint?: string;
  onPress?: () => void;
}) {
  return (
    <Pressable
      onPress={onPress}
      disabled={!onPress}
      className="flex-row items-center justify-between p-3.5 border-b border-black/10 last:border-b-0 active:bg-[#ece6c2]/40">
      <View className="flex-1 pr-3">
        <Text className="text-xs font-black text-black">{label}</Text>
        {hint ? <Text className="text-[10px] font-semibold text-[#666] mt-0.5">{hint}</Text> : null}
      </View>
      <View className="flex-row items-center gap-2">
        {value ? (
          <Text className="text-xs font-bold text-[#444]">{value}</Text>
        ) : null}
        {onPress ? <Feather name="chevron-right" size={16} color="#000" /> : null}
      </View>
    </Pressable>
  );
}
