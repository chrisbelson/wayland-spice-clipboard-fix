#!/bin/bash

mkdir -p ~/.config/autostart

cat > ~/.config/autostart/spice-vdagent-manual.desktop << 'EOD'
[Desktop Entry]
Type=Application
Name=SPICE VD Agent Manual
Exec=/bin/bash -c 'sleep 5 && nohup /usr/bin/spice-vdagent -x > /dev/null 2>&1 &'
Hidden=false
NoDisplay=true
X-GNOME-Autostart-enabled=true
EOD

echo "spice-vdagent autostart configured"
