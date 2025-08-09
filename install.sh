#!/bin/bash
set -e

echo "Installing clipboard bridge..."

sudo dnf install -y wl-clipboard xclip spice-vdagent

sudo cp scripts/wayland-spice-clipboard /usr/local/bin/
sudo chmod +x /usr/local/bin/wayland-spice-clipboard

mkdir -p ~/.config/systemd/user
cp systemd/wayland-spice-clipboard.service ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable wayland-spice-clipboard.service

echo "Installation complete"
