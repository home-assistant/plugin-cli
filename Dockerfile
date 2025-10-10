ARG BUILD_FROM
FROM $BUILD_FROM

# Set shell
SHELL ["/bin/ash", "-o", "pipefail", "-c"]

ARG BUILD_ARCH
WORKDIR /usr/src

# Install dependencies
RUN apk add --no-cache \
    bash-completion
# No longer need rlwrap; base image already provides Bash/readline

# Install CLI
ARG CLI_VERSION
RUN curl -Lfso /usr/bin/ha https://github.com/home-assistant/cli/releases/download/${CLI_VERSION}/ha_${BUILD_ARCH} \
    && chmod a+x /usr/bin/ha

COPY rootfs /
WORKDIR /
