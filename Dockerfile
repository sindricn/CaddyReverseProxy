FROM caddy:alpine

# 安装 Cloudflare DNS 插件（官方 builder）
RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
