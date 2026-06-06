#!/bin/sh
set -eu

cd "$(dirname "$0")"

arch=${1:-amd64}

case "$arch" in
    amd64|arm64) ;;
    *) echo "unsupported architecture: $arch" >&2; exit 1 ;;
esac

boot_packages=config/package-lists/quailinux-boot.list.chroot
case "$arch" in
    amd64)
        kernel_package=linux-image-amd64
        grub_package=grub-efi-amd64
        grub_bin_package=grub-efi-amd64-bin
        ;;
    arm64)
        kernel_package=linux-image-arm64
        grub_package=grub-efi-arm64
        grub_bin_package=grub-efi-arm64-bin
        ;;
esac

cleanup() {
    rm -f "$boot_packages"
}
trap cleanup EXIT INT TERM

cat > "$boot_packages" <<EOF
$kernel_package
$grub_package
$grub_bin_package
EOF

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
    --debian-installer false \
    --debian-installer-gui false \
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
