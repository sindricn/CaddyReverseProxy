#!/bin/sh
set -e

if [ -z "$DOMAIN" ] || [ -z "$TARGET" ]; then
  echo "❌ Missing DOMAIN or TARGET"
  exit 1
fi

echo "🔁 Setting up redirection: $DOMAIN → $TARGET"

cat > /etc/caddy/Caddyfile <<EOF
$DOMAIN {
  redir $TARGET 301
}
EOF

exec caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
