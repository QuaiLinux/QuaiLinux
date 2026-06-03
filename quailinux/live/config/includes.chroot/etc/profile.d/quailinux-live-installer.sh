#!/bin/sh

if [ -d /run/live ] && [ "${USER:-}" = "quai" ]; then
    desktop_dir="${HOME:-/home/quai}/Desktop"
    desktop_file="$desktop_dir/quailinux-installer.desktop"
    if [ ! -e "$desktop_file" ] && [ -r /usr/share/applications/quailinux-installer.desktop ]; then
        mkdir -p "$desktop_dir"
        cp /usr/share/applications/quailinux-installer.desktop "$desktop_file"
        chmod +x "$desktop_file"
    fi
fi
