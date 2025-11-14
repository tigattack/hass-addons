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
    ARCH="${BUILD_ARCH}" &&\
    if [ "${BUILD_ARCH}" = "aarch64" ]; then ARCH="arm64"; fi &&\
    curl -L -o /tmp/smartctl_exporter.tar.gz \
        "https://github.com/prometheus-community/smartctl_exporter/releases/download/v${SMARTCTL_EXPORTER_VERSION}/smartctl_exporter-${SMARTCTL_EXPORTER_VERSION}.linux-${ARCH}.tar.gz" &&\
    tar -xzvf /tmp/smartctl_exporter.tar.gz -C /tmp &&\
    mv /tmp/smartctl_exporter-${SMARTCTL_EXPORTER_VERSION}.linux-${ARCH}/smartctl_exporter /usr/local/bin/ &&\
    chmod +x /usr/local/bin/smartctl_exporter &&\
    rm -rf /tmp/smartctl_exporter* /tmp/LICENSE

COPY rootfs /

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:9633/metrics || exit 1

# This add-on doesn't use S6-Overlay. Reset the entrypoint so it doesn't run:
ENTRYPOINT []

CMD ["/run.sh"]
