#!/bin/sh
set -e

if [ -z "$DOMAIN" ] || [ -z "$TARGET" ] || [ -z "$EMAIL" ]; then
  echo "❌ Missing one of DOMAIN / TARGET / EMAIL"
  exit 1
fi

echo "🔧 Setting up reverse proxy: $DOMAIN → $TARGET (email: $EMAIL)"

cat > /etc/caddy/Caddyfile <<EOF
{
  email $EMAIL
  acme_ca https://acme-v02.api.letsencrypt.org/directory
}

$DOMAIN {
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
