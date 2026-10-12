# Tea UI Component Catalog

Tea uses a bold Neo-Brutalist design language characterized by:
- Crisp 2px solid black `#000000` borders.
- Zero-blur hard drop shadows (`shadowOffset: { width: -1, height: 3 }`, `shadowOpacity: 1`).
- High-contrast color blocking on a warm vintage canvas `#ECE6C2`.
- Thick brutalist typography with heavy weights (800 / 900).

All core UI components are located in `app/components/tea/` and barrel-exported via `app/components/tea/index.ts`.

---

## Component Index

### 1. `BrutalistAvatar` (`BrutalistAvatar.tsx`)
Deterministic, permanent avatar supporting photos and fallback glyphs.
- **Props**:
  - `seed`: String used to deterministically pick fallback background color and glyph (e.g. user ID or name).
  - `name`: Display name used for fallback initials.
  - `imageUrl` / `photoUrl`: Remote URI (joins with BFF `mediaUrl`).
  - `size`: `'xs'` (28), `'sm'` (36), `'md'` (44), `'lg'` (56), `'xl'` (72), `'hero'` (92), or custom number.
  - `shape`: `'rounded'` (radius 8), `'square'` (radius 0), `'circle'` (radius full).
  - `badge`: `'verified'`, `'advisor'`, `'red_flag'`, `'none'`.
  - `showLock`: Renders brutalist lock overlay for locked advisor profiles.

### 2. `BrutalButton` (`ui.tsx`)
Tactile, tactile-pressed brutalist action button.
- **Variants**:
  - `'primary'` (Mint `#73BDA8` with hard shadow).
  - `'secondary'` (White `#FFFFFF` with black border).
  - `'danger'` (Brick Red `#CC6B49` with white text).
  - `'dark'` (Deep Pitch Black `#020202` with white text).
  - `'accent'` (Electric Blue `#0EA8FF`).
- **Features**: Active scale/translate animation, haptic tap feedback, loading indicator.

### 3. `BrutalCard` (`ui.tsx`)
Card container with 2px black border, solid white background, and brutalist hard shadow.
- **Props**: `children`, `style`, `className`, `onPress`.

### 4. `CategoryPill` (`ui.tsx`)
Horizontal filter pill used in the feed and discovery headers.
- **States**: Inactive (soft cream with 1.5px border), Active (mint background with 2px black border and bold weight).
- **Props**: `label`, `selected`, `onPress`, `count`.

### 5. `QuickNotesRail` (`ui.tsx`)
Horizontal story rail showing user avatars with floating brutalist emoji speech bubbles.
- Supports "+ Your Note" trigger for posting 24-hour status thoughts.

### 6. `QuickNoteModal` (`QuickNoteModal.tsx`)
Bottom sheet / modal for creating or reading quick notes with preset emojis (`✨`, `☕`, `🚩`, `💡`, `💔`, `🔥`, etc.).

### 7. `VerdictVoteBar` (`ui.tsx`)
Interactive verdict breakdown bar for dilemma feed posts.
- Allows readers to cast opinions: `Red Flag 🚩`, `Overreacting 🤔`, `Run 🏃`, `Green Flag 💚`.
- Computes percentage bars with real-time optimistic state.

### 8. `TeaBirthdayPickerSheet` (`TeaBirthdayPicker.tsx`)
Brutalist age gate / birthday picker enforcing minimum 18-year age restriction with custom wheel selector.

### 9. `TeaTabBar` (`TeaTabBar.tsx`)
Custom bottom navigation bar rendered with bold geometric SVG icons and active state highlights.
- Auto-hides on full-screen detail views (`/chat/*`, `/post/*`, `/profile/*`, `/settings`).

### 10. `OfflineBanner` (`OfflineBanner.tsx`)
Z-indexed notification banner that warns when the app operates in offline demo mode with local fixtures.

### 11. State View Components (`ui.tsx`)
- `LoadingState`: Centered brutalist spinner with "Pouring the tea…" message.
- `EmptyState`: Clean empty card with custom icon, title, description, and action button.
- `ErrorState`: Alert box with retry trigger.
