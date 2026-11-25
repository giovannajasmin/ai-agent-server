#!/bin/bash
# Always-on AI agent server: installs Docker, then runs n8n behind automatic HTTPS.
# Usage (on a fresh Ubuntu/Debian VPS, as root):
#   curl -fsSL https://raw.githubusercontent.com/giovannajasmin/ai-agent-server/main/setup.sh | DOMAIN=agents.example.com bash
set -e

DOMAIN="${DOMAIN:?Set DOMAIN, e.g. DOMAIN=agents.example.com (point its DNS A record to this server first)}"
TIMEZONE="${TIMEZONE:-UTC}"
DIR="${DIR:-/opt/ai-agent-server}"

echo "==> Installing Docker (if needed)"
if ! command -v docker >/dev/null 2>&1; then
  curl -fsSL https://get.docker.com | sh
fi

echo "==> Downloading configuration"
mkdir -p "$DIR" && cd "$DIR"
curl -fsSL -o docker-compose.yml https://raw.githubusercontent.com/giovannajasmin/ai-agent-server/main/docker-compose.yml

if [ ! -f .env ]; then
  KEY="$(head -c 32 /dev/urandom | od -An -tx1 | tr -d ' \n')"
  cat > .env <<ENV
DOMAIN=$DOMAIN
TIMEZONE=$TIMEZONE
N8N_ENCRYPTION_KEY=$KEY
ENV
  chmod 600 .env
fi

echo "==> Starting n8n + HTTPS"
docker compose up -d

echo ""
echo "Done. Open https://$DOMAIN in a few minutes and create your owner account."
echo "Config and encryption key: $DIR/.env (back it up!)"
