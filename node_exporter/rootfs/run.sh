#!/usr/bin/env bashio
# ==============================================================================
# Home Assistant Community App: node exporter
# Runs node_exporter
# ==============================================================================

# Set bashio log level from app configuration
bashio::log.level "$(bashio::config 'log_level')"

/etc/cont-init.d/node_exporter.sh

# Start node_exporter
exec /etc/services.d/node_exporter/run
