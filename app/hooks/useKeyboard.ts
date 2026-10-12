import { useKeyboardState } from 'react-native-keyboard-controller';

export function useKeyboard() {
  const keyboardHeight = useKeyboardState((state) => state.height);
  const isKeyboardVisible = useKeyboardState((state) => state.isVisible);

  return { keyboardHeight, isKeyboardVisible };
}

