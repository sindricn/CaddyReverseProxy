FROM caddy:alpine

# 允许动态生成 Caddyfile
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 使用 entrypoint 脚本生成 Caddyfile 并启动服务
ENTRYPOINT ["/entrypoint.sh"]
