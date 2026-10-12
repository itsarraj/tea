import React, { useEffect, useMemo, useState } from 'react';
import {
  FlatList,
  Modal,
  Pressable,
  Text,
  View,
} from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { Feather, Ionicons } from '@expo/vector-icons';

import { BrutalButton } from '@/components/tea/ui';

export const MONTHS = [
  { value: 1, label: 'Jan', full: 'January' },
  { value: 2, label: 'Feb', full: 'February' },
  { value: 3, label: 'Mar', full: 'March' },
  { value: 4, label: 'Apr', full: 'April' },
  { value: 5, label: 'May', full: 'May' },
  { value: 6, label: 'Jun', full: 'June' },
  { value: 7, label: 'Jul', full: 'July' },
  { value: 8, label: 'Aug', full: 'August' },
  { value: 9, label: 'Sep', full: 'September' },
  { value: 10, label: 'Oct', full: 'October' },
  { value: 11, label: 'Nov', full: 'November' },
  { value: 12, label: 'Dec', full: 'December' },
];

const ITEM_HEIGHT = 42;

export function getDaysInMonth(year: number, month: number): number {
  return new Date(year, month, 0).getDate();
}

export function formatBirthday(isoDate?: string | null): string {
  if (!isoDate) return '';
  const parts = isoDate.split('-');
  if (parts.length !== 3) return isoDate;
  const y = parseInt(parts[0], 10);
  const m = parseInt(parts[1], 10);
  const d = parseInt(parts[2], 10);
  if (!y || !m || !d) return isoDate;
  const mObj = MONTHS.find((item) => item.value === m);
  return `${mObj?.full ?? m} ${d}, ${y}`;
}

export function getAgeFromBirthday(isoDate?: string | null): number | null {
  if (!isoDate) return null;
  const parts = isoDate.split('-');
  if (parts.length !== 3) return null;
  const y = parseInt(parts[0], 10);
  const m = parseInt(parts[1], 10);
  const d = parseInt(parts[2], 10);
  if (!y || !m || !d) return null;
  const now = new Date();
  let age = now.getFullYear() - y;
  const monthDiff = now.getMonth() + 1 - m;
  if (monthDiff < 0 || (monthDiff === 0 && now.getDate() < d)) {
    age--;
  }
  return age;
}

export function isValidBirthday(isoDate?: string | null): boolean {
  const age = getAgeFromBirthday(isoDate);
  return age !== null && age >= 18 && age <= 120;
}

export type TeaBirthdayPickerSheetProps = {
  visible: boolean;
  value?: string;
  onClose: () => void;
  onSelect: (isoDate: string) => void;
};

export function TeaBirthdayPickerSheet({
  visible,
  value,
  onClose,
  onSelect,
}: TeaBirthdayPickerSheetProps) {
  const insets = useSafeAreaInsets();
  const now = new Date();
  const currentYear = now.getFullYear();
  const maxAllowedYear = currentYear - 18;
  const minAllowedYear = currentYear - 100;

  const years = useMemo(() => {
    const arr: number[] = [];
    for (let y = maxAllowedYear; y >= minAllowedYear; y--) {
      arr.push(y);
    }
    return arr;
  }, [maxAllowedYear, minAllowedYear]);

  const parsed = useMemo(() => {
    if (value && /^\d{4}-\d{2}-\d{2}$/.test(value)) {
      const [y, m, d] = value.split('-').map((v) => parseInt(v, 10));
      return { year: y, month: m, day: d };
    }
    return { year: currentYear - 24, month: 6, day: 15 };
  }, [value, currentYear]);

  const [selectedYear, setSelectedYear] = useState(parsed.year);
  const [selectedMonth, setSelectedMonth] = useState(parsed.month);
  const [selectedDay, setSelectedDay] = useState(parsed.day);

  useEffect(() => {
    if (visible) {
      setSelectedYear(parsed.year);
      setSelectedMonth(parsed.month);
      setSelectedDay(parsed.day);
    }
  }, [visible, parsed]);

  const daysInMonth = getDaysInMonth(selectedYear, selectedMonth);
  useEffect(() => {
    if (selectedDay > daysInMonth) {
      setSelectedDay(daysInMonth);
    }
  }, [daysInMonth, selectedDay]);

  const days = useMemo(() => {
    const arr: number[] = [];
    for (let d = 1; d <= daysInMonth; d++) {
      arr.push(d);
    }
    return arr;
  }, [daysInMonth]);

  const age = useMemo(() => {
    let a = currentYear - selectedYear;
    const mDiff = now.getMonth() + 1 - selectedMonth;
    if (mDiff < 0 || (mDiff === 0 && now.getDate() < selectedDay)) {
      a--;
    }
    return a;
  }, [selectedYear, selectedMonth, selectedDay, currentYear]);

  const isOldEnough = age >= 18;

  const handleConfirm = () => {
    if (!isOldEnough) return;
    const mm = String(selectedMonth).padStart(2, '0');
    const dd = String(selectedDay).padStart(2, '0');
    onSelect(`${selectedYear}-${mm}-${dd}`);
    onClose();
  };

  const monthObj = MONTHS.find((m) => m.value === selectedMonth);
  const dateFormatted = `${monthObj?.full ?? ''} ${selectedDay}, ${selectedYear}`;

  const monthIndex = MONTHS.findIndex((m) => m.value === selectedMonth);
  const dayIndex = Math.max(0, selectedDay - 1);
  const yearIndex = Math.max(0, years.indexOf(selectedYear));

  return (
    <Modal visible={visible} transparent animationType="slide" onRequestClose={onClose}>
      <Pressable onPress={onClose} className="flex-1 justify-end bg-black/60">
        <Pressable
          onPress={(e) => e.stopPropagation()}
          className="bg-[#ece6c2] border-t-4 border-black px-5 pt-3"
          style={{
            paddingBottom: Math.max(insets.bottom, 16) + 16,
            shadowColor: '#000',
            shadowOffset: { width: 0, height: -4 },
            shadowOpacity: 0.3,
            shadowRadius: 0,
            elevation: 10,
          }}>
          {/* Neo-brutalist Handle */}
          <View className="mb-3 h-1.5 w-12 self-center rounded-full bg-black" />

          {/* Header */}
          <View className="flex-row items-center justify-between pb-3 pt-1 border-b-2 border-black">
            <View>
              <Text className="text-xl font-black text-black">Select Birth Date</Text>
              <Text className="text-xs font-bold text-[#555]">
                Strict 18+ policy for dating discussions
              </Text>
            </View>
            <Pressable
              onPress={onClose}
              hitSlop={12}
              className="w-9 h-9 items-center justify-center rounded-[2px] bg-white border-2 border-black active:translate-y-0.5"
              style={{
                shadowColor: '#000',
                shadowOffset: { width: -1.5, height: 1.5 },
                shadowOpacity: 1,
                shadowRadius: 0,
                elevation: 2,
              }}>
              <Feather name="x" size={18} color="#000" />
            </Pressable>
          </View>

          {/* Live Preview Card */}
          <View
            className="my-4 flex-row items-center justify-between rounded-[3px] border-2 border-black bg-white p-4"
            style={{
              shadowColor: '#000',
              shadowOffset: { width: -2, height: 2 },
              shadowOpacity: 1,
              shadowRadius: 0,
              elevation: 3,
            }}>
            <View>
              <Text className="text-[10px] font-black uppercase tracking-wider text-[#666]">
                Birth Date
              </Text>
              <Text className="text-base font-black text-black">{dateFormatted}</Text>
            </View>
            <View
              className={`rounded-[2px] border-2 border-black px-3 py-1 flex-row items-center gap-1.5 ${
                isOldEnough ? 'bg-tea-mint' : 'bg-[#cc6b49]'
              }`}>
              <Ionicons
                name={isOldEnough ? 'checkmark-circle' : 'alert-circle'}
                size={14}
                color="#000"
              />
              <Text className="text-xs font-black text-black">
                {isOldEnough ? `${age} years old ☕` : 'Under 18 (Restricted)'}
              </Text>
            </View>
          </View>

          {/* Pickers Header */}
          <View className="flex-row border-b-2 border-black pb-2 mb-1">
            <Text className="flex-[1.2] text-center text-xs font-black uppercase tracking-wider text-black">
              Month
            </Text>
            <Text className="flex-1 text-center text-xs font-black uppercase tracking-wider text-black">
              Day
            </Text>
            <Text className="flex-[1.2] text-center text-xs font-black uppercase tracking-wider text-black">
              Year
            </Text>
          </View>

          {/* 3 Wheel Columns */}
          <View className="h-44 flex-row py-1">
            {/* Month Column */}
            <View className="flex-[1.2] px-1">
              <FlatList
                data={MONTHS}
                keyExtractor={(item) => String(item.value)}
                showsVerticalScrollIndicator={false}
                initialScrollIndex={monthIndex >= 0 ? monthIndex : 0}
                getItemLayout={(_, index) => ({
                  length: ITEM_HEIGHT,
                  offset: ITEM_HEIGHT * index,
                  index,
                })}
                onScrollToIndexFailed={() => {}}
                renderItem={({ item }) => {
                  const active = item.value === selectedMonth;
                  return (
                    <Pressable
                      onPress={() => setSelectedMonth(item.value)}
                      style={{ height: ITEM_HEIGHT }}
                      className={`items-center justify-center rounded-[3px] my-0.5 border ${
                        active
                          ? 'bg-tea-mint border-2 border-black'
                          : 'border-transparent active:bg-white/50'
                      }`}>
                      <Text
                        className={`text-sm ${
                          active ? 'font-black text-black' : 'font-semibold text-[#444]'
                        }`}>
                        {item.label}
                      </Text>
                    </Pressable>
                  );
                }}
              />
            </View>

            {/* Day Column */}
            <View className="flex-1 border-x-2 border-black/30 px-1">
              <FlatList
                data={days}
                keyExtractor={(item) => String(item)}
                showsVerticalScrollIndicator={false}
                initialScrollIndex={dayIndex >= 0 && dayIndex < days.length ? dayIndex : 0}
                getItemLayout={(_, index) => ({
                  length: ITEM_HEIGHT,
                  offset: ITEM_HEIGHT * index,
                  index,
                })}
                onScrollToIndexFailed={() => {}}
                renderItem={({ item }) => {
                  const active = item === selectedDay;
                  return (
                    <Pressable
                      onPress={() => setSelectedDay(item)}
                      style={{ height: ITEM_HEIGHT }}
                      className={`items-center justify-center rounded-[3px] my-0.5 border ${
                        active
                          ? 'bg-tea-mint border-2 border-black'
                          : 'border-transparent active:bg-white/50'
                      }`}>
                      <Text
                        className={`text-sm ${
                          active ? 'font-black text-black' : 'font-semibold text-[#444]'
                        }`}>
                        {item}
                      </Text>
                    </Pressable>
                  );
                }}
              />
            </View>

            {/* Year Column */}
            <View className="flex-[1.2] px-1">
              <FlatList
                data={years}
                keyExtractor={(item) => String(item)}
                showsVerticalScrollIndicator={false}
                initialScrollIndex={yearIndex >= 0 ? yearIndex : 0}
                getItemLayout={(_, index) => ({
                  length: ITEM_HEIGHT,
                  offset: ITEM_HEIGHT * index,
                  index,
                })}
                onScrollToIndexFailed={() => {}}
                renderItem={({ item }) => {
                  const active = item === selectedYear;
                  return (
                    <Pressable
                      onPress={() => setSelectedYear(item)}
                      style={{ height: ITEM_HEIGHT }}
                      className={`items-center justify-center rounded-[3px] my-0.5 border ${
                        active
                          ? 'bg-tea-mint border-2 border-black'
                          : 'border-transparent active:bg-white/50'
                      }`}>
                      <Text
                        className={`text-sm ${
                          active ? 'font-black text-black' : 'font-semibold text-[#444]'
                        }`}>
                        {item}
                      </Text>
                    </Pressable>
                  );
                }}
              />
            </View>
          </View>

          {/* Action CTA */}
          <View className="mt-4">
            <BrutalButton
              label={isOldEnough ? 'Confirm Birthday' : 'Must be 18 or older to join Tea'}
              onPress={handleConfirm}
              disabled={!isOldEnough}
              variant={isOldEnough ? 'mint' : 'paper'}
              size="lg"
            />
          </View>
        </Pressable>
      </Pressable>
    </Modal>
  );
}

export type TeaBirthdayFieldProps = {
  label?: string;
  value: string;
  onChange: (isoDate: string) => void;
  hint?: string;
  placeholder?: string;
  disabled?: boolean;
};

export function TeaBirthdayField({
  label = 'Birthday (18+ Required)',
  value,
  onChange,
  hint,
  placeholder = 'Select your birth date',
  disabled = false,
}: TeaBirthdayFieldProps) {
  const [open, setOpen] = useState(false);
  const formatted = formatBirthday(value);
  const age = getAgeFromBirthday(value);

  return (
    <View className="mb-4">
      {label ? (
        <Text className="text-xs font-black uppercase tracking-wider text-black mb-1.5">
          {label}
        </Text>
      ) : null}

      <Pressable
        onPress={() => !disabled && setOpen(true)}
        disabled={disabled}
        className={`h-12 bg-white border-2 border-black rounded-[3px] px-3.5 flex-row items-center justify-between active:translate-y-0.5 ${
          disabled ? 'opacity-60' : ''
        }`}
        style={{
          shadowColor: '#000',
          shadowOffset: { width: -2, height: 2 },
          shadowOpacity: 1,
          shadowRadius: 0,
          elevation: 2,
        }}>
        <View className="flex-row items-center gap-2">
          {formatted ? (
            <>
              <Text className="text-sm font-bold text-black">{formatted}</Text>
              {age !== null ? (
                <View className="bg-tea-mint border border-black px-2 py-0.5 rounded-[2px]">
                  <Text className="text-[10px] font-black text-black">{age} yrs</Text>
                </View>
              ) : null}
            </>
          ) : (
            <Text className="text-sm font-medium text-[#777]">{placeholder}</Text>
          )}
        </View>

        <Feather name="calendar" size={18} color="#000" />
      </Pressable>

      <Text className="text-[10px] font-bold text-[#666] mt-1">
        {hint || 'Only your age is shown. Strict 18+ policy enforced.'}
      </Text>

      <TeaBirthdayPickerSheet
        visible={open}
        value={value}
        onClose={() => setOpen(false)}
        onSelect={onChange}
      />
    </View>
  );
}
