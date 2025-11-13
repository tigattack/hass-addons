ARG BUILD_FROM
FROM $BUILD_FROM

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# renovate: datasource=github-releases depName=node_exporter packageName=prometheus/node_exporter
ARG NODE_EXPORTER_VERSION="1.8.2"
ARG BUILD_ARCH

RUN \
    apk add --no-cache apache2-utils &&\
    ARCH="${BUILD_ARCH}" &&\
    if [ "${BUILD_ARCH}" = "aarch64" ]; then ARCH="arm64"; fi &&\
    curl -L -o /tmp/node_exporter.tar.gz \
        "https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.linux-${ARCH}.tar.gz" &&\
    tar -xzvf /tmp/node_exporter.tar.gz -C /tmp --strip-components=1 &&\
    mv /tmp/node_exporter /usr/local/bin/ &&\
    chmod +x /usr/local/bin/node_exporter &&\
    rm -rf /tmp/node_exporter* /tmp/LICENSE /tmp/NOTICE

COPY rootfs /

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:9100/metrics || exit 1

# This add-on runs on the host pid namespace, making it impossible to use S6-Overlay.
# Therefore we must reset the entrypoint so it doesn't run.
ENTRYPOINT []

CMD ["/run.sh"]
