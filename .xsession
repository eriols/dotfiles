#!/bin/sh

/usr/bin/xset b off
/usr/bin/xsetroot -solid darkslategrey
# If feh was installed, this can be uncommented.
#/usr/bin/feh --bg-center 'IMAGE PATH HERE'
# If xautolocal was installed, this can be uncommented.
#/usr/bin/xautolock -locker /usr/local/bin/slock -detectsleep -secure -time 10 &
#
# xrandr stuff here too possibly, xinput ger?
setxkbmap -layout 'us(intl-unicode)'
dwm_status_bar &
dunst &
# /usr/local/bin/slstatus &
exec start_dwm
