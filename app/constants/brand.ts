/**
 * Tea Dating Advice - Neo-Brutalism Design Tokens
 * Strictly text-only, high-contrast, black-bordered, hard-shadow aesthetic.
 * Colors extracted from official design HTML:
 * - Canvas: #ECE6C2 (warm vintage brutalist parchment)
 * - Mint: #73BDA8 (primary action, outgoing bubbles, highlights)
 * - Electric Blue: #0EA8FF / #32B5FF / #0E9BEA (badges, follow buttons, unread dots)
 * - Terracotta / Brick Red: #CC6B49 / #D72A2A (notification badges, alerts, spicy tags)
 * - White: #FFFFFF (card surfaces)
 * - Lavender Grey: #DFDFE8 (secondary contrast blocks)
 * - Deep Pitch Black: #020202 / #000000 (text, 2px/3px borders, hard offset shadows)
 * - Muted: #6E6E6E / #727272 / #414141 (secondary text)
 */
export const brand = {
  // === BRAND IDENTITY ===
  canvas: '#ECE6C2',
  mint: '#73BDA8',
  mintDark: '#5EA38F',
  blue: '#0EA8FF',
  blueActive: '#0E9BEA',
  blueCyan: '#32B5FF',
  red: '#CC6B49',
  redDark: '#D72A2A',
  card: '#FFFFFF',
  grey: '#DFDFE8',
  ink: '#020202',
  inkSoft: '#131313',
  muted: '#6E6E6E',
  mutedLight: '#727272',
  border: '#000000',
  borderWidth: 2,

  // Compatibility aliases for existing references
  plum: '#020202',
  pink: '#73BDA8',
  soft: '#ECE6C2',
  white: '#FFFFFF',
  online: '#0EA8FF',
  danger: '#D72A2A',

  // === GEOMETRIC TOKENS ===
  radius: {
    chip: 4,
    control: 8,
    card: 12,
    panel: 16,
    sheet: 24,
    pill: 32,
    full: 9999,
  },

  // === NEO-BRUTALIST HARD SHADOWS (0 blur) ===
  shadow: {
    card: {
      shadowColor: '#000000',
      shadowOffset: { width: -1, height: 3 },
      shadowOpacity: 1,
      shadowRadius: 0,
      elevation: 4,
    },
    cardLg: {
      shadowColor: '#000000',
      shadowOffset: { width: 0, height: 5 },
      shadowOpacity: 1,
      shadowRadius: 0,
      elevation: 6,
    },
    button: {
      shadowColor: '#000000',
      shadowOffset: { width: -3, height: 4 },
      shadowOpacity: 1,
      shadowRadius: 0,
      elevation: 4,
    },
    buttonSm: {
      shadowColor: '#000000',
      shadowOffset: { width: 0, height: 2 },
      shadowOpacity: 1,
      shadowRadius: 0,
      elevation: 2,
    },
    chip: {
      shadowColor: '#000000',
      shadowOffset: { width: 0, height: 1 },
      shadowOpacity: 1,
      shadowRadius: 0,
      elevation: 1,
    },
    bubble: {
      shadowColor: '#000000',
      shadowOffset: { width: -1, height: 2 },
      shadowOpacity: 1,
      shadowRadius: 0,
      elevation: 3,
    },
  },

  // === SPATIAL CONTRACT ===
  size: {
    tap: 44,
    control: 44,
    input: 48,
    tab: 60,
    avatarSm: 32,
    avatarMd: 42,
    avatarLg: 56,
    avatarXl: 72,
    avatarHero: 92,
    icon: 22,
    page: 16,
    storyGap: 12,
    feedCard: 420,
  },
} as const;

export const colors = {
  canvas: brand.canvas,
  mint: brand.mint,
  blue: brand.blue,
  red: brand.red,
  card: brand.card,
  ink: brand.ink,
  muted: brand.muted,
  border: brand.border,
  plum: brand.plum,
  pink: brand.pink,
  soft: brand.soft,
  white: brand.white,
  online: brand.online,
} as const;
