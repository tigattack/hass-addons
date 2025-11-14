#!/usr/bin/env bashio
# ==============================================================================
# Home Assistant Community Add-on: Prometheus Node Exporter
# Configures node_exporter
# ==============================================================================
bashio::require.unprotected

# Set bashio log level from add-on configuration
bashio::log.level "$(bashio::config 'log_level')"


web_config_file=/data/node_exporter_web.yml
: > "$web_config_file"

bashio::log.info "Checking configuration options..."

#####################
# HTTP Basic Auth
#####################

if bashio::config.false 'enable_basic_auth'; then
  bashio::log.warning "HTTP Basic Auth is disabled!"
fi

if bashio::config.true 'enable_basic_auth'; then
  bashio::log.info "HTTP Basic Auth is enabled!"

  # Require variables
  bashio::config.require 'basic_auth_user' "You enabled HTTP Basic Auth, so you must set a username"
  bashio::config.require 'basic_auth_pass' "You enabled HTTP Basic Auth, so you must set a password"
  basic_auth_user="$(bashio::config 'basic_auth_user')"
  basic_auth_pass="$(bashio::config 'basic_auth_pass')"

  # bcrypt the password
  hashed_password=$(htpasswd -bnBC 12 "" "$basic_auth_pass" | tr -d ':\n')

  cat >> "$web_config_file" <<EOF
basic_auth_users:
    $basic_auth_user: $hashed_password
EOF

fi

#####################
# TLS
#####################

if bashio::config.false 'enable_tls'; then
  bashio::log.warning "TLS is disabled!"
fi

if bashio::config.true 'enable_tls'; then
  bashio::log.info "TLS is enabled!"

  # Require variables
  bashio::config.require 'cert_file' "You enabled TLS, so you must set certificate file"
  bashio::config.require 'cert_key' "You enabled TLS, so you must set certificate key"
  cert_file="$(bashio::config 'cert_file')"
  cert_key="$(bashio::config 'cert_key')"

  cat >> "$web_config_file" <<EOF
tls_server_config:
    cert_file: $cert_file
    key_file: $cert_key
EOF

fi
