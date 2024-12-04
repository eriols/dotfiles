#!/bin/sh
set -u
# "l" turn off ext monitor and use laptop only
# "e" for external monitor only
# or "d" for dual external monitor/laptop.

main() {
    ext_monitor=$(xrandr | grep -oP '\K^DP-[\d-]+(?= connected)')
    if test -n "${ext_monitor:-}"
    then
        param $1
	else echo "No external monitor input detected."
	fi
}

dual() {
    xrandr --output $ext_monitor --auto --above eDP-1
}

laptop() {
    xrandr --output eDP-1 --auto --output $ext_monitor --off
}

ext() {
    xrandr --output $ext_monitor --auto --output eDP-1 --off
}

param() {
    case $1 in
        d) dual ;;
        e) ext ;;
        l) laptop ;;
        *) echo -e "Invalid parameter. Add one of the following:\n\"d\" for dual screen laptop and DP-1.\n\"l\" for laptop only\n\"e\" for DP-1 only." ;;
    esac
}
main $1
