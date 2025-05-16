#!/bin/sh
set -e

if [ -z "$DOMAIN" ] || [ -z "$TARGET" ] || [ -z "$EMAIL" ]; then
  echo "❌ Missing DOMAIN / TARGET / EMAIL"
  exit 1
fi

echo "🔧 Setting up Caddy reverse proxy:"
echo "  DOMAIN = $DOMAIN"
echo "  TARGET = $TARGET"
echo "  EMAIL  = $EMAIL"

# 生成 Caddyfile 配置（监听 80，自动 fallback 到 HTTP-01）
cat > /etc/caddy/Caddyfile <<EOF
:80 {
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

  tls $EMAIL
}
EOF

# 启动 Caddy（只监听 HTTP）
exec caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
