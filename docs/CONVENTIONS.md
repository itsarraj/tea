# Tea Design System & Code Conventions

This document outlines the visual conventions, tokens, and coding standards used across the Tea codebase.

---

## 1. Visual Language: Neo-Brutalism

Tea's design philosophy rejects subtle skeuomorphism, gentle drop-shadows, and washed-out pastels in favor of high-energy, high-contrast, tactile neo-brutalism:

- **Borders**: Explicit 2px solid black `#000000` borders on interactive controls, cards, headers, and avatars.
- **Shadows**: Zero-blur hard drop shadows.
  - Standard card: `shadowOffset: { width: -1, height: 3 }`, `shadowOpacity: 1`, `shadowRadius: 0`.
  - Buttons: `shadowOffset: { width: -3, height: 4 }`.
- **Canvas**: Vintage warm cream parchment background `#ECE6C2` throughout the application.
- **Typography**: `HankenGrotesk` custom font family:
  - Headers: Heavy weights (`900` Black / `800` ExtraBold) with uppercase emphasis.
  - Body: Medium (`500`) / SemiBold (`600`) with high-contrast `#020202` ink.

---

## 2. Color Palette Tokens (`app/constants/brand.ts`)

| Token | Hex Code | Role |
|---|---|---|
| `canvas` | `#ECE6C2` | Root background screen canvas |
| `mint` | `#73BDA8` | Primary CTA, verified badges, active pill indicators |
| `blue` | `#0EA8FF` | Follow badges, secondary highlights, links |
| `red` | `#CC6B49` | Notification counters, red flag warnings, spicy tags |
| `card` | `#FFFFFF` | Card surfaces and input backgrounds |
| `ink` | `#020202` | High-contrast text and graphic elements |
| `border` | `#000000` | Universal border color |
| `muted` | `#6E6E6E` | Secondary helper descriptions and timestamps |

---

## 3. Engineering & Code Standards

1. **Strict Typing (`types/index.ts`)**:
   - All domain entities (`FeedPost`, `AdvisorPerson`, `StoryItem`, etc.) must be defined in `app/types/index.ts`.
   - Never define ad-hoc interfaces inside fixture files or UI components.

2. **Barrel Exports**:
   - Every component package (`components/tea/`, `components/auth/`) must export its public surface via `index.ts`.

3. **Asset Handling**:
   - Avatars and images must use `mediaUrl(url)` helper to normalize local/remote assets.
   - Deterministic avatar backgrounds ensure every user has a consistent color and glyph before uploading a custom photo.

4. **Safety & Zero Native Crashes**:
   - Never introduce uncompiled native C++/Kotlin libraries into an existing development build without explicit prebuild rebuilds.
   - Fall back gracefully to memory or file-based alternatives when running without specific native hardware.
