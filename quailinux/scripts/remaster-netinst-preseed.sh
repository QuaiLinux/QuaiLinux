#!/bin/sh
set -eu

if [ "$#" -lt 2 ] || [ "$#" -gt 3 ]; then
    echo "usage: $0 path/to/debian-netinst.iso path/to/quailinux-netinst.iso [arch]" >&2
    exit 2
fi

input_iso=$1
output_iso=$2
arch=${3:-}

for tool in xorriso sed chmod cp mkdir rm; do
    if ! command -v "$tool" >/dev/null 2>&1; then
        echo "missing required tool: $tool" >&2
        exit 1
    fi
done

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/../.." && pwd)
workdir=$(mktemp -d "${TMPDIR:-/tmp}/quailinux-iso.XXXXXX")
trap 'chmod -R u+w "$workdir" 2>/dev/null || true; rm -rf "$workdir"' EXIT INT TERM

extract_dir="$workdir/extract"
mkdir -p "$extract_dir"

xorriso -osirrox on -indev "$input_iso" -extract / "$extract_dir"
chmod -R u+w "$extract_dir"

if [ -z "$arch" ]; then
    case "$(basename -- "$input_iso")" in
        *arm64*) arch=arm64 ;;
        *amd64*) arch=amd64 ;;
        *) arch=amd64 ;;
    esac
fi

case "$arch" in
    amd64) install_dir=/install.amd ;;
    arm64) install_dir=/install.a64 ;;
    *) echo "unsupported arch: $arch" >&2; exit 1 ;;
esac

if [ ! -f "$extract_dir$install_dir/vmlinuz" ] || [ ! -f "$extract_dir$install_dir/initrd.gz" ]; then
    echo "installer kernel/initrd not found under $install_dir in ISO" >&2
    exit 1
fi

mkdir -p "$extract_dir/quailinux"
cp "$repo_root/quailinux/netinst/preseed.cfg" "$extract_dir/preseed.cfg"
cp "$repo_root/quailinux/netinst/postinstall.sh" "$extract_dir/quailinux/postinstall.sh"
chmod +x "$extract_dir/quailinux/postinstall.sh"

if [ -f "$extract_dir/isolinux/txt.cfg" ]; then
    cat >> "$extract_dir/isolinux/txt.cfg" <<'EOF'

label quailinux-auto
    menu label Automated QuaiLinux KDE install
EOF
    {
        echo "    kernel $install_dir/vmlinuz"
        echo "    append auto=true priority=critical file=/cdrom/preseed.cfg vga=788 initrd=$install_dir/initrd.gz --- quiet"
    } >> "$extract_dir/isolinux/txt.cfg"
fi

if [ -f "$extract_dir/boot/grub/grub.cfg" ]; then
    sed -i.bak "s/Debian GNU\\/Linux/QuaiLinux/g" "$extract_dir/boot/grub/grub.cfg"
    cat >> "$extract_dir/boot/grub/grub.cfg" <<EOF

menuentry 'Automated QuaiLinux KDE install' {
    set background_color=black
    linux    $install_dir/vmlinuz auto=true priority=critical file=/cdrom/preseed.cfg vga=788 --- quiet
    initrd   $install_dir/initrd.gz
}
EOF
    rm -f "$extract_dir/boot/grub/grub.cfg.bak"
fi

volume_id=QUAILINUX_NETINST

if [ -f "$extract_dir/isolinux/isolinux.bin" ] && [ -f "$extract_dir/isolinux/isohdpfx.bin" ]; then
    xorriso -as mkisofs \
        -r -V "$volume_id" \
        -o "$output_iso" \
        -J -joliet-long \
        -cache-inodes \
        -isohybrid-mbr "$extract_dir/isolinux/isohdpfx.bin" \
        -partition_offset 16 \
        -A "$volume_id" \
        -b isolinux/isolinux.bin \
        -c isolinux/boot.cat \
        -no-emul-boot -boot-load-size 4 -boot-info-table \
        -eltorito-alt-boot \
        -e boot/grub/efi.img \
        -no-emul-boot -isohybrid-gpt-basdat \
        "$extract_dir"
else
    xorriso \
        -indev "$input_iso" \
        -outdev "$output_iso" \
        -boot_image any replay \
        -volid "$volume_id" \
        -map "$extract_dir/preseed.cfg" /preseed.cfg \
        -map "$extract_dir/quailinux" /quailinux \
        -map "$extract_dir/boot/grub/grub.cfg" /boot/grub/grub.cfg \
        -commit
fi

echo "Wrote $output_iso"
