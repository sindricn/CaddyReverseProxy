#!/bin/bash

set -e

CADDYFILE_PATH="./Caddyfile"

# 检查并获取参数或交互输入
if [ $# -eq 2 ]; then
  DOMAIN="$1"
  TARGET="$2"
else
  echo "未提供参数，已进入交互模式。"
  read -p "请输入您的域名 (例如: myapp.example.com): " DOMAIN
  read -p "请输入目标 URL (例如: https://target.pages.dev): " TARGET
fi

# 输出信息
echo "🔧 准备反代配置："
echo "  域名：$DOMAIN"
echo "  目标：$TARGET"

# 生成 Caddyfile
cat > "$CADDYFILE_PATH" <<EOF
$DOMAIN {
  reverse_proxy $TARGET
}
EOF

echo "✅ Caddyfile 已生成："
cat "$CADDYFILE_PATH"

# 检查 Docker 是否安装
if ! command -v docker &> /dev/null; then
  echo "❌ 未检测到 Docker，请先安装 Docker 后再运行。"
  exit 1
fi

# 创建容器网络（可选）
docker network inspect caddy_net &> /dev/null || docker network create caddy_net

# 启动 Caddy 容器
echo "🚀 正在启动 Caddy 容器..."

docker run -d \
  --name caddy-reverse-proxy \
  --restart unless-stopped \
  -p 80:80 -p 443:443 \
  -v "$(pwd)/Caddyfile":/etc/caddy/Caddyfile \
  -v caddy_data:/data \
  -v caddy_config:/config \
  --network caddy_net \
  caddy:latest

echo "🎉 Caddy 已启动并监听以下地址："
echo "  http://$DOMAIN"
echo "  https://$DOMAIN"
