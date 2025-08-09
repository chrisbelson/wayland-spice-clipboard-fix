#!/bin/bash

echo "Removing Wayland SPICE clipboard fix..."

systemctl --user stop wayland-spice-clipboard.service 2>/dev/null || true
systemctl --user disable wayland-spice-clipboard.service 2>/dev/null || true

rm -f ~/.config/systemd/user/wayland-spice-clipboard.service
rm -f ~/.config/autostart/spice-vdagent-manual.desktop
sudo rm -f /usr/local/bin/wayland-spice-clipboard

systemctl --user daemon-reload

echo "Removal complete"
echo "Note: Dependencies and SPICE services left unchanged"
