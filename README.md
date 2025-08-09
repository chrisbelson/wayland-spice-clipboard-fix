# Wayland SPICE Clipboard Fix

Fixes clipboard synchronization between Wayland guests and SPICE hosts.

Tested on Fedora 42 with KDE Plasma 6.

## Problem

spice-vdagent has poor Wayland compatibility:
- Host to guest clipboard: works
- Guest to host clipboard: broken
- Errors: "could not connect to X-server" or mutter DBUS failures

## Solution

Creates a bridge between Wayland and X11 clipboards so spice-vdagent can function.

Pipeline: Wayland clipboard → Bridge → X11 clipboard → spice-vdagent → Host

## Installation

```bash
git clone https://github.com/yourusername/wayland-spice-clipboard-fix.git
cd wayland-spice-clipboard-fix
./install.sh
```

## Requirements

- Fedora with Wayland
- SPICE virtualization
- KDE Plasma (tested with Plasma 6)

## Features

- Auto-detects X11 display
- Handles clipboard content properly
- Systemd integration
- Automatic restart on failures
- Easy installation and removal

## Verification

```bash
# Check service status
systemctl --user status wayland-spice-clipboard.service

# Watch clipboard activity
journalctl --user -u wayland-spice-clipboard.service -f

# Test clipboard sync both directions
```

## How it works

1. Bridge monitors Wayland clipboard with wl-paste
2. Auto-detects correct X11 display
3. Forwards clipboard content to X11 via xclip  
4. spice-vdagent reads X11 clipboard and syncs to host
5. systemd manages the bridge service lifecycle

## Troubleshooting

See docs/README.md for common issues and solutions.

## Compatibility

Tested on:
- Fedora 42 + KDE Plasma 6 + Wayland
- SPICE/QXL virtualization
- QEMU/KVM

Should work on other Fedora versions and SPICE setups.

Not needed for X11 sessions (spice-vdagent works natively).

## License

MIT
