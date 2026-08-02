ARG BUILD_FROM=ghcr.io/home-assistant/base:3.24
FROM ${BUILD_FROM}

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# renovate: datasource=github-releases depName=node_exporter packageName=prometheus/node_exporter
ARG NODE_EXPORTER_VERSION="1.10.2"
ARG TARGETARCH

RUN \
    apk add --no-cache apache2-utils &&\
    if [ -z "${TARGETARCH}" ]; then \
        echo "TARGETARCH is not set, please use Docker BuildKit for the build." && exit 1; \
    fi &&\
    case "${TARGETARCH}" in \
        amd64) ARCH="amd64" ;; \
        arm64) ARCH="arm64" ;; \
        *) echo "Unsupported TARGETARCH: ${TARGETARCH}" && exit 1 ;; \
    esac &&\
    curl -L -o /tmp/node_exporter.tar.gz \
        "https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.linux-${ARCH}.tar.gz" &&\
    tar -xzvf /tmp/node_exporter.tar.gz -C /tmp --strip-components=1 &&\
    mv /tmp/node_exporter /usr/local/bin/ &&\
    chmod +x /usr/local/bin/node_exporter &&\
    rm -rf /tmp/node_exporter* /tmp/LICENSE /tmp/NOTICE

COPY rootfs /

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:9100/metrics || exit 1

# This app does not use S6-Overlay. Reset the entrypoint so it does not run.
ENTRYPOINT []

CMD ["/run.sh"]
