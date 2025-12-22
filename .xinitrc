#!/usr/bin/env sh

# Avoid device pixel ratio issues with alacritty/winit apps
export WINIT_HIDPI_FACTOR=1.0

# Ensure a DBus session exists (important for PipeWire/WirePlumber, portals, etc.)
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
  eval "$(dbus-launch --exit-with-session)"
fi

# Only set XDG_RUNTIME_DIR if it's missing (usually systemd sets this)
[ -z "$XDG_RUNTIME_DIR" ] && export XDG_RUNTIME_DIR="/run/user/$(id -u)"

# Ensure /snap/bin is in PATH (if present)
[ -d /snap/bin ] && export PATH="/snap/bin:$PATH"

setxkbmap -layout 'us(intl-unicode)'
xset r rate 300 50

command -v xscreensaver >/dev/null 2>&1 && xscreensaver &

# Start dunst once
pgrep -x dunst >/dev/null 2>&1 || dunst &

dwm_status_bar &
exec start_dwm
