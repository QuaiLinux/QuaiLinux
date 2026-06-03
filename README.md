# QuaiLinux

QuaiLinux is an early Debian-based live operating system project. The current
build profile creates a Debian Trixie ARM64 or AMD64 live ISO that boots into
KDE Plasma, applies QuaiLinux branding, and includes a Calamares installer
launcher on the desktop.

This repository contains the files needed to build the QuaiLinux ISO profile.
It does not store generated ISOs, Debian package caches, or local build
workspaces.

## Current Status

Working:

- Debian Trixie live ISO build profile
- ARM64 build tested through ISO generation
- KDE Plasma desktop
- QuaiLinux wallpaper and application icon
- QuaiLinux `/etc/os-release` branding
- dark Breeze Plasma defaults
- QuaiLinux live boot menu labels
- Calamares package included in the live system
- `Install QuaiLinux` launcher with live-session sudo startup and debug logging

Known issue:

- Calamares is included and branded, and the launcher now preserves the
  live-session display environment. The full install flow is still experimental
  until the Calamares modules are boot-tested and fixed.
- If the installer does not start in the live session, check:
  `/tmp/quailinux-installer.log`

## Repository Layout

```text
quailinux/live/      live-build profile for the KDE Plasma live ISO
quailinux/netinst/   older automated Debian netinst/preseed experiment
quailinux/scripts/   helper scripts for ISO remastering experiments
build/               small verification manifests from known builds
```

Generated build outputs are intentionally ignored:

```text
dist/                generated ISO files
downloads/           downloaded Debian installer images and checksums
debian-cd/           local upstream checkout, not required in this repo
debian-installer/    local upstream checkout, not required in this repo
live-build/          local upstream checkout, not required in this repo
live-boot/           local upstream checkout, not required in this repo
```

## Build Requirements

Build inside Debian, not directly on macOS. The profile uses Debian tools,
Debian package metadata, root/fakeroot behavior, udebs, and archive layout.

On a Debian Trixie build machine or VM:

```sh
sudo apt update
sudo apt install live-build xorriso squashfs-tools rsync ca-certificates curl
```

## Build The Live ISO

For ARM64:

```sh
cd quailinux/live
./build-live.sh arm64
```

For AMD64:

```sh
cd quailinux/live
./build-live.sh amd64
```

The build script configures:

- Debian Trixie
- `main contrib non-free non-free-firmware`
- KDE Plasma desktop
- Calamares and Debian Calamares settings
- live installer mode
- Debian network mirrors
- QuaiLinux ISO metadata

The generated ISO is written in the live build directory with a name similar to:

```text
quailinux-live-arm64-arm64.hybrid.iso
```

## Branding

The live profile includes:

- wallpaper:
  `quailinux/live/config/includes.chroot/usr/share/backgrounds/quailinux/wallpaper.png`
- KDE wallpaper package metadata:
  `quailinux/live/config/includes.chroot/usr/share/wallpapers/QuaiLinux/`
- application icon:
  `quailinux/live/config/includes.chroot/usr/share/icons/hicolor/256x256/apps/quailinux-installer.png`
- Calamares branding:
  `quailinux/live/config/includes.chroot/etc/calamares/branding/quailinux/`
- OS release branding hook:
  `quailinux/live/config/hooks/normal/0100-quailinux-branding.hook.chroot`
- boot menu branding hook:
  `quailinux/live/config/hooks/normal/7000-quailinux-boot-branding.hook.binary`

## Development Notes

The best next step is to replace direct live-build file includes with proper
Debian packages:

- `quailinux-artwork`
- `quailinux-kde-settings`
- `quailinux-calamares-settings`
- `quailinux-base-files`

That will make installation to disk cleaner and easier to maintain.

## License

QuaiLinux project files are licensed under the QuaiLinux Attribution Fork
License in `LICENSE`. Debian and third-party packages used by the ISO remain
under their own upstream licenses.
