# Changelog

## 0.1.24 - 2026-06-05

### Changed

- Made each QuaiLinux Welcome category tile directly clickable and removed the
  redundant `Open` buttons.
- Rebalanced the Welcome grid with smaller square tiles, less empty vertical
  space, centered titles, and no clipped category text.
- Replaced the category SVG icons with cleaner, more consistent artwork.
- Expanded the Casual, Gamers, Artists, Programmers, and Hackers package lists.
- Split the Artists setup into mergeable `2D`, `3D`, and `Music` groups so
  users can install any combination as one merged package selection.

### Fixed

- Added `plasma-welcome` to the Calamares install-time removal list so KDE
  Plasma Welcome does not compete with QuaiLinux Welcome on installed systems.

### Verification

- Ran Python syntax checks for `quailinux-welcome`.
- Parsed the Calamares packages YAML.
- Launched the rewritten Welcome app in the Debian ARM64 build chroot with
  Qt's offscreen platform to catch runtime construction errors.

## 0.1.23 - 2026-06-05

### Fixed

- Fixed installed ARM64 systems booting to a GRUB menu with only "UEFI
  Firmware Settings" by ensuring the installed target keeps a kernel/initramfs
  in `/boot` before GRUB is generated.
- Moved the QuaiLinux finish-install step before Calamares' bootloader step so
  the target identity and boot files are settled before GRUB installation.
- Added explicit `linux-image-arm64` and `initramfs-tools` package operations
  for ARM64 live installs.
- Added finish-install refreshes for initramfs and GRUB configuration when the
  target system provides those tools.

### Verification

- Ran shell syntax checks for the finish-install hook.
- Parsed the Calamares settings and package module YAML.
- Rebuilt the ARM64 ISO and verified the SquashFS contains
  `/boot/vmlinuz-6.12.90+deb13.1-arm64` and
  `/boot/initrd.img-6.12.90+deb13.1-arm64`.
- Verified the rebuilt ISO volume ID is `QUAILINUX_LIVE`, UEFI El Torito boot
  metadata is present, and the local/VM ISO SHA256 hashes match.

## 0.1.22 - 2026-06-05

### Changed

- Reworked the QuaiLinux Welcome app into square category tiles with only the
  main category names on the first screen.
- Moved package selection into each category flow instead of showing "Choose
  packages" buttons on the welcome grid.
- Replaced terminal-backed `sudo apt` installs with an in-app progress view
  driven by a dedicated privileged helper.
- Added a narrowly scoped polkit rule so active sudo users can run the
  QuaiLinux Welcome package helper without a password prompt.
- Added system-wide autostart overrides for KDE Plasma Welcome so the
  QuaiLinux Welcome app is the first-run experience.

### Verification

- Ran Python syntax checks for `quailinux-welcome`.
- Ran shell syntax checks for the Welcome install helper, branding hook, and
  finish-install hook.

## 0.1.21 - 2026-06-05

### Fixed

- Restored executable file modes on the KPMCore helper wrapper files
  `org.kde.kpmcore.helperinterface`, preventing DBus/KAuth from failing with
  permission errors and causing Calamares to show no installable drives.

### Verification

- Rebuilt the ARM64 ISO and verified the compressed filesystem contains
  executable, root-owned KPMCore helper wrapper files at `/usr/bin` and
  `/usr/lib/aarch64-linux-gnu/libexec`.
- Verified the KPMCore DBus service still points to
  `/usr/bin/org.kde.kpmcore.helperinterface`, so DBus/KAuth can start the
  helper Calamares needs for partition detection.
- Verified the Calamares finish-install job is still present, the ISO volume ID
  is `QUAILINUX_LIVE`, UEFI El Torito boot metadata is present, and the black
  GRUB menu still shows `Try or Install QuaiLinux` with the safe graphics
  option below it.

## 0.1.20 - 2026-06-05

### Fixed

- Corrected the Calamares sequence reference for the QuaiLinux final install
  cleanup job from a literal module name to the `shellprocess` instance syntax,
  so Calamares can load it as `shellprocess@quailinux-finish-install`.

### Verification

- Parsed the Calamares settings and finish-install module YAML.
- Rebuilt the ARM64 ISO and verified the compressed filesystem contains
  `shellprocess@quailinux-finish-install`, executable Welcome and
  finish-install scripts, QuaiLinux OS identity, live runtime mount directories,
  and no macOS resource-fork files.
- Verified the ISO volume ID is `QUAILINUX_LIVE`, UEFI El Torito boot metadata
  is present, the black GRUB menu still shows the requested entries, and the
  VM/local ISO SHA256 hashes match.

## 0.1.19 - 2026-06-05

### Fixed

- Added explicit QuaiLinux `os-release` files to the live overlay so system
  identity no longer falls back to Debian branding if hooks are skipped during
  an incremental rebuild.
- Added a Calamares final shellprocess job that converts the copied live
  filesystem into an installed QuaiLinux system by rewriting OS identity,
  removing `/etc/debian_chroot`, removing live-session config, and removing
  installer launchers from the target system.
- Changed the fastfetch/neofetch ASCII text so it no longer says `live`.
- Fixed the tracked executable mode for `quailinux-welcome` and added an
  install-time chmod fallback so KDE can launch the Welcome app after install.

### Verification

- Ran shell syntax checks for the install cleanup script and branding hook.
- Parsed the Calamares settings and finish-install module YAML.
- Rebuilt the ARM64 ISO and verified the compressed filesystem contains
  QuaiLinux `os-release`, executable `quailinux-welcome`, the Calamares
  finish-install job, cleaned ASCII art text, live runtime mount directories,
  and no macOS resource-fork files or local uid/gid ownership.
- Verified the ISO volume ID is `QUAILINUX_LIVE`, UEFI El Torito boot metadata
  is present, the black GRUB menu still shows the requested entries, and the
  VM/local ISO SHA256 hashes match.

## 0.1.18 - 2026-06-04

### Fixed

- Rebuilt the ARM64 live filesystem with `/dev`, `/proc`, `/sys`, `/run`, and
  `/tmp` present again after the previous fast SquashFS rebuild excluded those
  runtime mount directories and could reach GRUB without starting the live OS.

### Verification

- Verified the corrected SquashFS contains the live runtime mount directories,
  the installer no-sleep inhibitor commands remain present, the ISO volume ID
  is `QUAILINUX_LIVE`, the GRUB menu still shows `Try or Install QuaiLinux`
  with the safe graphics option below it, UEFI El Torito boot metadata is
  present, and the VM/local ISO SHA256 hashes match.

## 0.1.17 - 2026-06-04

### Fixed

- Started the installer through KDE and systemd inhibitors so Plasma should not
  blank, sleep, or lock the live session while Calamares is running.
- Disabled X11 DPMS/screensaver blanking as a fallback before launching the
  installer.
- Simplified the ARM64 GRUB live menu to `Try or Install QuaiLinux` followed by
  `Try or Install QuaiLinux (safe graphics)`.
- Forced the GRUB menu theme to a plain black background instead of the old live
  boot splash styling.

### Verification

- Ran shell syntax checks for the installer launcher, Calamares starter, and
  boot-branding hook.
- Rebuilt the ARM64 ISO and verified the compressed filesystem contains the
  inhibitor commands, the ISO volume ID is `QUAILINUX_LIVE`, the GRUB menu has
  the requested entries on a black theme, UEFI El Torito boot metadata is
  present, and the VM/local ISO SHA256 hashes match.

## 0.1.16 - 2026-06-04

### Fixed

- Added executable KPMCore helper aliases named
  `org.kde.kpmcore.helperinterface` in `/usr/bin` and the ARM64 libexec
  directory, matching the program name Calamares/KAuth tried to spawn.
- Overrode the KPMCore DBus system service to launch the helper through the
  executable alias.
- Expanded the live DBus rule to allow KAuth traffic for the KPMCore helper.
- Reloaded the system bus config and pre-started the KPMCore helper from the
  Calamares starter before the partition module scans disks.

### Verification

- Rebuilt the ARM64 ISO and verified the helper aliases, DBus service override,
  DBus policy, empty `/proc` and `/sys` trees, UEFI El Torito boot metadata,
  and matching VM/local ISO SHA256 hash.

## 0.1.15 - 2026-06-04

### Fixed

- Added live DBus and polkit overrides for the KPMCore partition helper so
  Calamares can start `org.kde.kpmcore.helperinterface` and detect the target
  disk that `lsblk` already sees.
- Overrode KDE, Debian, Breeze, Breeze Dark, and Breeze Twilight look-and-feel
  wallpaper defaults to use the `QuaiLinux` wallpaper package instead of
  `Next` or `DebianTheme`.
- Replaced the bundled wallpaper asset with the newer `wallpaperdark.png` from
  Downloads, since `wallpaper.png` matched the old bundled file byte-for-byte.
- Made the first-login wallpaper helper retry while Plasma starts so it does
  not mark itself done before the desktop shell can accept the wallpaper change.

### Verification

- Ran shell syntax checks for the wallpaper helper, live polkit hook, and
  branding hook.
- Parsed the KPMCore DBus override XML.
- Rebuilt the ARM64 ISO and verified the KPMCore DBus override, live polkit
  rule, executable KPMCore helper, QuaiLinux look-and-feel wallpaper defaults,
  updated wallpaper hash, empty `/proc` and `/sys` trees, and UEFI El Torito
  boot metadata inside the rebuilt image.

## 0.1.14 - 2026-06-04

### Fixed

- Made the QuaiLinux installer launcher and Calamares starter choose a writable
  log before writing, so stale `/tmp/quailinux-installer.log` permissions no
  longer skip the storage preflight.
- Made the root Calamares starter recreate `/tmp/quailinux-installer.log` as a
  world-readable/writable live-session log before probing disks.
- Redirected Calamares debug output from the root starter so the storage
  preflight and Calamares partition diagnostics stay in the same `/tmp` log.

### Verification

- Ran shell syntax checks for the QuaiLinux installer launcher and Calamares
  starter.
- Parsed the Calamares YAML configuration files.
- Rebuilt the ARM64 ISO and verified the safe logging scripts, empty `/proc`
  and `/sys` trees, and UEFI El Torito boot metadata inside the rebuilt image.

## 0.1.13 - 2026-06-04

### Fixed

- Forced Plasma's default wallpaper theme to the `QuaiLinux` wallpaper package
  instead of KDE/Debian's `Next` wallpaper.
- Updated the first-login wallpaper helper to write the Plasma wallpaper
  package id and package preview path, with raw image application retained as a
  fallback.
- Added an explicit Calamares `partition.conf` for ARM64/EFI installs with
  GPT defaults, manual partitioning enabled, LVM enabled, and live-media mount
  exceptions.
- Made the Calamares launcher log mounted filesystems, turn off swap, and
  unmount only user-mounted target paths under `/media`, `/run/media`, and
  `/mnt` before probing disks.

### Verification

- Parsed Calamares `settings.conf`, `packages.conf`, `partition.conf`, and
  branding YAML.
- Ran shell syntax checks for the Calamares starter, wallpaper helper, and
  branding hook.
- Rebuilt the ARM64 ISO and verified `partition.conf`, the storage preflight,
  Plasma `QuaiLinux` wallpaper defaults, empty `/proc` and `/sys` trees, and
  UEFI El Torito boot metadata inside the rebuilt image.

## 0.1.12 - 2026-06-04

### Fixed

- Added a Calamares storage preflight that loads common VM/storage drivers,
  triggers and settles udev, starts `udisks2`, probes partitions, and logs
  `lsblk` before opening the installer.
- Added common partitioning and filesystem tools to the live image and
  installer package step so Calamares has the helpers needed for VM disks,
  LVM/mapper devices, NTFS, exFAT, XFS, Btrfs, and encrypted installs.

### Verification

- Parsed the Calamares settings, package module, and branding YAML files.
- Ran shell syntax checks for the Calamares starter and branding hook.
- Ran Python syntax compilation for the QuaiLinux Welcome app.
- Installed the added storage helpers into the ARM64 chroot, rebuilt the
  SquashFS, and verified the preflight script, storage tools, empty `/proc` and
  `/sys` trees, and UEFI El Torito boot metadata in the rebuilt ISO.

## 0.1.11 - 2026-06-04

### Fixed

- Added explicit ARM64 Calamares module-search paths so the live installer can
  load `welcome`, `partition`, `users`, `packages`, and the other configured
  modules.
- Replaced Debian's Calamares desktop-icon autostart with a hidden QuaiLinux
  override during the build, so Plasma does not recreate `Install Debian`.
- Made the live desktop cleanup retry for several seconds and recreate only the
  `Install QuaiLinux` launcher.

### Verification

- Parsed the Calamares settings, package module, and branding YAML files.
- Ran shell syntax checks for the Calamares starter, live desktop cleanup,
  Debian icon override, live permission repair, and branding hook.
- Ran Python syntax compilation for the QuaiLinux Welcome app.
- Rebuilt the ARM64 live ISO and verified UEFI El Torito boot metadata, the
  ARM64 Calamares module directory, `/usr/share/calamares/qml`, hidden Debian
  Calamares autostart override, hidden Debian Calamares desktop-file override,
  sudo/pkexec setuid ownership, and the QuaiLinux-only top-level GRUB menu.

## 0.1.10 - 2026-06-03

### Fixed

- Removed the Calamares `-c /etc/calamares` launch override so Calamares uses
  `/etc/calamares/settings.conf` while keeping its normal
  `/usr/share/calamares/qml` application data directory.
- Removed the invalid literal `${LIBDIR}` Calamares module-search override.
- Overrode Debian's `add-calamares-desktop-icon` helper so it cannot recreate
  an `Install Debian` launcher and instead leaves only `Install QuaiLinux`.
- Added hidden QuaiLinux overrides for Calamares' Debian desktop files so
  package-provided menu entries no longer say `Install Debian`.
- Recreated `/tmp/quailinux-installer.log` as a writable live-session log file
  during boot-time permission repair.

### Verification

- Parsed the Calamares settings, package module, and branding YAML files.
- Ran shell syntax checks for the Calamares starter, live permission repair,
  desktop cleanup, Debian icon override, and branding hook.
- Ran Python syntax compilation for the QuaiLinux Welcome app.
- Rebuilt the ARM64 live ISO and verified UEFI El Torito boot metadata,
  `/usr/share/calamares/qml` inside the SquashFS, the Calamares launcher using
  the normal settings path, hidden QuaiLinux overrides for Debian Calamares
  desktop files, the Debian desktop-icon helper override, and the QuaiLinux
  wallpaper hash.

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
- Rebuilt the ARM64 live ISO and verified UEFI El Torito boot metadata,
  `/usr/bin/sudo` and `/usr/bin/pkexec` as `root:root` setuid binaries, root
  ownership for `/etc/sudoers.d`, the post-Plasma desktop cleanup files, and no
  UID 501/staff ownership in the SquashFS owner table.

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
