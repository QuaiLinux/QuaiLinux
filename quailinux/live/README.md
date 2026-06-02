# QuaiLinux Live + Calamares Profile

This profile builds a Debian Trixie live ISO that boots into KDE Plasma and
offers a polished Calamares installer app.

## Included branding

- Icon: `config/includes.chroot/usr/share/quailinux/artwork/icon.png`
- Wallpaper: `config/includes.chroot/usr/share/quailinux/artwork/wallpaper.png`
- KDE wallpaper install path:
  `config/includes.chroot/usr/share/backgrounds/quailinux/wallpaper.png`
- Calamares branding:
  `config/includes.chroot/etc/calamares/branding/quailinux/branding.desc`
- Installer shortcut:
  `config/includes.chroot/usr/share/applications/quailinux-installer.desktop`

## Build

Build inside Debian, not macOS:

```sh
cd quailinux/live
sudo apt update
sudo apt install live-build
./build-live.sh amd64
```

For ARM64:

```sh
./build-live.sh arm64
```

The build script configures:

- Debian Trixie
- KDE Plasma
- Calamares
- Debian live installer mode
- Debian network mirrors
- firmware archive areas
- QuaiLinux ISO metadata

## Notes

The current setup uses Debian's `calamares-settings-debian` package, then
switches its branding from `debian` to `quailinux` during the live-build chroot
hook.

For the next polish pass, create real Debian packages:

- `quailinux-artwork`
- `quailinux-kde-settings`
- `quailinux-calamares-settings`
