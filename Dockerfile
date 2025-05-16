# -------- Build Phase --------
FROM golang:1.21-alpine AS builder

RUN apk add --no-cache git curl bash
RUN go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare

# -------- Runtime --------
FROM caddy:alpine

COPY --from=builder /root/go/bin/caddy /usr/bin/caddy
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
