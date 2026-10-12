export { brand, colors } from '@/constants/brand';

/**
 * Neo-Brutalist Avatar Palette:
 * Bold, high-energy retro colors used to seed permanent user avatars.
 */
export const BRUTALIST_AVATAR_PALETTE = [
  { bg: '#73BDA8', text: '#020202', accent: '#0EA8FF' }, // Mint
  { bg: '#32B5FF', text: '#020202', accent: '#CC6B49' }, // Cyan Blue
  { bg: '#CC6B49', text: '#FFFFFF', accent: '#73BDA8' }, // Terracotta
  { bg: '#E28D38', text: '#020202', accent: '#0EA8FF' }, // Amber
  { bg: '#A378D9', text: '#FFFFFF', accent: '#ECE6C2' }, // Purple
  { bg: '#FFD166', text: '#020202', accent: '#73BDA8' }, // Golden
  { bg: '#06D6A0', text: '#020202', accent: '#020202' }, // Emerald
  { bg: '#118AB2', text: '#FFFFFF', accent: '#FFD166' }, // Ocean
  { bg: '#EF476F', text: '#FFFFFF', accent: '#ECE6C2' }, // Coral Red
  { bg: '#48CAE4', text: '#020202', accent: '#020202' }, // Sky
] as const;

export const PLACEHOLDER_PALETTE = BRUTALIST_AVATAR_PALETTE.map((p) => p.bg);

export function placeholderColor(seed: string): string {
  let h = 0;
  for (let i = 0; i < seed.length; i++) h = (h * 31 + seed.charCodeAt(i)) >>> 0;
  return PLACEHOLDER_PALETTE[h % PLACEHOLDER_PALETTE.length];
}

export function brutalistAvatarScheme(seed: string) {
  let h = 0;
  for (let i = 0; i < seed.length; i++) h = (h * 31 + seed.charCodeAt(i)) >>> 0;
  return BRUTALIST_AVATAR_PALETTE[h % BRUTALIST_AVATAR_PALETTE.length];
}

export function initials(name: string): string {
  const parts = name.trim().split(/[\s._-]+/).filter(Boolean);
  if (parts.length === 0) return '?';
  if (parts.length === 1) return parts[0].slice(0, 2).toUpperCase();
  return (parts[0][0] + parts[1][0]).toUpperCase();
}

