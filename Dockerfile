# 使用官方 Caddy 镜像作为基础
FROM caddy:2.7.6-builder AS builder

# 将你的项目源码拉进来
WORKDIR /app
COPY . .

# 可选：如果你有构建脚本或插件需要编译，放在这里

FROM caddy:2.7.6

# 将你的项目复制进来（假设你有 Caddyfile 和其他配置）
COPY --from=builder /app /app
COPY /app/Caddyfile /etc/caddy/Caddyfile

# 设置工作目录
WORKDIR /app

# 启动命令
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
