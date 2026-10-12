# Run Tea on a USB Android device

Work from `apps/tea/app`. Phone on USB debugging, `adb devices` shows it as `device`. BFF on `http://127.0.0.1:8000` if you want real API data (see the root README).

The app talks to Metro and the BFF through `adb reverse`, so both stay on `127.0.0.1`. `EXPO_PUBLIC_DEV_TRANSPORT=adb` keeps those localhost URLs. Without it, Android would rewrite them to the emulator host `10.0.2.2`.

## Every time the native build is stale

Run these in order. Each one finishes before you start the next. The third command stays running.

```bash
cd apps/tea/app
bun run android:clean
bun run android:install:adb
bun run dev:android-adb:clear
```

1. `android:clean` runs `./gradlew clean` in `android/`. Use it when the native build is wrong or leftover Gradle output is in the way. The `android/` directory must already exist (`bun run android:rebuild` once if it does not).

2. `android:install:adb` builds the dev client and installs it on the connected device. Metro is not started (`--no-bundler`). `REACT_NATIVE_PACKAGER_HOSTNAME=127.0.0.1` so the installed app looks for the packager on the reversed port, not a LAN address.

3. `dev:android-adb:clear` forwards ports, then starts Metro with a cleared cache:

   - `8081` Metro
   - `8000` BFF
   - `8001` extra local port the reverse script always forwards

   Leave this terminal open. Open Tea on the phone. It should load the bundle from `http://127.0.0.1:8081`.

## Day to day

If the dev client is already installed and you only need a fresh JS bundle:

```bash
bun run dev:android-adb:clear
```

Same thing without wiping the Metro cache: `bun run dev:android-adb`.

If Metro is already running and the app did not open:

```bash
bun run android:open
```

Native logs:

```bash
bun run android:logcat
```

## When this fails

- `adb devices` must list one phone as `device`. Authorize the RSA prompt on the phone if it says `unauthorized`.
- `android:clean` fails with "no such file" when `android/` was never generated. Run `bun run android:rebuild` once, then return to the three commands above.
- A yellow banner in the app means the BFF was not reachable. Start it on port 8000, then run `dev:android-adb:clear` again so `adb reverse` is in place.
