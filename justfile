# =========================
#  📝 Justfile for yak-infra
# =========================

# Default: show available commands
default:
    @just --summary

# -------------------------
# Compose commands
# -------------------------

# Build all images
build:
    docker compose build

# Start the stack in detached mode
up:
    docker compose up -d

# Stop the stack
down:
    docker compose down

# Stop and remove volumes (useful for resetting Postgres)
down-full:
    docker compose down -v

# Restart the stack
restart:
    just down
    just up

# Tail logs (all services)
logs:
    docker compose logs -f

# Tail logs for backend only
logs-server:
    docker compose logs -f yak-server

# Tail logs for frontend only
logs-frontend:
    docker compose logs -f yak-display

# Tail logs for postgres only
logs-db:
    docker compose logs -f postgres

# Execute a command inside yak-server container
exec-server cmd:
    docker compose exec yak-server {{cmd}}

# Execute a command inside postgres container
exec-db cmd:
    docker compose exec postgres {{cmd}}

# -------------------------
# Development helpers
# -------------------------

# Rebuild and start everything (useful after code changes)
rebuild:
    just build
    just up

# Enter shell in backend
shell-server:
    docker compose exec yak-server sh

# Enter shell in frontend
shell-frontend:
    docker compose exec yak-display sh

# Enter shell in postgres
shell-db:
    docker compose exec postgres sh

# -------------------------
# Utility
# -------------------------

# Check container health
health:
    docker compose ps
