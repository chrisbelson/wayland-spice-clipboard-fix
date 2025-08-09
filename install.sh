#!/bin/bash
set -e

echo "Installing Wayland SPICE clipboard fix..."

if [ "$XDG_SESSION_TYPE" != "wayland" ]; then
    echo "Warning: Not running on Wayland session"
    read -p "Continue? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

echo "Installing dependencies..."
sudo dnf install -y wl-clipboard xclip spice-vdagent

echo "Installing bridge script..."
sudo cp scripts/wayland-spice-clipboard /usr/local/bin/
sudo chmod +x /usr/local/bin/wayland-spice-clipboard

echo "Setting up service..."
mkdir -p ~/.config/systemd/user
cp systemd/wayland-spice-clipboard.service ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable wayland-spice-clipboard.service
systemctl --user start wayland-spice-clipboard.service

echo "Setting up spice agent..."
./scripts/setup-spice-autostart.sh

sudo systemctl enable spice-vdagentd
sudo systemctl start spice-vdagentd

echo "Installation complete!"
echo "Check status: systemctl --user status wayland-spice-clipboard.service"
echo "Monitor logs: journalctl --user -u wayland-spice-clipboard.service -f"
