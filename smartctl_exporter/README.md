# Home Assistant App: smartctl exporter

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]

App for Prometheus smartctl_exporter - Exposes SMART disk info in Prometheus metrics format using smartctl.

## About

This app runs [smartctl_exporter](https://github.com/prometheus-community/smartctl_exporter), which exports SMART metrics from your storage devices in Prometheus format. It automatically discovers storage devices and provides detailed health information about your hard drives and SSDs.

Perfect for monitoring disk health in your home lab or server setup!

## Features

- 🔍 **Automatic Device Discovery**: Automatically finds and monitors all storage devices
- 📊 **Comprehensive Metrics**: Exports detailed SMART attributes including temperature, power-on hours, error counts, and more
- ⚙️ **Configurable**: Customise scan intervals, device filters, and logging levels

## Installation

1. Navigate to the Supervisor panel in Home Assistant
2. Click on the App Store
3. Add this repository URL
4. Find "smartctl exporter" and click Install
5. Configure the app (optional, works with defaults)
6. Start the app

## Configuration

The app works out of the box with automatic device discovery. See the [Documentation](./DOCS.md) for advanced configuration options.

## Metrics Access

Metrics are available at: `http://homeassistant.local:9633/metrics`

Click "OPEN WEB UI" in the app page to view the metrics directly.

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
