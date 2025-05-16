# -------- Build Stage --------
FROM golang:1.21-alpine AS builder

RUN apk add --no-cache git curl bash

# 安装 xcaddy
RUN go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest

# 构建 caddy，添加 cloudflare 插件
RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare

# -------- Final Stage --------
FROM caddy:alpine

# 拷贝构建好的 caddy 二进制
COPY --from=builder /root/go/bin/caddy /usr/bin/caddy

# 拷贝启动脚本
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
