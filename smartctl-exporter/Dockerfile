ARG BUILD_FROM
FROM $BUILD_FROM

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# renovate: datasource=github-releases depName=smartctl_exporter packageName=prometheus-community/smartctl_exporter
ARG SMARTCTL_EXPORTER_VERSION="0.14.0"
ARG BUILD_ARCH

RUN \
    apk add --no-cache \
        smartmontools \
        jq &&\
    case "${BUILD_ARCH}" in \
        aarch64) ARCH="arm64" ;; \
        amd64) ARCH="amd64" ;; \
        *) echo "Unsupported architecture: ${BUILD_ARCH}" && exit 1 ;; \
    esac &&\
    curl -L -o /tmp/smartctl_exporter.tar.gz \
        "https://github.com/prometheus-community/smartctl_exporter/releases/download/v${SMARTCTL_EXPORTER_VERSION}/smartctl_exporter-${SMARTCTL_EXPORTER_VERSION}.linux-${ARCH}.tar.gz" &&\
    tar -xzf /tmp/smartctl_exporter.tar.gz -C /tmp &&\
    mv /tmp/smartctl_exporter-${SMARTCTL_EXPORTER_VERSION}.linux-${ARCH}/smartctl_exporter /usr/local/bin/ &&\
    chmod +x /usr/local/bin/smartctl_exporter &&\
    rm -rf /tmp/smartctl_exporter*

COPY rootfs /
