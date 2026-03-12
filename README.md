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

**Authentication**

| Variable | Type | Required | Default | Description |
|---|---|---|---|---|
| `ADMIN_PASSWORD` | `string` | yes | — | Password for the admin account |
| `JWT_SECRET_KEY` | `string` | yes | — | Secret key for signing JWT access tokens |
| `JWT_REFRESH_SECRET_KEY` | `string` | yes | — | Secret key for signing JWT refresh tokens |
| `JWT_EXPIRATION_TIME` | `integer` | no | `1800` | JWT access token lifetime in seconds |
| `JWT_REFRESH_EXPIRATION_TIME` | `integer` | no | `604800` | JWT refresh token lifetime in seconds |

**Database** — shared between the `postgres` and `yak-server` containers

| Variable | Type | Required | Default | Description |
|---|---|---|---|---|
| `POSTGRES_PORT` | `integer` | no | `5432` | Port to expose PostgreSQL on |
| `POSTGRES_DB` | `string` | yes | — | Database name |
| `POSTGRES_USER` | `string` | yes | — | Database user |
| `POSTGRES_PASSWORD` | `string` | yes | — | Database password |
| `POSTGRES_DATASET` | `string` | yes | — | Host path for PostgreSQL data volume |

**Cookie**

| Variable | Type | Required | Default | Description |
|---|---|---|---|---|
| `COOKIE_SECURE` | `boolean` | no | `true` | Whether to set the `Secure` flag on cookies |
| `COOKIE_DOMAIN` | `string` | no | `""` | Cookie domain |

**Application**

| Variable | Type | Required | Default | Description |
|---|---|---|---|---|
| `DEBUG` | `integer` | no | `0` | FastAPI/Starlette debug mode (`0` or `1`) |
| `ALLOWED_ORIGINS` | `JSON array` | no | `[]` | Allowed CORS origins (e.g. `["https://example.com"]`) |

2. Start the stack:

```sh
docker compose up -d --wait
```

## Updates

Dependencies are managed automatically by [Renovate](https://docs.renovatebot.com/). `yak-server` and `yak-display` image updates are grouped into a single PR.

## Ansible

Before 