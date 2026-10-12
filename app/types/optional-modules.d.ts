/**
 * Minimal fallback typings for Expo modules that are declared in package.json
 * but may not be installed yet (TypeScript prefers the real package types once
 * `bun install` has run — ambient declarations are only used when module
 * resolution fails). Keep these in sync with the subset used in lib/native.ts.
 */

declare module 'expo-image-picker' {
  export type ImagePickerAsset = {
    uri: string;
    width: number;
    height: number;
    mimeType?: string;
    fileName?: string | null;
  };
  export type ImagePickerResult = { canceled: boolean; assets: ImagePickerAsset[] | null };
  export type ImagePickerOptions = {
    mediaTypes?: ('images' | 'videos' | 'livePhotos')[] | string;
    allowsEditing?: boolean;
    aspect?: [number, number];
    quality?: number;
    allowsMultipleSelection?: boolean;
    selectionLimit?: number;
  };
  export function requestMediaLibraryPermissionsAsync(): Promise<{ granted: boolean; status: string }>;
  export function requestCameraPermissionsAsync(): Promise<{ granted: boolean; status: string }>;
  export function launchImageLibraryAsync(options?: ImagePickerOptions): Promise<ImagePickerResult>;
  export function launchCameraAsync(options?: ImagePickerOptions): Promise<ImagePickerResult>;
}

declare module 'expo-location' {
  export enum Accuracy {
    Lowest = 1,
    Low = 2,
    Balanced = 3,
    High = 4,
    Highest = 5,
    BestForNavigation = 6,
  }
  export type LocationObject = {
    coords: { latitude: number; longitude: number; accuracy: number | null };
    timestamp: number;
  };
  export type LocationGeocodedAddress = {
    city: string | null;
    district: string | null;
    subregion: string | null;
    region: string | null;
    country: string | null;
  };
  export function requestForegroundPermissionsAsync(): Promise<{ granted: boolean; status: string }>;
  export function getCurrentPositionAsync(options?: { accuracy?: Accuracy }): Promise<LocationObject>;
  export function getLastKnownPositionAsync(): Promise<LocationObject | null>;
  export function reverseGeocodeAsync(location: {
    latitude: number;
    longitude: number;
  }): Promise<LocationGeocodedAddress[]>;
}

declare module 'expo-notifications' {
  export type NotificationBehavior = {
    shouldShowAlert?: boolean;
    shouldShowBanner?: boolean;
    shouldShowList?: boolean;
    shouldPlaySound: boolean;
    shouldSetBadge: boolean;
  };
  export function setNotificationHandler(handler: {
    handleNotification: () => Promise<NotificationBehavior>;
  } | null): void;
  export function getPermissionsAsync(): Promise<{ granted: boolean; status: string }>;
  export function requestPermissionsAsync(): Promise<{ granted: boolean; status: string }>;
  export function getExpoPushTokenAsync(options?: { projectId?: string }): Promise<{ data: string }>;
  export enum AndroidImportance {
    DEFAULT = 3,
    HIGH = 4,
    MAX = 5,
  }
  export function setNotificationChannelAsync(
    channelId: string,
    channel: { name: string; importance: AndroidImportance; vibrationPattern?: number[]; lightColor?: string },
  ): Promise<unknown>;
  export type NotificationResponse = {
    notification: { request: { content: { data: Record<string, unknown> } } };
  };
  export function addNotificationResponseReceivedListener(
    listener: (response: NotificationResponse) => void,
  ): { remove: () => void };
}

declare module 'expo-device' {
  export const isDevice: boolean;
}
