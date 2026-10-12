import { Pressable, Text, TextInput, View, type TextInputProps } from 'react-native';
import Svg, { Path } from 'react-native-svg';

type FieldProps = {
  label: string;
  value: string;
  onChangeText: (v: string) => void;
  secure?: boolean;
  onToggleSecure?: () => void;
  placeholder?: string;
  keyboardType?: TextInputProps['keyboardType'];
  autoCapitalize?: TextInputProps['autoCapitalize'];
  right?: React.ReactNode;
};

export function AuthField({
  label,
  value,
  onChangeText,
  secure,
  onToggleSecure,
  placeholder,
  keyboardType,
  autoCapitalize,
  right,
}: FieldProps) {
  return (
    <View className="w-full gap-1">
      <Text className="text-xs font-semibold uppercase tracking-wider text-auth-muted">{label}</Text>
      <View
        className="h-14 flex-row items-center gap-2.5 overflow-hidden rounded-2xl border border-auth-border bg-white px-4">
        <TextInput
          value={value}
          onChangeText={onChangeText}
          secureTextEntry={secure}
          placeholder={placeholder}
          placeholderTextColor="#9EA3AE"
          keyboardType={keyboardType}
          autoCapitalize={autoCapitalize}
          className="flex-1 text-base text-auth-ink"
        />
        {onToggleSecure ? (
          <Pressable onPress={onToggleSecure} hitSlop={8}>
            <Svg width={18} height={18} viewBox="0 0 16 16" fill="none">
              <Path
                d="M7.05671 7.05794C6.8067 7.30804 6.66628 7.64721 6.66634 8.00085C6.6664 8.35448 6.80694 8.6936 7.05704 8.94361C7.30714 9.19362 7.64631 9.33404 7.99994 9.33398C8.35358 9.33392 8.6927 9.19338 8.94271 8.94328M11.1207 11.1154C10.1855 11.7005 9.1031 12.0073 8 12C5.6 12 3.6 10.6667 2 8.00002C2.848 6.58669 3.808 5.54802 4.88 4.88402M6.78667 4.12002C7.18603 4.03917 7.59254 3.99897 8 4.00002C10.4 4.00002 12.4 5.33335 14 8.00002C13.556 8.74002 13.0807 9.37802 12.5747 9.91335M2 2L14 14"
                stroke="#9EA3AE"
                strokeWidth={1.4}
                strokeLinecap="round"
                strokeLinejoin="round"
              />
            </Svg>
          </Pressable>
        ) : null}
        {right}
      </View>
    </View>
  );
}

export function AuthPrimaryButton({
  label,
  onPress,
  disabled,
}: {
  label: string;
  onPress: () => void;
  disabled?: boolean;
}) {
  return (
    <Pressable
      onPress={onPress}
      disabled={disabled}
      className="fz-btn rounded-[32px] w-full px-6 active:opacity-90"
      style={{
        opacity: disabled ? 0.6 : 1,
        shadowColor: '#4B164C',
        shadowOpacity: 0.25,
        shadowRadius: 10,
        shadowOffset: { width: 0, height: 4 },
        elevation: 4,
      }}>
      <Text className="text-base font-semibold text-white">{label}</Text>
    </Pressable>
  );
}

export function AuthSocialButton({
  label,
  onPress,
  icon,
  disabled,
}: {
  label: string;
  onPress: () => void;
  icon: React.ReactNode;
  disabled?: boolean;
}) {
  return (
    <Pressable
      onPress={onPress}
      disabled={disabled}
      className="h-14 w-full flex-row items-center justify-center gap-2.5 rounded-[32px] border border-fz-border bg-white px-6 active:opacity-90"
      style={{
        opacity: disabled ? 0.6 : 1,
        shadowColor: '#000',
        shadowOpacity: 0.04,
        shadowRadius: 4,
        shadowOffset: { width: 0, height: 1 },
      }}>
      {icon}
      <Text className="text-base font-semibold text-fz-plum">{label}</Text>
    </Pressable>
  );
}

export function TeaWordmark() {
  return (
    <View className="flex-row items-center gap-2.5">
      <View className="h-8 w-8 items-center justify-center rounded-lg bg-auth-brand">
        <Text className="text-base font-bold text-white">T</Text>
      </View>
      <Text className="text-lg font-bold text-auth-deep">Tea</Text>
    </View>
  );
}

export function OrDivider() {
  return (
    <View className="w-full flex-row items-center gap-4">
      <View className="h-px flex-1 bg-auth-border" />
      <Text className="text-xs text-auth-muted">Or</Text>
      <View className="h-px flex-1 bg-auth-border" />
    </View>
  );
}

export function RememberMe({
  checked,
  onToggle,
}: {
  checked: boolean;
  onToggle: () => void;
}) {
  return (
    <Pressable onPress={onToggle} className="flex-row items-center gap-[5px]">
      <View
        className="h-5 w-5 items-center justify-center rounded border"
        style={{ borderColor: checked ? '#4B164C' : '#6C7278', backgroundColor: checked ? '#4B164C' : 'transparent' }}>
        {checked ? <Text className="text-xs font-bold text-white">✓</Text> : null}
      </View>
      <Text className="text-xs font-medium text-auth-muted">Remember me</Text>
    </Pressable>
  );
}

export function GoogleIcon({ size = 18 }: { size?: number } = {}) {
  return (
    <Svg width={size} height={size} viewBox="0 0 18 18" fill="none">
      <Path
        d="M16.8758 9.17493C16.8758 8.52743 16.8222 8.05493 16.7061 7.56494H9.1615V10.4874H13.59C13.5008 11.2137 13.0186 12.3074 11.9472 13.0424L11.9322 13.1402L14.3176 14.9513L14.4829 14.9674C16.0007 13.5937 16.8758 11.5724 16.8758 9.17493Z"
        fill="#4285F4"
      />
      <Path
        d="M9.16098 16.8751C11.3306 16.8751 13.152 16.175 14.4824 14.9675L11.9467 13.0425C11.2681 13.5062 10.3574 13.83 9.16098 13.83C7.03601 13.83 5.23246 12.4563 4.58954 10.5575L4.4953 10.5653L2.01486 12.4466L1.98242 12.535C3.30383 15.1075 6.01811 16.8751 9.16098 16.8751Z"
        fill="#34A853"
      />
      <Path
        d="M4.58998 10.5575C4.42034 10.0675 4.32216 9.54245 4.32216 8.99997C4.32216 8.45744 4.42034 7.93246 4.58106 7.44247L4.57656 7.33811L2.06503 5.42664L1.98285 5.46494C1.43824 6.53245 1.12573 7.73123 1.12573 8.99997C1.12573 10.2687 1.43824 11.4674 1.98285 12.5349L4.58998 10.5575Z"
        fill="#FBBC05"
      />
      <Path
        d="M9.16103 4.16998C10.6699 4.16998 11.6878 4.80873 12.2682 5.34251L14.536 3.1725C13.1432 1.90375 11.3306 1.125 9.16103 1.125C6.01814 1.125 3.30384 2.89249 1.98242 5.46497L4.58063 7.44249C5.23248 5.54375 7.03604 4.16998 9.16103 4.16998Z"
        fill="#EB4335"
      />
    </Svg>
  );
}

