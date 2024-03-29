#!/bin/sh

export IDENTIFIER="unicode"
export SEP="|"

dwm_battery () {
    # Change BAT1 to whatever your battery is identified as. Typically BAT0 or BAT1
    CHARGE=$(cat /sys/class/power_supply/BAT0/capacity)
    STATUS=$(cat /sys/class/power_supply/BAT0/status)

    if [ "$IDENTIFIER" = "unicode" ]; then
        if [ "$STATUS" = "Charging" ]; then
            printf "🔌 %s%% %s" "$CHARGE" "$STATUS"
        else
            printf "🔋 %s%% %s" "$CHARGE" "$STATUS"
        fi
    else
        printf "BAT %s%% %s" "$CHARGE" "$STATUS"
    fi
    printf "%s\n" "$SEP"
}

while true; do
    dt="$(date +'%Y-%m-%d %H:%M')"
    vol=$(amixer sget Master | grep -oP '\K\d+%' | sed 1q)
    network=$(nmcli networking connectivity)
    xsetroot -name "$(dwm_battery) volume: $vol nw: $network $dt"
    sleep 1s
done
