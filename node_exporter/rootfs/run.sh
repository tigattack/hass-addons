#!/usr/bin/env bashio
# ==============================================================================
# Home Assistant Community Add-on: node exporter
# Runs node_exporter
# ==============================================================================
# The node exporter add-on runs in the host PID namespace, therefore it cannot
# use the regular S6-Overlay; hence this add-on uses a "old school" script
# to run; with a couple of "hacks" to make it work.
# ==============================================================================
/etc/cont-init.d/node_exporter.sh

# Start node_exporter
exec /etc/services.d/node_exporter/run
