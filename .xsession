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

/usr/bin/xset b off
/usr/bin/xsetroot -solid darkslategrey

setxkbmap -layout 'us(intl-unicode)'
xset r rate 250 50

command -v xscreensaver >/dev/null 2>&1 && xscreensaver &

# After xscreensaver unlocks, nudge dwm into re-delivering keyboard
# focus by warping the pointer into the focused window.
# Retry with increasing delays to handle resume-from-suspend.
# Wait for xscreensaver to be ready before connecting the watcher.
(sleep 2 && xscreensaver-command -watch) | while read -r event _rest; do
  if [ "$event" = "UNBLANK" ]; then
    for delay in 0.3 1 2; do
      sleep "$delay"
      wid=$(xdotool getactivewindow 2>/dev/null) && \
        xdotool mousemove --window "$wid" 50 50 2>/dev/null && break
    done
  fi
done &

# Start dunst once
pgrep -x dunst >/dev/null 2>&1 || dunst &

dwm_status_bar &
exec start_dwm
