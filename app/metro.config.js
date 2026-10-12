const { getDefaultConfig } = require('expo/metro-config');
const { withNativeWind } = require('nativewind/metro');
const { exec } = require('child_process');

try {
  exec('adb reverse tcp:8081 tcp:8081; adb reverse tcp:8000 tcp:8000; adb reverse tcp:8001 tcp:8001', () => {});
} catch {}

const config = getDefaultConfig(__dirname);
module.exports = withNativeWind(config, { input: './global.css' });

