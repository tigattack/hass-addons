# CHANGELOG

<!-- https://keepachangelog.com -->

## [2.0.0] - 2026-08-02

Changed:

- Migrated from add-on packaging to app packaging.
- Switched image naming to a single multi-arch image (`ghcr.io/tigattack/app-smartctl-exporter`).
- Removed `build.yaml` and moved base image selection into `Dockerfile`.


## [1.2.0] - 2025-11-14

Fixed:

- Correctly parse `smartctl_devices`

Changed:

- Update launch scripts

## [1.1.0] - 2025-11-13

Changed:

- Set startup type to service (starts before HASS Core)
- Refactor startup script to make better use of bashio

## [1.0.0] - 2025-11-12

Changed:

- Renamed add-on directory name in repository
- Updated add-on description
- Tweaked Dockerfile & build

## [0.2.1] - 2025-11-10

Changed:

- Updated documentation

## [0.2.0] - 2025-11-10

Fixed:

- Use `full_access` to allow smartctl to access all disks

## [0.1.0] - 2025-11-10

- Initial release
