#!/bin/sh
set -e

if [ -z "$DOMAIN" ] || [ -z "$TARGET" ] || [ -z "$EMAIL" ]; then
  echo "❌ DOMAIN / TARGET / EMAIL 未设置"
  exit 1
fi

echo "🔧 Setting up Caddy reverse proxy:"
echo "  DOMAIN = $DOMAIN"
echo "  TARGET = $TARGET"
echo "  EMAIL  = $EMAIL"

cat > /etc/caddy/Caddyfile <<EOF
$DOMAIN {
  tls $EMAIL

  handle /.well-known/acme-challenge/* {
    root * /var/www/html
    file_server
  }

  handle {
    reverse_proxy $TARGET {
      header_up Host {http.reverse_proxy.upstream.host}
      transport http {
        tls
        tls_insecure_skip_verify
      }
    }
  }
}
EOF

exec caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
