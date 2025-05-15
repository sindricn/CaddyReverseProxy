
FROM caddy:2.7.6-builder AS builder
WORKDIR /app
COPY . .
FROM caddy:2.7.6
COPY --from=builder /app /app
COPY /app/Caddyfile /etc/caddy/Caddyfile
WORKDIR /app
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
