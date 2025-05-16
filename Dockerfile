# --- Build Stage ---
FROM caddy:builder AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare

# --- Run Stage ---
FROM caddy:alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
