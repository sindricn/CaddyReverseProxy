#!/bin/sh
set -e

if [ -z "$DOMAIN" ] || [ -z "$TARGET" ]; then
  echo "❌ 未设置环境变量 DOMAIN 和 TARGET，无法启动 Caddy"
  exit 1
fi

echo "🔧 配置域名 $DOMAIN 代理到 $TARGET"

cat > /etc/caddy/Caddyfile <<EOF
$DOMAIN {
  reverse_proxy {
    to $TARGET
    transport http {
      tls_insecure_skip_verify
    }
  }
}
EOF

exec caddy run --config /etc/caddy/Caddyfile --adapter caddyfile

