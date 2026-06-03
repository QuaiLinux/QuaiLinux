#!/bin/sh

if [ -d /run/live ] && [ "${USER:-}" = "quai" ]; then
    desktop_dir="${HOME:-/home/quai}/Desktop"
    desktop_file="$desktop_dir/quailinux-installer.desktop"
    mkdir -p "$desktop_dir"
    rm -f \
        "$desktop_dir/calamares.desktop" \
        "$desktop_dir/calamares-install-debian.desktop" \
        "$desktop_dir/install-debian.desktop" \
        "$desktop_dir/debian-installer.desktop"
    for candidate in "$desktop_dir"/*.desktop; do
        [ -f "$candidate" ] || continue
        if grep -Eiq 'Install Debian|calamares|debian-installer|install-debian' "$candidate" 2>/dev/null; then
            rm -f "$candidate"
        fi
    done
    if [ ! -e "$desktop_file" ] && [ -r /usr/share/applications/quailinux-installer.desktop ]; then
        cp /usr/share/applications/quailinux-installer.desktop "$desktop_file"
        chmod +x "$desktop_file"
    fi
fi
