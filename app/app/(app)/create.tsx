import { useEffect } from 'react';
import { ActivityIndicator, View } from 'react-native';
import { router } from 'expo-router';

export default function CreateRedirect() {
  useEffect(() => {
    router.replace('/(app)/new-post');
  }, []);

  return (
    <View className="flex-1 items-center justify-center bg-[#ece6c2]">
      <ActivityIndicator color="#000" />
    </View>
  );
}

