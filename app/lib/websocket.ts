import { useEffect } from 'react';

export interface WebSocketMessage<T = unknown> {
  type?: string;
  channel: string;
  event?: string;
  data: T;
}

export class WebSocketManager {
  private socket: WebSocket | null = null;
  private handlers = new Map<string, Set<(data: any) => void>>();
  private queue: string[] = [];
  private pingTimer: ReturnType<typeof setInterval> | null = null;
  private reconnectTimer: ReturnType<typeof setTimeout> | null = null;
  private url: string = '';
  private token: string = '';

  connect(url: string, token: string) {
    this.url = url;
    this.token = token;
    this.teardown();

    const fullUrl = `${url}?token=${encodeURIComponent(token)}`;
    this.socket = new WebSocket(fullUrl);

    this.socket.onopen = () => {
      this.startHeartbeat();
      while (this.queue.length > 0 && this.socket?.readyState === WebSocket.OPEN) {
        const msg = this.queue.shift();
        if (msg) this.socket.send(msg);
      }
    };

    this.socket.onmessage = (event) => {
      try {
        const payload = JSON.parse(event.data);
        if (payload.type === 'PONG') return;

        const channel = payload.channel;
        const listeners = this.handlers.get(channel);
        if (listeners) {
          listeners.forEach((callback) => callback(payload.data));
        }
      } catch (err) {
        console.warn('[WS] Failed to parse message:', event.data);
      }
    };

    this.socket.onclose = () => {
      this.stopHeartbeat();
      this.scheduleReconnect();
    };

    this.socket.onerror = (err) => {
      console.warn('[WS] Connection error:', err);
      this.socket?.close();
    };
  }

  private startHeartbeat() {
    this.stopHeartbeat();
    this.pingTimer = setInterval(() => {
      if (this.socket?.readyState === WebSocket.OPEN) {
        this.socket.send(JSON.stringify({ type: 'PING' }));
      }
    }, 15000);
  }

  private stopHeartbeat() {
    if (this.pingTimer) {
      clearInterval(this.pingTimer);
      this.pingTimer = null;
    }
  }

  private scheduleReconnect() {
    if (this.reconnectTimer) return;
    this.reconnectTimer = setTimeout(() => {
      this.reconnectTimer = null;
      if (this.url && this.token) {
        this.connect(this.url, this.token);
      }
    }, 3000);
  }

  subscribe<T>(channel: string, onMessage: (data: T) => void): () => void {
    if (!this.handlers.has(channel)) {
      this.handlers.set(channel, new Set());
    }
    const set = this.handlers.get(channel)!;
    set.add(onMessage as (data: any) => void);

    return () => {
      set.delete(onMessage as (data: any) => void);
      if (set.size === 0) {
        this.handlers.delete(channel);
      }
    };
  }

  send(channel: string, data: unknown) {
    const payload = JSON.stringify({ channel, data });
    if (this.socket?.readyState === WebSocket.OPEN) {
      this.socket.send(payload);
    } else {
      this.queue.push(payload);
    }
  }

  teardown() {
    this.stopHeartbeat();
    if (this.reconnectTimer) {
      clearTimeout(this.reconnectTimer);
      this.reconnectTimer = null;
    }
    if (this.socket) {
      this.socket.close();
      this.socket = null;
    }
  }
}

export const socketManager = new WebSocketManager();

/** React Hook for component lifecycle subscription */
export function useWebSocketChannel<T>(channel: string, onMessage: (data: T) => void) {
  useEffect(() => {
    const unsubscribe = socketManager.subscribe<T>(channel, onMessage);
    return () => unsubscribe();
  }, [channel, onMessage]);
}
