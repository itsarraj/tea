# Multi-stage Tea BFF
FROM rust:1-bookworm AS builder
WORKDIR /app
COPY Cargo.toml Cargo.lock* ./
COPY src ./src
COPY migrations ./migrations
RUN cargo build --release

FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates libssl3 curl \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY --from=builder /app/target/release/bff /app/bff
COPY --from=builder /app/migrations /app/migrations
COPY configuration.docker.yaml /app/configuration.yaml
RUN mkdir -p /app/uploads
VOLUME ["/app/uploads"]
EXPOSE 8000
HEALTHCHECK --interval=30s --timeout=5s --start-period=30s --retries=3 \
  CMD curl -fsS http://127.0.0.1:8000/api/v1/health || exit 1
CMD ["/app/bff"]
