import { useQuery, useQueryClient } from '@tanstack/react-query';
import {
  DEFAULT_APP_SETTINGS,
  getAppSettings,
  getAppSettingsSync,
  saveAppSettings,
  UserAppSettings,
} from '@/lib/settings-storage';

export const APP_SETTINGS_QUERY_KEY = ['appSettings'];

export function useAppSettings() {
  const qc = useQueryClient();

  const query = useQuery<UserAppSettings>({
    queryKey: APP_SETTINGS_QUERY_KEY,
    queryFn: getAppSettings,
    placeholderData: DEFAULT_APP_SETTINGS,
    staleTime: Infinity,
  });

  const updateSettings = (patch: Partial<UserAppSettings>) => {
    const previous = qc.getQueryData<UserAppSettings>(APP_SETTINGS_QUERY_KEY) ?? getAppSettingsSync();
    qc.setQueryData<UserAppSettings>(APP_SETTINGS_QUERY_KEY, { ...previous, ...patch });
    void saveAppSettings(patch);
  };

  return {
    settings: query.data ?? DEFAULT_APP_SETTINGS,
    isLoading: query.isLoading,
    updateSettings,
  };
}
