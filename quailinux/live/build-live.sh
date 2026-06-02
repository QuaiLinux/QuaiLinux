#!/bin/sh
set -eu

cd "$(dirname "$0")"

arch=${1:-amd64}

case "$arch" in
    amd64|arm64) ;;
    *) echo "unsupported architecture: $arch" >&2; exit 1 ;;
esac

if ! command -v lb >/dev/null 2>&1; then
    echo "live-build is required. Build inside Debian and install it with: sudo apt install live-build" >&2
    exit 1
fi

sudo lb clean || true

lb config \
    --mode debian \
    --distribution trixie \
    --architectures "$arch" \
    --binary-images iso-hybrid \
    --archive-areas "main contrib non-free non-free-firmware" \
    --debian-installer live \
    --debian-installer-gui true \
    --firmware-binary true \
    --firmware-chroot true \
    --iso-application "QuaiLinux Live" \
    --iso-publisher "QuaiLinux" \
    --iso-volume "QUAILINUX_LIVE" \
    --image-name "quailinux-live-$arch" \
    --mirror-bootstrap http://deb.debian.org/debian/ \
    --mirror-chroot http://deb.debian.org/debian/ \
    --mirror-binary http://deb.debian.org/debian/ \
    --mirror-binary-security http://security.debian.org/

sudo lb build
