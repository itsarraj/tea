# Tea — Brutalist Dating Advice App

A candid, neo-brutalist dating advice platform where users spill dilemmas, cast community verdicts, and consult top-rated dating advisors. Expo (React Native) app + Rust Actix-web BFF.

## Layout

- `app/` Expo Router client (Expo SDK 52 New Arch, NativeWind, TanStack Query, Reanimated, `react-native-keyboard-controller`)
- `bff/` Actix-web modular monolith: auth, profiles, dilemmas, verdict voting, advisors, 1-on-1 consultations, safety & legal
- `compose.base.yml` + `compose.dev.yml` local Postgres/Redis/BFF
- `compose.prod.yml` + `scripts/vps-deploy.sh` + `deploy/nginx.tea.conf` VPS production deploy
- `ARCHITECTURE.md` System design, data model, API surface
- `docs/play-store-submission.md` Google Play Console submission answers and policy checklists
- `docs/android.md` USB device testing and native debugging guide

## Run locally

Backend (needs Postgres on 5432, Redis optional):

```bash
cd apps/tea/bff
cp .env.example .env            # fill Google client id/secret if you want Google login
createdb auth_kit               # once; migrations run on boot
cargo run                        # http://127.0.0.1:8000/api/v1/health
```

Or in Docker: `docker compose -f compose.base.yml -f compose.dev.yml up --build`
(BFF on 8000, Postgres on 5433, Redis on 6380).

App on a USB Android device (clean, install the dev client, then Metro over adb). Full notes: `docs/android.md`.

```bash
cd apps/tea/app
bun install
bun run android:clean
bun run android:install:adb
bun run dev:android-adb:clear    # Metro over adb reverse (BFF on 127.0.0.1:8000)
```

### Seed Accounts (Password: `demo1234` or `TeaReview2026!`)

- `playstore@teadating.app` (Password: `TeaReview2026!`): Pre-configured Google Play Console QA reviewer account (18+ verified, onboarding complete, top advisor rank, seeded dilemmas and active consultations).
- `marina@teadating.app` (Marina Jose): Top Tea Advisor (Red Flags & First Dates).
- `jack@teadating.app` (Jack James): Senior Advisor (Texting Psychology).
- `demo1@friendzy.local` … `demo24@friendzy.local`: Pre-seeded community profiles.
- Phone login in dev accepts OTP `123456`.

## Release checklist (Android)

1. `bun run keystore` once, then put `TEA_UPLOAD_*` values in `~/.gradle/gradle.properties`.
2. Bump `versionCode`/`versionName` in `android/app/build.gradle` and `version`/`versionCode` in `app.config.js`.
3. `EXPO_PUBLIC_BFF_API_URL=https://tea.kraftisium.xyz bun run android:bundle`
4. Upload `android/app/build/outputs/bundle/release/app-release.aab` to Play Console.
   - Package: `com.kraftisium.tea`
   - Privacy policy URL: `https://tea.kraftisium.xyz/privacy`
   - Account deletion URL: `https://tea.kraftisium.xyz/delete-account`
   - Safety standards URL: `https://tea.kraftisium.xyz/safety`
   - Data safety: Name, email/phone, birthday (18+ only), approximate city locality; **NO photos** (`READ_MEDIA_IMAGES` blocked); account deletion in-app (Settings → Delete account).

## Deploy the BFF

```bash
cp bff/.env.prod.example bff/.env.prod   # on first run the script copies it to the VPS
apps/tea/scripts/vps-deploy.sh --tag v1.0.0
```

The image is built locally, shipped over ssh, and rolled out with `compose.prod.yml`
(subnet `172.31.44.0/24`; BFF on host port 8014; RustFS on host port 9014; nginx terminates TLS —
see `deploy/nginx.tea.conf`).

## Configuration

All BFF settings live in `bff/configuration.yaml` and can be overridden with `BFF__SECTION__KEY` env vars.
Key sections: `database`, `jwt`, `storage`, `sms`, `push`, `rate_limit`, `legal`. See `bff/.env.example` for all keys.
