# Home Assistant Add-on: smartctl exporter

## Configuration

### Options

- **smartctl_interval** (string, default: `"60s"`): The interval between smartctl polls. Valid time units are "s", "m", "h". For example: "30s", "5m", "1h".

- **smartctl_rescan** (string, default: `"10m"`): The interval between rescanning for new/disappeared devices. Set to less than "1s" to disable rescanning. This option is ignored if specific devices are configured.

- **log_level** (string, default: `"info"`): Set the logging verbosity. Options are: `debug`, `info`, `warn`, `error`.

- **smartctl_devices** (list, optional): List of specific devices to monitor. If not specified, the add-on will automatically scan and monitor all available devices. Example: `["/dev/sda", "/dev/nvme0"]`

- **smartctl_device_exclude** (string, optional): Regular expression pattern to exclude devices from automatic scanning. Mutually exclusive with `smartctl_device_include`. Example: `"^/dev/loop"` to exclude loop devices.

- **smartctl_device_include** (string, optional): Regular expression pattern to include only specific devices in automatic scanning. Mutually exclusive with `smartctl_device_exclude`. Example: `"^/dev/sd"` to include only SATA/SCSI devices.

### Example Configuration

**Default (automatic device discovery):**
```yaml
smartctl_interval: "60s"
smartctl_rescan: "10m"
log_level: "info"
smartctl_devices: []
```

**Monitoring specific devices:**
```yaml
smartctl_interval: "60s"
smartctl_rescan: "10m"
log_level: "info"
smartctl_devices:
  - "/dev/sda"
  - "/dev/sdb"
  - "/dev/nvme0"
```

**Excluding certain devices:**
```yaml
smartctl_interval: "60s"
smartctl_rescan: "10m"
log_level: "info"
smartctl_devices: []
smartctl_device_exclude: "^/dev/loop"
```

**Debug logging:**
```yaml
smartctl_interval: "60s"
smartctl_rescan: "10m"
log_level: "debug"
smartctl_devices: []
```

## Usage

Once the add-on is running, it exposes Prometheus metrics on port 9633 at the `/metrics` endpoint.

You can access the metrics at: `http://homeassistant.local:9633/metrics` (or use your Home Assistant's IP address).

### Integrating with Prometheus

Add the following to your Prometheus configuration to scrape metrics from this exporter:

```yaml
scrape_configs:
  - job_name: 'smartctl'
    static_configs:
      - targets: ['homeassistant.local:9633']
```

### Viewing Metrics

You can view the raw metrics by navigating to the WebUI link in the add-on page, or by visiting `http://homeassistant.local:9633/metrics` in your browser.

## Metrics Exported

The exporter provides various SMART metrics including:

- Device information (model, serial number, firmware version)
- Temperature readings
- Power-on hours
- Power cycle count
- SMART attributes (raw values and normalized values)
- Error counts
- Self-test results
- And many more...

For a complete list of metrics, visit the `/metrics` endpoint.

## Troubleshooting

### No devices found

If the add-on starts but reports no devices:

1. Check the add-on logs for any errors
2. Verify that your devices are accessible with the command: `smartctl --scan`
3. Try specifying devices manually using the `smartctl_devices` configuration option
4. Ensure the add-on has the necessary privileges (it should have by default)

### Permission errors

If the logs look something look like the ones below, you may need to disable "Protection mode" on the add-on [Info](./info) page.

```
time=2025-11-10T02:17:21.183Z level=ERROR source=readjson.go:146 msg="Device open failed, device did not return an IDENTIFY DEVICE structure, or device is in a low-power mode" device="/dev/nvme0;nvme (nvme0)"
time=2025-11-10T02:17:21.183Z level=ERROR source=readjson.go:178 msg="Smartctl open device: /dev/nvme0 failed: Operation not permitted"
time=2025-11-10T02:17:21.183Z level=WARN source=readjson.go:130 msg="device not found" device="/dev/nvme0;nvme (nvme0)"
```

While this add-on is configured with the `SYS_RAWIO`, `SYS_ADMIN`, and `DAC_READ_SEARCH` capabilities, this is often not enough for Home Assistant to provide the necessary permissions.

If you see permission errors in the logs and enabling Protection Mode doesn't solve them, please [report an issue on GitHub](https://github.com/tigattack/hass-addons).
