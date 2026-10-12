import React from 'react';
import { StyleSheet, type StyleProp, type TextStyle } from 'react-native';

const FONT_MAP: Record<string, string> = {
  '100': 'HankenGrotesk-Thin',
  '200': 'HankenGrotesk-Light',
  '300': 'HankenGrotesk-Light',
  '400': 'HankenGrotesk-Regular',
  normal: 'HankenGrotesk-Regular',
  '500': 'HankenGrotesk-Medium',
  '600': 'HankenGrotesk-SemiBold',
  '700': 'HankenGrotesk-Bold',
  bold: 'HankenGrotesk-Bold',
  '800': 'HankenGrotesk-ExtraBold',
  '900': 'HankenGrotesk-Black',
};

/**
 * Ensures any style applied to Text or TextInput uses the appropriate Hanken Grotesk weight.
 * Explicit custom fonts (like vector icon families) are strictly preserved.
 */
export function resolveHankenFont(style: StyleProp<TextStyle>): StyleProp<TextStyle> {
  if (!style) {
    return { fontFamily: 'HankenGrotesk-Regular' };
  }

  const flat = StyleSheet.flatten(style);
  if (!flat) {
    return { fontFamily: 'HankenGrotesk-Regular' };
  }

  // Preserve explicit font families (e.g., Ionicons, MaterialIcons, or already resolved fonts)
  if (flat.fontFamily) {
    return style;
  }

  const weight = flat.fontWeight ? String(flat.fontWeight) : 'normal';
  const targetFont = FONT_MAP[weight] || 'HankenGrotesk-Regular';

  if (Array.isArray(style)) {
    return [...style, { fontFamily: targetFont }];
  }
  return [style, { fontFamily: targetFont }];
}

// Apply runtime patches to React Native and react-native-css-interop
(function initFontPatch() {
  try {
    const RN = require('react-native');
    const OriginalText = RN.Text;
    const OriginalTextInput = RN.TextInput;

    if (!OriginalText || (OriginalText as any).__hankenPatched) {
      return;
    }

    const PatchedText = React.forwardRef<any, any>((props, ref) => {
      const finalStyle = resolveHankenFont(props?.style);
      return React.createElement(OriginalText, { ...props, style: finalStyle, ref });
    });
    (PatchedText as any).__hankenPatched = true;
    (PatchedText as any).displayName = 'Text';

    Object.defineProperty(RN, 'Text', {
      value: PatchedText,
      configurable: true,
      writable: true,
      enumerable: true,
    });

    const PatchedTextInput = React.forwardRef<any, any>((props, ref) => {
      const finalStyle = resolveHankenFont(props?.style);
      return React.createElement(OriginalTextInput, { ...props, style: finalStyle, ref });
    });
    (PatchedTextInput as any).__hankenPatched = true;
    Object.assign(PatchedTextInput, OriginalTextInput);
    (PatchedTextInput as any).displayName = 'TextInput';

    Object.defineProperty(RN, 'TextInput', {
      value: PatchedTextInput,
      configurable: true,
      writable: true,
      enumerable: true,
    });

    // Register with react-native-css-interop if present
    try {
      const interop = require('react-native-css-interop');
      if (interop?.cssInterop) {
        interop.cssInterop(PatchedText, { className: 'style' });
        interop.cssInterop(PatchedTextInput, {
          className: { target: 'style', nativeStyleToProp: { textAlign: true } },
        });
      }

      // Also wrap existing interop registrations for OriginalText / OriginalTextInput
      const apiNative =
        interop?.interopComponents ||
        (() => {
          try {
            return require('react-native-css-interop/dist/runtime/native/api').interopComponents;
          } catch {
            return null;
          }
        })();

      if (apiNative && typeof apiNative.get === 'function') {
        const origInteropText = apiNative.get(OriginalText);
        if (origInteropText && !(origInteropText as any).__hankenWrapped) {
          const WrappedInteropText = React.forwardRef<any, any>((props, ref) => {
            const finalStyle = resolveHankenFont(props?.style);
            return React.createElement(origInteropText, { ...props, style: finalStyle, ref });
          });
          (WrappedInteropText as any).__hankenWrapped = true;
          (WrappedInteropText as any).displayName = 'CssInterop(PatchedText)';
          apiNative.set(OriginalText, WrappedInteropText);
        }

        const origInteropInput = apiNative.get(OriginalTextInput);
        if (origInteropInput && !(origInteropInput as any).__hankenWrapped) {
          const WrappedInteropInput = React.forwardRef<any, any>((props, ref) => {
            const finalStyle = resolveHankenFont(props?.style);
            return React.createElement(origInteropInput, { ...props, style: finalStyle, ref });
          });
          (WrappedInteropInput as any).__hankenWrapped = true;
          (WrappedInteropInput as any).displayName = 'CssInterop(PatchedTextInput)';
          apiNative.set(OriginalTextInput, WrappedInteropInput);
        }
      }
    } catch {}
  } catch (err) {
    console.warn('[Tea] Failed to initialize font patch:', err);
  }
})();
