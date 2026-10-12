import Constants from 'expo-constants';
import * as Device from 'expo-device';
import * as ImagePicker from 'expo-image-picker';
import * as Location from 'expo-location';
import * as Notifications from 'expo-notifications';
import { Platform } from 'react-native';

export type PickedImage = { uri: string; mimeType?: string; fileName?: string };

/** Opens the gallery (or camera) and returns one cropped image (default 1:1 square for avatars). */
export async function pickPhoto(
  source: 'library' | 'camera' = 'library',
  aspect: [number, number] = [1, 1],
): Promise<PickedImage | null> {
  if (source === 'camera') {
    const perm = await ImagePicker.requestCameraPermissionsAsync();
    if (!perm.granted) throw new Error('Permission to access camera was denied');
  } else if (Platform.OS === 'ios') {
    const perm = await ImagePicker.requestMediaLibraryPermissionsAsync();
    if (!perm.granted) throw new Error('Permission to access photos was denied');
  }

  const opts: ImagePicker.ImagePickerOptions = {
    mediaTypes: ['images'],
    allowsEditing: true,
    aspect,
    quality: 0.85,
  };
  const res =
    source === 'camera' ? await ImagePicker.launchCameraAsync(opts) : await ImagePicker.launchImageLibraryAsync(opts);
  if (res.canceled || !res.assets?.[0]) return null;
  const a = res.assets[0];
  return { uri: a.uri, mimeType: a.mimeType ?? 'image/jpeg', fileName: a.fileName ?? undefined };
}

export type Position = { lat: number; lng: number; city?: string };

/** Asks for foreground location and reverse-geocodes a city name. */
export async function getPosition(): Promise<Position> {
  const perm = await Location.requestForegroundPermissionsAsync();
  if (!perm.granted) throw new Error('Location permission was denied');
  const pos =
    (await Location.getLastKnownPositionAsync()) ??
    (await Location.getCurrentPositionAsync({ accuracy: Location.Accuracy.Balanced }));
  const { latitude: lat, longitude: lng } = pos.coords;
  let city: string | undefined;
  try {
    const [addr] = await Location.reverseGeocodeAsync({ latitude: lat, longitude: lng });
    city = addr?.city ?? addr?.district ?? addr?.subregion ?? addr?.region ?? undefined;
  } catch {
    /* geocoding is best-effort */
  }
  return { lat, lng, city };
}

let handlerInstalled = false;

/** Registers for Expo push and returns the token, or null when unavailable (simulator, denied). */
/** Push needs an EAS project id, and on Android also Firebase (google-services.json). */
export function isPushConfigured(): boolean {
  const cfg = Constants.expoConfig;
  const projectId =
    (cfg?.extra as { eas?: { projectId?: string } } | undefined)?.eas?.projectId ??
    (Constants as unknown as { easConfig?: { projectId?: string } }).easConfig?.projectId;
  if (!projectId) return false;
  if (Platform.OS === 'android' && !cfg?.android?.googleServicesFile) return false;
  return true;
}

let warnedUnconfigured = false;

export async function getPushToken(): Promise<string | null> {
  if (!Device.isDevice) return null;
  if (!isPushConfigured()) {
    // Don't prompt for notification permission when we can't obtain a token anyway.
    if (__DEV__ && !warnedUnconfigured) {
      warnedUnconfigured = true;
      console.log('[push] skipped: set EAS_PROJECT_ID and add google-services.json (Android) to enable push');
    }
    return null;
  }
  if (!handlerInstalled) {
    Notifications.setNotificationHandler({
      handleNotification: async () => ({
        shouldShowAlert: true,
        shouldShowBanner: true,
        shouldShowList: true,
        shouldPlaySound: true,
        shouldSetBadge: false,
      }),
    });
    handlerInstalled = true;
  }
  if (Platform.OS === 'android') {
    await Notifications.setNotificationChannelAsync('default', {
      name: 'Tea',
      importance: Notifications.AndroidImportance.HIGH,
      vibrationPattern: [0, 250, 250, 250],
      lightColor: '#DD88CF',
    });
  }
  let { granted } = await Notifications.getPermissionsAsync();
  if (!granted) granted = (await Notifications.requestPermissionsAsync()).granted;
  if (!granted) return null;

  const projectId =
    (Constants.expoConfig?.extra as { eas?: { projectId?: string } } | undefined)?.eas?.projectId ??
    (Constants as unknown as { easConfig?: { projectId?: string } }).easConfig?.projectId;
  try {
    const { data } = await Notifications.getExpoPushTokenAsync(projectId ? { projectId } : undefined);
    return data;
  } catch (e) {
    if (__DEV__) console.warn('[push] getExpoPushTokenAsync failed', e);
    return null;
  }
}

export function onNotificationOpened(cb: (data: Record<string, unknown>) => void): () => void {
  const sub = Notifications.addNotificationResponseReceivedListener((r) => {
    cb(r.notification.request.content.data ?? {});
  });
  return () => sub.remove();
}
