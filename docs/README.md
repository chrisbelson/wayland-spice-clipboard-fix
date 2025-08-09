# Documentation

## Troubleshooting

### Service not starting
Check status: `systemctl --user status wayland-spice-clipboard.service`
View logs: `journalctl --user -u wayland-spice-clipboard.service`

### Missing dependencies  
Install: `sudo dnf install wl-clipboard xclip spice-vdagent`

### SPICE issues
Restart: `sudo systemctl restart spice-vdagentd`
