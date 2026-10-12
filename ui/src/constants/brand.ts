/** Tea product identity — keep in sync with app/constants/brand.ts */
export const APP_NAME = import.meta.env.VITE_APP_NAME || 'Tea';
export const APP_TAGLINE = 'Brutalist Dating Advice App';
/** Raw mark (transparent, 179×290) — header, footer, inline UI */
export const BRAND_MARK_PATH = '/brand-mark.svg';
/** Centered mark on square canvas (500×500) — app icons, press kit, favicons */
export const LOGO_PATH = '/logo.svg';
/** width / height of brand-mark.svg viewBox */
export const BRAND_MARK_ASPECT = 179 / 290;

/** Tea Neo-Brutalist palette — parchment #ECE6C2, mint #73BDA8, blue #0EA8FF, terracotta #CC6B49, ink #020202 */
export const brandColors = {
  canvas: '#ECE6C2',
  surface: '#FFFFFF',
  mint: '#73BDA8',
  blue: '#0EA8FF',
  terracotta: '#CC6B49',
  border: '#000000',
  text: '#020202',
  muted: '#6E6E6E',
  danger: '#D72A2A',
  success: '#73BDA8',
} as const;

