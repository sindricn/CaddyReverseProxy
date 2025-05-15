#!/bin/sh
set -e

DOMAIN=${DOMAIN}
TARGET=${TARGET}

if [ -z "$DOMAIN" ] || [ -z "$TARGET" ]; then
  echo "❌ 环境变量 DOMAIN 或 TARGET 未设置，无法启动 Caddy。"
  exit 1
fi

echo "🔧 正在为域名 $DOMAIN 配置反向代理到 $TARGET"

# 生成 Caddyfile
cat > /etc/caddy/Caddyfile <<EOF
$DOMAIN {
  reverse_proxy $TARGET
}
EOF

# 启动 Caddy
exec caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
