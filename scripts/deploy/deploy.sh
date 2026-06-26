#!/usr/bin/env bash
set -euo pipefail

DEPLOY_DIR="${DEPLOY_DIR:-/var/www/nick-iv.me}"
cd "$DEPLOY_DIR"

if ! docker network inspect nim >/dev/null 2>&1; then
  echo "Creating docker network nim"
  docker network create nim
fi

docker compose build
docker compose up -d --remove-orphans
