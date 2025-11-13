# Home Assistant Add-on: node exporter

## Configuration

### Basic Setup

```yaml
# Default configuration - works out of the box
log_level: "info"  # trace|debug|info|warn|error
enable_basic_auth: false
enable_tls: false
```

### Advanced Configuration

```yaml
# Enable/disable specific collectors
collectors:
  cpu: true          # CPU usage and utilization
  meminfo: true      # Memory statistics
  diskstats: true    # Disk I/O statistics
  netdev: true       # Network interface stats
  netstat: true      # Network connection stats
  filesystem: true   # Filesystem usage
  loadavg: true      # System load average
  time: true         # Current time metrics
  wifi: false        # WiFi statistics (if applicable)
  hwmon: true        # Hardware monitoring (temperature/fans)

# Ignore specific mount points or network devices
ignore_mount_points:
  - "/tmp"
  - "/run"

ignore_network_devices:
  - "docker0"
  - "veth*"

# Custom command line arguments for node_exporter
cmdline_extra_args: "--collector.disable-defaults --collector.cpu"
```

### Security Options

```yaml
# Enable HTTP Basic Authentication
enable_basic_auth: true
basic_auth_user: "your_username"
basic_auth_pass: "your_bcrypt_hash"

# Enable TLS/HTTPS
enable_tls: true
cert_file: "/ssl/fullchain.pem"
cert_key: "/ssl/privkey.pem"
```

## Metrics Endpoint

Once running, the add-on exposes metrics at:

- **HTTP**: `http://your-home-assistant:9100/metrics` (e.g. <http://homeassistant:9100/metrics>)
- **HTTPS** (if TLS enabled): `https://your-home-assistant:9100/metrics`
- **With Auth**: Include Basic Auth headers if enabled

### Example Prometheus Configuration

```yaml
scrape_configs:
  - job_name: 'homeassistant-node-exporter'
    static_configs:
      - targets: ['homeassistant:9100']
    metrics_path: '/metrics'
    # Uncomment and replace credentials if `enable_basic_auth: true` in config
    # basic_auth:
    #   username: 'your_username'
    #   password: 'your_password'
```
