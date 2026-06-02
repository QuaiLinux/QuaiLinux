#!/bin/sh
set -eu

printf 'QuaiLinux\n' > /etc/hostname
cat > /etc/hosts <<'EOF'
127.0.0.1 localhost
127.0.1.1 quailinux QuaiLinux

::1 localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
EOF

cat > /etc/quailinux-release <<'EOF'
QuaiLinux based on Debian
EOF

cat > /etc/motd <<'EOF'
Welcome to QuaiLinux.
EOF

mkdir -p /usr/share/quailinux
cat > /usr/share/quailinux/README <<'EOF'
This system was installed by the QuaiLinux automated KDE netinst profile.

For deeper branding, build custom packages such as:
- quailinux-base-files
- quailinux-artwork
- quailinux-kde-settings
EOF

if command -v update-alternatives >/dev/null 2>&1; then
    true
fi
