#!/bin/sh
set -u
# Wayland port of dualscreen.sh, using wlr-randr.
# Works on wlroots-based compositors (dwl, river, sway, Hyprland, wayfire, ...).
#
# "l" turn off ext monitor and use laptop only
# "e" for external monitor only
# or "d" for dual external monitor/laptop (external above laptop).

LAPTOP=eDP-1

main() {
    if ! command -v wlr-randr >/dev/null 2>&1; then
        echo "wlr-randr not found. Install it (requires a wlroots compositor)." >&2
        exit 1
    fi

    ext_monitor=$(wlr-randr | grep -oP '^DP-[\d-]+(?= ")' | head -n1)
    if test -n "${ext_monitor:-}"
    then
        param "$1"
    else
        echo "No external monitor input detected."
    fi
}

# Print "WIDTHxHEIGHT" of the preferred mode for the given output.
preferred_mode() {
    wlr-randr | awk -v out="$1" '
        $1 == out      { in_block = 1; next }
        /^[^[:space:]]/ { in_block = 0 }
        in_block && /preferred/ { print $1; exit }
    '
}

# External monitor stacked above the laptop. wlr-randr has no relative
# positioning, so place the external at the top (0,0) and the laptop
# directly below it, offset by the external's pixel height.
dual() {
    h=$(preferred_mode "$ext_monitor" | cut -d x -f2)
    : "${h:=0}"
    wlr-randr \
        --output "$ext_monitor" --on --preferred --pos 0,0 \
        --output "$LAPTOP" --on --preferred --pos "0,${h}"
}

laptop() {
    wlr-randr \
        --output "$LAPTOP" --on --preferred --pos 0,0 \
        --output "$ext_monitor" --off
}

ext() {
    wlr-randr \
        --output "$ext_monitor" --on --preferred --pos 0,0 \
        --output "$LAPTOP" --off
}

param() {
    case $1 in
        d) dual ;;
        e) ext ;;
        l) laptop ;;
        *) echo -e "Invalid parameter. Add one of the following:\n\"d\" for dual screen laptop and external.\n\"l\" for laptop only\n\"e\" for external only." ;;
    esac
}
main "${1:-}"
