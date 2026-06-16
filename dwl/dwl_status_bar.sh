#!/bin/sh
# Wayland port of dwm_status_bar.sh. dwm fed the bar with `xsetroot -name`;
# somebar is fed race-free with `somebar -c status "TEXT"` (the -c form is
# safe to call before somebar's control socket exists -- it just no-ops).

SEP="|"

battery() {
    cap=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null) || return
    stat=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null)
    case "$stat" in
        Charging) printf "🔌 %s%% %s" "$cap" "$stat" ;;
        *)        printf "🔋 %s%% %s" "$cap" "$stat" ;;
    esac
}

volume() {
    # PipeWire via wpctl, replacing amixer/Master (X11/ALSA) on Wayland.
    v=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null) || { printf "n/a"; return; }
    case "$v" in
        *MUTED*) printf "muted" ;;
        *)       echo "$v" | awk '{ printf "%d%%", $2 * 100 }' ;;
    esac
}

while :; do
    dt="$(date +'%Y-%m-%d %H:%M')"
    network=$(nmcli networking connectivity 2>/dev/null)
    somebar -c status "$(battery) $SEP volume: $(volume) $SEP nw: $network $SEP $dt"
    sleep 1
done
