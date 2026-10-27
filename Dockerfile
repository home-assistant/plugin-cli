# Base image updated by Renovate, update versionCompatibility on Alpine base bump
FROM ghcr.io/home-assistant/base:3.24-2026.10.3@sha256:880016115f356afc814398e17ba68a7ee66dfc1b4eaef09755ea2c9fa18ea481

# Set shell
SHELL ["/bin/ash", "-o", "pipefail", "-c"]

# This image runs no unsupervised processes: skip the blind
# SIGTERM-to-SIGKILL grace sleep at shutdown.
ENV S6_KILL_GRACETIME=0

# Install dependencies
RUN apk add --no-cache \
    bash-completion

# Install CLI (version updated by Renovate)
ARG CLI_VERSION=5.6.0
ARG TARGETARCH
RUN \
    if [ -z "${TARGETARCH}" ]; then \
        echo "TARGETARCH is not set, please use Docker BuildKit for the build." && exit 1; \
    fi \
    && case "${TARGETARCH}" in \
            amd64) CLI_ARCH="amd64" ;; \
            arm64) CLI_ARCH="aarch64" ;; \
            *) echo "Unsupported TARGETARCH: ${TARGETARCH}" && exit 1 ;; \
        esac \
    && curl -Lfso /usr/bin/ha https://github.com/home-assistant/cli/releases/download/${CLI_VERSION}/ha_${CLI_ARCH} \
    && chmod a+x /usr/bin/ha \
    && ha completion bash > /etc/bash_completion.d/ha

COPY rootfs /

LABEL \
    io.hass.type="cli" \
    org.opencontainers.image.title="Home Assistant CLI Plugin" \
    org.opencontainers.image.description="Home Assistant Supervisor plugin for CLI" \
    org.opencontainers.image.authors="The Home Assistant Authors" \
    org.opencontainers.image.url="https://www.home-assistant.io/" \
    org.opencontainers.image.documentation="https://www.home-assistant.io/docs/" \
    org.opencontainers.image.licenses="Apache License 2.0"
