import { useEffect, useState } from 'react';

/**
 * Tracks whether the app is currently serving fixture data because the BFF
 * is unreachable. Only ever true in __DEV__. Surfaced by <OfflineBanner/>.
 */
let active = false;
let lastError: string | null = null;
const listeners = new Set<() => void>();

export function setFixtureMode(on: boolean, reason?: string) {
  if (active === on && (reason ?? null) === lastError) return;
  active = on;
  lastError = on ? (reason ?? null) : null;
  listeners.forEach((l) => l());
}

export function isFixtureMode() {
  return active;
}

export function useFixtureMode() {
  const [, tick] = useState(0);
  useEffect(() => {
    const l = () => tick((n) => n + 1);
    listeners.add(l);
    return () => {
      listeners.delete(l);
    };
  }, []);
  return { active, reason: lastError };
}

/** True for fetch-level failures (server down, DNS, adb reverse missing, timeout). */
export function isNetworkError(e: unknown): boolean {
  if (!(e instanceof Error)) return false;
  const m = e.message.toLowerCase();
  return (
    m.includes('network request failed') ||
    m.includes('failed to fetch') ||
    m.includes('econnrefused') ||
    m.includes('connection refused') ||
    m.includes('connect') ||
    m.includes('network') ||
    m.includes('aborted') ||
    m.includes('timed out') ||
    m.includes('timeout') ||
    m.includes('unable to resolve host') ||
    m.includes('err_connection')
  );
}
