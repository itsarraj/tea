import * as FileSystem from 'expo-file-system/legacy';

export type UserAppSettings = {
  pushEnabled: boolean;
  verdictAlerts: boolean;
  dmAlerts: boolean;
  dmPermission: 'everyone' | 'followers';
  sensitiveContentFilter: boolean;
  hapticsEnabled: boolean;
};

const SETTINGS_FILE = (FileSystem.documentDirectory ?? '') + 'tea_user_settings.json';

export const DEFAULT_APP_SETTINGS: UserAppSettings = {
  pushEnabled: true,
  verdictAlerts: true,
  dmAlerts: true,
  dmPermission: 'everyone',
  sensitiveContentFilter: false,
  hapticsEnabled: true,
};

let inMemorySettings: UserAppSettings = { ...DEFAULT_APP_SETTINGS };
let isInitialized = false;
let pendingPatch: Partial<UserAppSettings> | null = null;

function persistSettings(): void {
  void FileSystem.writeAsStringAsync(SETTINGS_FILE, JSON.stringify(inMemorySettings)).catch(() => {
    /* file persistence fallback */
  });
}

export function getAppSettingsSync(): UserAppSettings {
  return inMemorySettings;
}

export async function getAppSettings(): Promise<UserAppSettings> {
  if (isInitialized) return inMemorySettings;
  try {
    const fileInfo = await FileSystem.getInfoAsync(SETTINGS_FILE);
    if (fileInfo.exists) {
      const raw = await FileSystem.readAsStringAsync(SETTINGS_FILE);
      if (raw) {
        inMemorySettings = { ...DEFAULT_APP_SETTINGS, ...JSON.parse(raw) };
      }
    }
  } catch {
    /* keep the in-memory copy */
  }
  if (pendingPatch) {
    inMemorySettings = { ...inMemorySettings, ...pendingPatch };
    pendingPatch = null;
    persistSettings();
  }
  isInitialized = true;
  return inMemorySettings;
}

export async function saveAppSettings(patch: Partial<UserAppSettings>): Promise<UserAppSettings> {
  inMemorySettings = { ...inMemorySettings, ...patch };
  if (!isInitialized) {
    pendingPatch = { ...(pendingPatch ?? {}), ...patch };
  }
  persistSettings();
  return inMemorySettings;
}
