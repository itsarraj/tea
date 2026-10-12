const { withAppBuildGradle } = require('@expo/config-plugins');

/**
 * Expo Config Plugin to inject release signing configuration into android/app/build.gradle.
 * Preserves release keystore signing across `npx expo prebuild --clean`.
 */
const withAndroidReleaseSigning = (config, props = {}) => {
  const prefix = props.prefix || 'TEA_UPLOAD';

  return withAppBuildGradle(config, (modConfig) => {
    if (modConfig.modResults.language !== 'groovy') {
      return modConfig;
    }

    let contents = modConfig.modResults.contents;

    // Return if already configured
    if (contents.includes('signingConfigs {') && contents.includes('release {')) {
      return modConfig;
    }

    // 1. Define release signing config block
    const signingConfigBlock = `
    signingConfigs {
        debug {
            storeFile file('debug.keystore')
            storePassword 'android'
            keyAlias 'androiddebugkey'
            keyPassword 'android'
        }
        release {
            if (project.hasProperty('${prefix}_STORE_FILE')) {
                storeFile file(project.property('${prefix}_STORE_FILE'))
                storePassword project.property('${prefix}_STORE_PASSWORD')
                keyAlias project.property('${prefix}_KEY_ALIAS')
                keyPassword project.property('${prefix}_KEY_PASSWORD')
            }
        }
    }`;

    if (contents.includes('signingConfigs {')) {
      contents = contents.replace(
        /signingConfigs\s*\{[\s\S]*?debug\s*\{[\s\S]*?\}\s*\}/,
        signingConfigBlock,
      );
    } else {
      contents = contents.replace(/android\s*\{/, `android {\n${signingConfigBlock}\n`);
    }

    // 2. Attach release signing config to release build type
    contents = contents.replace(
      /buildTypes\s*\{\s*release\s*\{/,
      `buildTypes {\n        release {\n            signingConfig signingConfigs.release`,
    );

    modConfig.modResults.contents = contents;
    return modConfig;
  });
};

module.exports = withAndroidReleaseSigning;
