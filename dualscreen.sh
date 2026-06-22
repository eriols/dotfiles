#!/bin/sh
set -u
# Toggle the external monitor layout. Detects X11 vs Wayland at runtime and
# uses xrandr or wlr-randr accordingly. The Wayland path works on
# wlroots-based compositors (dwl, river, sway, Hyprland, wayfire, ...).
#
# "l" turn off ext monitor and use laptop only
# "e" for external monitor only
# or "d" for dual external monitor/laptop (external above laptop).

LAPTOP=eDP-1

# --- Backend detection ------------------------------------------------------
# A Wayland compositor sets WAYLAND_DISPLAY; an X server sets DISPLAY. Prefer
# WAYLAND_DISPLAY since XDG_SESSION_TYPE is often "tty" when the compositor is
# launched by hand from a console.
detect_backend() {
    if [ -n "${WAYLAND_DISPLAY:-}" ]; then
        echo wayland
    elif [ -n "${DISPLAY:-}" ]; then
        echo x11
    else
        echo "Could not detect X11 or Wayland session." >&2
        exit 1
    fi
}

# --- External monitor detection ---------------------------------------------
detect_ext_monitor() {
    case $BACKEND in
        x11)     xrandr    | grep -oP '\K^DP-[\d-]+(?= connected)' | head -n1 ;;
        wayland) wlr-randr | grep -oP '^DP-[\d-]+(?= ")'           | head -n1 ;;
    esac
}

# Print "WIDTHxHEIGHT" of the preferred mode for the given output (Wayland only).
preferred_mode() {
    wlr-randr | awk -v out="$1" '
        $1 == out      { in_block = 1; next }
        /^[^[:space:]]/ { in_block = 0 }
        in_block && /preferred/ { print $1; exit }
    '
}

# --- Layouts ----------------------------------------------------------------
# External monitor stacked above the laptop. wlr-randr has no relative
# positioning, so place the external at the top (0,0) and the laptop directly
# below it, offset by the external's pixel height.
dual() {
    case $BACKEND in
        x11)
            xrandr --output "$ext_monitor" --auto --above "$LAPTOP"
            ;;
        wayland)
            h=$(preferred_mode "$ext_monitor" | cut -d x -f2)
            : "${h:=0}"
            wlr-randr \
                --output "$ext_monitor" --on --preferred --pos 0,0 \
                --output "$LAPTOP" --on --preferred --pos "0,${h}"
            ;;
    esac
}

laptop() {
    case $BACKEND in
        x11)
            xrandr --output "$LAPTOP" --auto --output "$ext_monitor" --off
            ;;
        wayland)
            wlr-randr \
                --output "$LAPTOP" --on --preferred --pos 0,0 \
                --output "$ext_monitor" --off
            ;;
    esac
}

ext() {
    case $BACKEND in
        x11)
            xrandr --output "$ext_monitor" --auto --output "$LAPTOP" --off
            ;;
        wayland)
            wlr-randr \
                --output "$ext_monitor" --on --preferred --pos 0,0 \
                --output "$LAPTOP" --off
            ;;
    esac
}

# After a layout change, redraw the per-monitor yambar bars. Only relevant
# under river (dwl's somebar handles all outputs itself; dwm is X11). The guard
# makes this a no-op everywhere else, so it is safe to call unconditionally.
refresh_bars() {
    if command -v riverctl >/dev/null 2>&1 && pgrep -x river >/dev/null 2>&1; then
        "$HOME/code/dotfiles/river/start-bars"
    fi
}

param() {
    case $1 in
        d) dual ;;
        e) ext ;;
        l) laptop ;;
        *) echo -e "Invalid parameter. Add one of the following:\n\"d\" for dual screen laptop and external.\n\"l\" for laptop only\n\"e\" for external only."
           return ;;
    esac
    refresh_bars
}

main() {
    BACKEND=$(detect_backend) || exit 1

    if [ "$BACKEND" = wayland ] && ! command -v wlr-randr >/dev/null 2>&1; then
        echo "wlr-randr not found. Install it (requires a wlroots compositor)." >&2
        exit 1
    fi

    ext_monitor=$(detect_ext_monitor)
    if test -n "${ext_monitor:-}"
    then
        param "$1"
    else
        echo "No external monitor input detected."
    fi
}

main "${1:-}"
