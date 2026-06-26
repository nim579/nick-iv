#!/usr/bin/env bash
set -euo pipefail

DEPLOY_DIR="${DEPLOY_DIR:-/var/www/nick-iv.me}"
REPO_URL="${REPO_URL:-https://github.com/nim579/nick-iv.git}"
BRANCH="${BRANCH:-master}"

mkdir -p "$(dirname "$DEPLOY_DIR")"

if [ ! -d "$DEPLOY_DIR/.git" ]; then
  echo "Repository not found, cloning into ${DEPLOY_DIR}"
  rm -rf "$DEPLOY_DIR"
  git clone --branch "$BRANCH" --depth 1 "$REPO_URL" "$DEPLOY_DIR"
else
  echo "Updating repository in ${DEPLOY_DIR}"
  cd "$DEPLOY_DIR"
  git fetch --depth 1 origin "$BRANCH"
  git reset --hard "origin/$BRANCH"
fi
