ARG BUILD_FROM=ghcr.io/home-assistant/base:3.23-2026.03.1
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/ash", "-o", "pipefail", "-c"]

WORKDIR /usr/src

# Install rlwrap
ARG RLWRAP_VERSION=0.46.1
RUN apk add --no-cache --virtual .build-deps \
        build-base \
        readline-dev \
        ncurses-dev \
    && curl -L -s "https://github.com/hanslub42/rlwrap/releases/download/${RLWRAP_VERSION}/rlwrap-${RLWRAP_VERSION}.tar.gz" \
        | tar zxvf - -C /usr/src/ \
    && cd rlwrap-${RLWRAP_VERSION} \
    && ./configure \
    && make \
    && make install \
    && apk del .build-deps \
    && rm -rf /usr/src/*

# Install CLI
ARG CLI_VERSION=5.0.0
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
    && chmod a+x /usr/bin/ha

COPY rootfs /
WORKDIR /

LABEL \
    io.hass.type="cli" \
    org.opencontainers.image.title="Home Assistant CLI Plugin" \
    org.opencontainers.image.description="Home Assistant Supervisor plugin for CLI" \
    org.opencontainers.image.authors="The Home Assistant Authors" \
    org.opencontainers.image.url="https://www.home-assistant.io/" \
    org.opencontainers.image.documentation="https://www.home-assistant.io/docs/" \
    org.opencontainers.image.licenses="Apache License 2.0"
