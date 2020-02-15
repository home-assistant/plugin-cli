ARG BUILD_FROM
FROM $BUILD_FROM

# Set shell
SHELL ["/bin/ash", "-o", "pipefail", "-c"]

# Install CLI
ARG BUILD_ARCH
ARG CLI_VERSION=4.0.1
RUN apk add --no-cache curl \
    && curl -Lso /usr/bin/ha https://github.com/home-assistant/cli/releases/download/${CLI_VERSION}/ha_${BUILD_ARCH} \
    && chmod a+x /usr/bin/ha \
    && apk del curl

COPY cli.sh /bin/
COPY welcome.txt /etc/

CMD ["/bin/cli.sh"]
