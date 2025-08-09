# Technical Details

## Architecture

spice-vdagent was designed for X11 and cannot access Wayland clipboard directly.

Solution: Bridge process that copies from Wayland to X11 clipboard.

## Implementation

### Display Detection
1. Check existing DISPLAY environment variable
2. Look for /tmp/.X11-unix/X0 socket
3. Scan all X server sockets
4. Default to :0

### Clipboard Sync
- Poll Wayland clipboard every second
- Compare with previous content to avoid redundant syncing  
- Forward changes to X11 clipboard
- Log activity for debugging

### Error Handling
- Service restarts on failures
- X11 connection validation
- Graceful handling of clipboard access errors

## Performance

- Memory usage: 2-6MB
- CPU impact: minimal, brief spikes during sync operations
- Polling interval: 1 second (balances responsiveness vs resource usage)

## Security

- Runs as user process
- Has access to clipboard content (like other clipboard managers)
- No network or filesystem access beyond clipboard operations
