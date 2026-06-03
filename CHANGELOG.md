# Changelog

## 0.1.9 - 2026-06-03

### Fixed

- Restored `root:root` ownership and `4755` setuid mode for `/usr/bin/sudo`
  and `/usr/bin/pkexec` in the build hook and live boot repair script.
- Made the `Install QuaiLinux` launcher skip broken sudo and fall back to
  `pkexec` when needed.
- Added a KDE autostart desktop cleanup that removes leftover `Install Debian`
  desktop launchers after Plasma starts and recreates only `Install QuaiLinux`.

### Verification

- Parsed the Calamares settings, package module, and branding YAML files.
- Ran shell syntax checks for the installer launcher, Calamares starter,
  live-permissions repair script, live desktop cleanup script, profile hook, and
  branding hook.
- Ran Python syntax compilation for the QuaiLinux Welcome app.

## 0.1.8 - 2026-06-03

### Fixed

- Fixed the `Install QuaiLinux` launcher passing Calamares the settings file
  path as a config directory; it now starts Calamares with `/etc/calamares`.
- Added a live boot-time permissions repair service so `/etc/sudoers.d` and
  `/etc/sudoers.d/quailinux-live` are forced back to root ownership before the
  desktop session uses sudo.
- Expanded live desktop cleanup to remove leftover `Install Debian` launchers
  by filename and by desktop-file contents.

### Changed

- Switched the `Install QuaiLinux` launcher icon to the Calamares installer icon.
- Added root KDE dark-theme config and preserved KDE/Qt theme environment when
  launching Calamares as root.

### Verification

- Parsed the Calamares settings, package module, and branding YAML files.
- Ran shell syntax checks for the installer launcher, Calamares starter,
  permissions repair script, profile hook, and branding hook.
- Ran Python syntax compilation for the QuaiLinux Welcome app.
- Rebuilt the ARM64 live ISO and verified UEFI El Torito boot metadata, root
  ownership for the SquashFS root and sudoers paths, the Calamares config
  directory launch argument, the Calamares icon, root dark-theme config, and the
  QuaiLinux wallpaper hash.

## 0.1.7 - 2026-06-03

### Fixed

- Added ARM64 GRUB/EFI packages to the live image and Calamares package step so
  the Calamares bootloader module can run `grub-install`.
- Hid leftover Debian/Calamares installer launchers and kept the live desktop
  focused on one visible `Install QuaiLinux` launcher.
- Hardened the wallpaper first-login helper so it tries Plasma DBus and config
  writes before marking the QuaiLinux wallpaper as applied.

### Added

- Added a Casual category to the QuaiLinux Welcome app with everyday desktop
  packages and a matching SVG icon.

### Verification

- Parsed the Calamares package and branding YAML files.
- Ran shell syntax checks for the installer launchers, wallpaper helper,
  profile hook, branding hook, and build script.
- Ran Python syntax compilation for the QuaiLinux Welcome app.
- Checked the new Casual and GRUB package names against the Trixie ARM64
  package cache.
- Rebuilt the ARM64 live ISO and verified UEFI El Torito boot metadata,
  `grub-install` inside the SquashFS, the Casual welcome assets, and the
  QuaiLinux wallpaper hash.

## 0.1.6 - 2026-06-03

### Fixed

- Added an explicit QuaiLinux `/etc/calamares/settings.conf` so Calamares does
  not fail when Debian's default settings file is absent.
- Made the installer launcher and root starter fall back to a per-user log file
  if `/tmp/quailinux-installer.log` has stale permissions.
- Changed the live-build profile to build a live-Calamares ISO without the
  extra Debian Installer payload.

### Added

- Added QuaiLinux ASCII art for `fastfetch` and a `neofetch` compatibility
  launcher.
- Added a first-login Qt/KDE-style QuaiLinux Welcome app with large Gamers,
  Artists, Programmers, and Hackers package-set cards and opt-out package
  checkboxes.
- Added a terminal-backed `.deb` installer handler so double-clicked Debian
  packages install through `apt` and resolve missing dependencies.

### Verification

- Parsed the Calamares settings, package module, and branding YAML files.
- Ran shell syntax checks for the installer, `.deb` handler, build script, and
  branding hook.
- Ran Python syntax compilation for the QuaiLinux Welcome app.
- Checked the welcome app's Debian-native package names against the Trixie ARM64
  package cache; vendor/Kali-only entries are skipped by the app if unavailable.
- Rebuilt the ARM64 live ISO and verified UEFI El Torito boot metadata, the
  fixed Calamares settings, welcome app files, and QuaiLinux ASCII art inside
  the image.

## 0.1.5 - 2026-06-03

### Changed

- Updated the default QuaiLinux wallpaper from the newest
  `/Users/mateocogeanu/Downloads/wallpaper.png` asset.

### Verification

- Rebuilt the ARM64 live ISO after the wallpaper update.
- Verified the wallpaper inside `filesystem.squashfs` matches the downloaded
  wallpaper asset hash.

## 0.1.4 - 2026-06-03

### Changed

- Replaced the `Install QuaiLinux` desktop/menu icon with the standard
  `system-software-install` installer icon instead of using the QuaiLinux logo.
- Updated the default QuaiLinux wallpaper from the latest
  `/Users/mateocogeanu/Downloads/wallpaper.png` asset.
- Added system-wide and skeleton Plasma wallpaper defaults with
  `PreviewImage` entries.
- Added a one-time KDE autostart helper that applies the QuaiLinux wallpaper on
  first login, then leaves later user wallpaper changes alone.
- Moved the live desktop installer icon out of `/etc/skel/Desktop` and into a
  live-session-only profile hook so installed users do not get the installer
  icon on their desktop.
- Added an initial common package/codecs batch to the live image and Calamares
  setup package step: Firefox ESR, FFmpeg, `libavcodec-extra`, GStreamer
  plugins, PipeWire audio, WirePlumber, archive tools, emoji fonts, and
  Mesa VA/Vulkan drivers.

### Verification

- Rebuilt the ARM64 live ISO after the wallpaper, installer icon, desktop, and
  package changes.
- Verified the ISO wallpaper hash matches the new downloaded wallpaper asset.
- Verified `/etc/skel/Desktop/quailinux-installer.desktop` is absent inside the
  SquashFS.
- Verified the installer launcher uses `Icon=system-software-install`.
- Verified the package batch is present in the live image package manifest and
  in Calamares `packages.conf`.

## 0.1.3 - 2026-06-03

### Fixed

- Fixed Calamares startup failure caused by missing required `slideshow` in the
  QuaiLinux branding descriptor.
- Added a simple QuaiLinux Calamares `show.qml` slideshow.
- Added Calamares branding keys for window sizing, sidebar, navigation, and
  capitalized sidebar color settings to match Calamares 3.3 expectations.
- Made the installer launcher create and relax permissions on
  `/tmp/quailinux-installer.log` before the root starter appends to it.

### Verification

- Rebuilt the ARM64 live ISO after the Calamares branding fix.
- Verified `branding.desc`, `show.qml`, and the updated installer launcher are
  present inside the SquashFS with root ownership.
- Verified the ISO remains ARM64 UEFI bootable with volume ID `QUAILINUX_LIVE`.

## 0.1.2 - 2026-06-03

### Fixed

- Fixed live ISO sudo startup by forcing `/etc/sudoers.d` and
  `/etc/sudoers.d/quailinux-live` to be owned by `root:root` with safe sudoers
  permissions.
- Added the same ownership repair to the live boot hook so the live session
  recreates the sudoers rule correctly.

### Verification

- Rebuilt the ARM64 live ISO after the sudoers ownership fix.
- Verified `/etc/sudoers.d` is `root/root` with `0755` permissions inside the
  SquashFS.
- Verified `/etc/sudoers.d/quailinux-live` is `root/root` with `0440`
  permissions inside the SquashFS.

## 0.1.1 - 2026-06-03

### Changed

- Reworked the `Install QuaiLinux` launcher to start Calamares through
  passwordless live-session `sudo` with the display/session environment
  preserved.
- Added `/tmp/quailinux-installer.log` logging for the installer launcher and
  Calamares starter so failed launches can be debugged from the live session.
- Updated live sudoers rules to allow the `quai` live user to run the Calamares
  starter with required GUI environment variables.
- Changed the Calamares starter to run `calamares -d` for better debug output.

### Verification

- Rebuilt the ARM64 live ISO locally after the launcher fix.
- Verified the rebuilt ISO is still ARM64 UEFI bootable and still uses the
  QuaiLinux live boot labels.
- Verified the installer launcher, Calamares starter, and sudoers include are
  present inside the SquashFS with root ownership and expected permissions.

### Known Issues

- The launcher has been fixed for the most likely GUI privilege/session failure,
  but the full Calamares install flow still needs live boot testing.
- Calamares modules and the live-to-disk installation flow are still not
  considered finished.

## 0.1.0 - 2026-06-02

### Added

- Created the QuaiLinux live-build profile for Debian Trixie.
- Added KDE Plasma as the default desktop environment.
- Added Calamares and Debian Calamares settings to the live image.
- Added the `Install QuaiLinux` desktop/menu launcher.
- Added the QuaiLinux icon and wallpaper assets.
- Added default KDE dark theme settings using Breeze Dark.
- Added default KDE wallpaper configuration for live users.
- Added QuaiLinux OS branding through `/usr/lib/os-release`,
  `/etc/os-release`, `/etc/issue`, `/etc/motd`, and hostname defaults.
- Added live-user sudo and polkit rules so installer startup can request
  privileges.
- Added boot menu branding for QuaiLinux live boot entries.
- Added ARM64 live ISO build support and verified an ARM64 UEFI ISO build.
- Added an older netinst/preseed experiment for internet-based KDE installs.

### Changed

- Hid the Debian Calamares desktop launcher and routed it to the QuaiLinux
  launcher to avoid duplicate visible installer icons.
- Renamed live boot entries from generic Debian live labels to QuaiLinux labels.
- Set ISO metadata to QuaiLinux, including the `QUAILINUX_LIVE` volume ID.

### Known Issues

- Calamares is included, branded, and wired to the launcher, but the installer is
  not working reliably yet. The installer modules and live-to-disk flow still
  need testing and fixes before QuaiLinux can be considered installable.

### Build Output

- Produced a verified ARM64 live ISO locally:
  `quailinux-live-13.5.0-arm64-calamares-fixed.iso`.
- Generated ISO artifacts are not committed to Git because they are large build
  outputs.
