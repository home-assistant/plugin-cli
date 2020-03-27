ARG BUILD_FROM
FROM $BUILD_FROM

# Set shell
SHELL ["/bin/ash", "-o", "pipefail", "-c"]

ARG BUILD_ARCH
ARG CLI_VERSION

# Install CLI
RUN apk add --no-cache curl \
    && curl -Lso /usr/bin/ha https://github.com/home-assistant/cli/releases/download/${CLI_VERSION}/ha_${BUILD_ARCH} \
    && chmod a+x /usr/bin/ha \
    && apk del curl

COPY rootfs /

ENTRYPOINT ["/bin/sh", "-c"]
CMD ["/usr/bin/cli.sh"]
