#!/usr/bin/env sh

# avoid the Device pixel ratio issue with alacritty
WINIT_HIDPI_FACTOR=1.0
start-pulseaudio-x11 &

# snap does not seem to get into the dmenu cache, does this help?
if [ -d /snap/bin ]; then
    export PATH=/snap/bin:$PATH
fi

setxkbmap -layout 'us(intl-unicode)'

dwm_status_bar &
exec start_dwm
