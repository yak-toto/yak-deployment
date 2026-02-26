# yak-deployment

Docker Compose deployment for [yak-toto](https://github.com/yak-toto), a sports prediction app. Runs the backend API, frontend, and a PostgreSQL database.

## Services

| Service | Image | Description |
|---|---|---|
| `postgres` | `postgres` | Database |
| `yak-server` | `ghcr.io/yak-toto/yak-server` | REST API (port 8000) |
| `yak-display` | `ghcr.io/yak-toto/yak-display` | Frontend SPA served via nginx |

nginx proxies `/api/` to `yak-server` and handles SPA routing for everything else.

## Prerequisites

- Docker with the Compose plugin
- An external Docker network named `proxy` (e.g. a Traefik/nginx-proxy/caddy network)

```sh
docker network create proxy
```

## Setup

1. Copy the example env file and fill in values:

```sh
cp .env.example .env
```

| Variable | Description |
|---|---|
| `ADMIN_PASSWORD` | Password for the admin account |
| `POSTGRES_PORT` | Port to expose PostgreSQL on |
| `POSTGRES_DB` | Database name |
| `POSTGRES_USER` | Database user |
| `POSTGRES_PASSWORD` | Database password |
| `POSTGRES_DATASET` | Host path for PostgreSQL data volume |
| `COOKIE_SECURE` | Whether to set the `Secure` flag on cookies |
| `COOKIE_DOMAIN` | Cookie domain |
| `ALLOWED_ORIGINS` | JSON list of allowed CORS origins (e.g. `["https://example.com"]`) |

2. Start the stack:

```sh
docker compose up -d
```

## Updates

Dependencies are managed automatically by [Renovate](https://docs.renovatebot.com/). `yak-server` and `yak-display` image updates are grouped into a single PR.
