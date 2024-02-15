#!/usr/bin/env sh

# avoid the Device pixel ratio issue with alacritty
WINIT_HIDPI_FACTOR=1.0
# start-pulseaudio-x11 &

# snap does not seem to get into the dmenu cache, does this help?
if [ -d /snap/bin ]; then
    export PATH=/snap/bin:$PATH
fi

setxkbmap -layout 'us(intl-unicode)'
if [ -z "$SSH_AGENT" ] && [ -z "$SSH_AUTH_SOCK" ] && [ -z "$SSH_AGENT_PID" ] && [ -x /bin/ssh-agent ]; then
    if [ "x$TMPDIR" != "x" ]; then
	    SSH_AGENT="/bin/ssh-agent /bin/env TMPDIR=$TMPDIR"
    else
	    SSH_AGENT="/bin/ssh-agent"
    fi
fi

[ -x $(which xscreensaver) ] && xscreensaver &
dwm_status_bar &
exec start_dwm
