# hadolint ignore=DL3007
FROM alpine:latest

LABEL \
    org.opencontainers.image.title="Namesilo DDNS" \
    org.opencontainers.image.description="Using Namesilo's API to update records" \
    org.opencontainers.image.version="1.0" \
    org.opencontainers.image.licenses="GPL-3.0" \
    org.opencontainers.image.authors="Olivier Tremblay-Noel" \
    org.opencontainers.image.url="https://hub.docker.com/repository/docker/oliviertremblaynoel/namesilo-ddns" \
    org.opencontainers.image.source="https://github.com/oliviertremblaynoel/namesilo-ddns"

# hadolint ignore=DL3018
RUN apk add --no-cache \
    curl \
    bind-tools \
    tzdata \
    xmlstarlet

COPY /entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
