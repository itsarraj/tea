const fs = require('fs');

const IS_DEV = process.env.APP_VARIANT === 'development';

/** @type {import('expo/config').ExpoConfig} */
module.exports = () => ({
  name: IS_DEV ? 'Tea Dating Advice (Dev)' : 'Tea Dating Advice',
  slug: IS_DEV ? 'tea-dating-advice-dev' : 'tea-dating-advice',
  version: '1.0.1',
  orientation: 'portrait',
  scheme: IS_DEV ? 'teadev' : 'tea',
  userInterfaceStyle: 'light',
  icon: './assets/icon.png',
  splash: {
    image: './assets/splash-icon.png',
    resizeMode: 'contain',
    backgroundColor: '#ece6c2',
  },
  ios: {
    supportsTablet: false,
    bundleIdentifier: IS_DEV ? 'com.kraftisium.tea.dev' : 'com.kraftisium.tea',
    buildNumber: '2',
    infoPlist: {
      NSLocationWhenInUseUsageDescription: 'Tea uses your location to display local dating advice.',
    },
  },
  android: {
    package: IS_DEV ? 'com.kraftisium.tea.dev' : 'com.kraftisium.tea',
    versionCode: 2,
    adaptiveIcon: {
      foregroundImage: './assets/adaptive-icon.png',
      backgroundColor: '#020202',
    },
    permissions: [
      'android.permission.ACCESS_COARSE_LOCATION',
      'android.permission.ACCESS_FINE_LOCATION',
      'android.permission.POST_NOTIFICATIONS',
      'android.permission.VIBRATE',
    ],
    blockedPermissions: [
      'android.permission.CAMERA',
      'android.permission.RECORD_AUDIO',
      'android.permission.ACCESS_BACKGROUND_LOCATION',
      'android.permission.READ_MEDIA_IMAGES',
      'android.permission.READ_MEDIA_VIDEO',
      'android.permission.READ_MEDIA_VISUAL_USER_SELECTED',
      'android.permission.READ_EXTERNAL_STORAGE',
      'android.permission.WRITE_EXTERNAL_STORAGE',
    ],
    googleServicesFile: process.env.GOOGLE_SERVICES_JSON || (fs.existsSync('./google-services.json') ? './google-services.json' : undefined),
  },
  web: {
    bundler: 'metro',
  },
  plugins: [
    'expo-router',
    'expo-secure-store',
    ['expo-dev-client', { addGeneratedScheme: !!IS_DEV }],
    [
      './plugins/signing-config.js',
      { prefix: 'TEA_UPLOAD' },
    ],
    [
      'expo-font',
      {
        fonts: [
          './assets/fonts/HankenGrotesk-Regular.ttf',
          './assets/fonts/HankenGrotesk-Medium.ttf',
          './assets/fonts/HankenGrotesk-SemiBold.ttf',
          './assets/fonts/HankenGrotesk-Bold.ttf',
          './assets/fonts/HankenGrotesk-ExtraBold.ttf',
          './assets/fonts/HankenGrotesk-Light.ttf',
        ],
      },
    ],
    ['expo-location', { locationWhenInUsePermission: 'Tea uses your location to show local dating advice.', isAndroidBackgroundLocationEnabled: false }],
    ['expo-notifications', { color: '#73bda8' }],
  ],
  experiments: {
    typedRoutes: true,
  },
  extra: {
    bffApiUrl: process.env.EXPO_PUBLIC_BFF_API_URL?.trim() || 'https://tea.kraftisium.xyz',
    eas: process.env.EAS_PROJECT_ID ? { projectId: process.env.EAS_PROJECT_ID } : undefined,
  },
});

