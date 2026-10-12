# Performance baseline — Auth Kit (seed for future reference doc)

## Client

1. TanStack Query owns server state; SecureStore owns tokens (never put JWTs in Query cache).
2. Single-flight refresh on 401 (`authApi` lock).
3. `refetchOnWindowFocus: false` for auth/me; `staleTime` ≥ 60s for me.
4. Splash until session query settles — no blank flash.
5. Prefer `expo-image` for any future lists; size/cache thumbnails.
6. Do not statically import optional native modules (e.g. AV) until `NativeModules` proves they exist.
7. ADB: Metro + BFF via `127.0.0.1` reverse — never stale LAN packager IPs.
8. Keep root `_layout` thin; lazy feature screens.

## BFF

1. Small connection pool; Redis optional at boot (degraded health OK).
2. Indexed `email` / refresh `token_hash`.
3. Cheap `/health` (SELECT 1 + Redis PING).
4. bcrypt cost 10; short access JWT + rotating refresh.
5. Compose `mem_limit` on bff to avoid OOM kill loops (exit 137).

## Later document

Promote this file + ARCHITECTURE.md into a shared `apps/_templates/perf-rn-bff.md` once two apps share the pattern.
