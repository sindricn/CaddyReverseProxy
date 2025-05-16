#!/bin/sh
set -e

if [ -z "$DOMAIN" ] || [ -z "$TARGET" ] || [ -z "$EMAIL" ] || [ -z "$CLOUDFLARE_API_TOKEN" ]; then
  echo "❌ Required environment variables: DOMAIN, TARGET, EMAIL, CLOUDFLARE_API_TOKEN"
  exit 1
fi

echo "🔧 Setting up Caddy DNS-based reverse proxy:"
echo "  DOMAIN  = $DOMAIN"
echo "  TARGET  = $TARGET"
echo "  EMAIL   = $EMAIL"

cat > /etc/caddy/Caddyfile <<EOF
$DOMAIN {
  tls {
    dns cloudflare \$CLOUDFLARE_API_TOKEN
    email $EMAIL
  }

  reverse_proxy $TARGET {
    header_up Host {http.reverse_proxy.upstream.host}
    transport http {
      tls
      tls_insecure_skip_verify
    }
  }
}
EOF

exec caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
