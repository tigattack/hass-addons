# Home Assistant Add-on: node exporter

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]

Add-on for Prometheus node_exporter - Exposes system statistics like CPU, memory, disk, and network usage in Prometheus metrics format

## Quick Start

1. **Add Repository**: `https://github.com/tigattack/hass-addons`
2. **Install**: Find "Prometheus Node Exporter" and click **INSTALL**
3. **Configure**: Set log level, collectors, and security options as needed
4. **Start**: Click **START** to begin monitoring

## Configuration

### Basic Setup
```yaml
log_level: "info"
enable_basic_auth: false
enable_tls: false
```

### Advanced Features
- Configurable metrics collectors (cpu, meminfo, diskstats, etc.)
- HTTP Basic Authentication support
- TLS/HTTPS encryption
- Custom node_exporter arguments
- Mount point and network device filtering

## Access Metrics

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

## Documentation

For detailed configuration, development information, and advanced features, see [DOCS.md](DOCS.md).

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
