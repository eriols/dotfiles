#! /usr/bin/env bash

dow=$(date +%u)
hhmm=$(date +%H%M)
if (($dow < 6 && $hhmm > 1529 && $hhmm < 2200)); then
    ./~/code/dotfiles/tmux/spot_price
else
    echo "NYSE closed"
fi
