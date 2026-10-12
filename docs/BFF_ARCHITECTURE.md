# Tea BFF Architecture (Rust Actix-web)

The Tea Backend-For-Frontend (BFF) is built with Rust and Actix-web, providing a high-performance, asynchronous API gateway tailored to the mobile client's needs.

---

## 1. Directory & Module Structure (`bff/src/`)

```
bff/src/
├── main.rs                   # Server entrypoint, listener bind, pool initialization
├── lib.rs                    # Application factory, state injection
├── configuration.rs          # Environment settings (database URL, JWT secret, ports)
├── error.rs                  # Centralized Actix Web error handlers and JSON error responses
├── middleware/               # HTTP middleware layer
│   ├── auth.rs               # JWT Bearer token authentication extractor
│   ├── cors.rs               # Permissive CORS headers for local development and web
│   └── rate_limit.rs         # Redis-backed request throttling
├── routes/                   # Route table dispatcher
│   └── mod.rs                # /api/v1 route registration
└── module/                   # Domain business logic modules
    ├── auth/                 # Register, login, refresh rotation, OAuth, password reset
    ├── user/                 # Profile management, password changes, photo uploads
    ├── dating/               # Feed, dilemmas, verdict voting, advisors, stories, matches
    ├── health/               # /api/v1/health status checking Postgres & Redis
    ├── storage/              # Local disk & RustFS media storage + thumbnail generator
    ├── legal/                # Privacy policy, Terms of Service, Child safety HTML views
    ├── push/                 # Expo push notification sender
    ├── sms/                  # SMS OTP provider interface
    └── ws/                   # Real-time WebSocket actor for direct chat messaging
```

---

## 2. Database & Connection Pooling

- **Engine**: PostgreSQL with SQLx async driver.
- **Pooling**: `sqlx::PgPool` injected into Actix application state via `web::Data<PgPool>`.
- **Migrations**: Automated startup or manual migration execution via `sqlx migrate run`.
- **Media Pipeline**: User photos uploaded via `multipart/form-data` are written to `./uploads/` with UUID identifiers and recorded in `dating.photos` with sort order (`sort_order`). When queries return profiles, photos are joined directly:
  ```sql
  SELECT p.url FROM dating.photos p WHERE p.user_id = $1 ORDER BY p.sort_order ASC
  ```

---

## 3. Real-Time WebSockets (`module/ws/`)

- Direct messages between users use Actix WebSockets (`/api/v1/ws`).
- Clients authenticate by providing their JWT access token in the query parameters (`/api/v1/ws?token=...`).
- When a chat message is sent via REST (`POST /api/v1/messages/conversations/{id}`), the server persists the message to the database and broadcasts a notification frame to the recipient's active WebSocket session.
