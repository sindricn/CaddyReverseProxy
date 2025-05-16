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

# 设置 Cloudflare token 到环境变量（Caddy 将读取它）
export CLOUDFLARE_API_TOKEN=${CLOUDFLARE_API_TOKEN}

cat > /etc/caddy/Caddyfile <<EOF
{
  email ${EMAIL}
}

${DOMAIN} {
  reverse_proxy ${TARGET}
  tls {
    dns cloudflare
  }
}
EOF

exec caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
