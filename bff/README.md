# Tea BFF

Actix-web + sqlx (Postgres) + optional Redis. Migrations run automatically on boot.

```bash
cp .env.example .env
createdb tea               # once; migrations run on boot
cargo run                  # GET http://127.0.0.1:8000/api/v1/health
cargo test                 # unit tests (verdict voting, handle uniqueness, advice ranking)
```

Config: `configuration.yaml` overridden by `BFF__SECTION__KEY` env vars (see `.env.example`).
Providers (`sms`, `email`, `push`, `oauth.google`) are no-ops/logs until configured.

Docker: `Dockerfile` is a two-stage build; runtime image has `curl` for the compose healthcheck.
See `../compose.prod.yml` and `../scripts/vps-deploy.sh` for the VPS rollout.

