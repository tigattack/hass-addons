# Home Assistant Add-on: smartctl exporter

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]

Prometheus exporter for SMART disk metrics using smartctl.

## About

This add-on runs [smartctl_exporter](https://github.com/prometheus-community/smartctl_exporter), which exports SMART metrics from your storage devices in Prometheus format. It automatically discovers storage devices and provides detailed health information about your hard drives and SSDs.

Perfect for monitoring disk health in your home lab or server setup!

## Features

- 🔍 **Automatic Device Discovery**: Automatically finds and monitors all storage devices
- 📊 **Comprehensive Metrics**: Exports detailed SMART attributes including temperature, power-on hours, error counts, and more
- ⚙️ **Configurable**: Customise scan intervals, device filters, and logging levels

## Installation

1. Navigate to the Supervisor panel in Home Assistant
2. Click on the Add-on Store
3. Add this repository URL
4. Find "smartctl exporter" and click Install
5. Configure the add-on (optional, works with defaults)
6. Start the add-on

## Configuration

The add-on works out of the box with automatic device discovery. See the [Documentation](DOCS.md) for advanced configuration options.

## Metrics Access

Metrics are available at: `http://homeassistant.local:9633/metrics`

Click "OPEN WEB UI" in the add-on page to view the metrics directly.

## Credits

This add-on uses:
- [smartctl_exporter](https://github.com/prometheus-community/smartctl_exporter) by the Prometheus Community
- [smartmontools](https://www.smartmontools.org/) for SMART data collection

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
