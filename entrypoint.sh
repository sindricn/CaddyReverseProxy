#!/bin/sh
set -e

if [ -z "$DOMAIN" ] || [ -z "$TARGET" ]; then
  echo "❌ Required environment variables: DOMAIN, TARGET"
  exit 1
fi

echo "🔧 Starting Caddy Reverse Proxy:"
echo "  DOMAIN = $DOMAIN"
echo "  TARGET = $TARGET"

cat > /etc/caddy/Caddyfile <<EOF
$DOMAIN {
  reverse_proxy $TARGET
}
EOF

exec caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
