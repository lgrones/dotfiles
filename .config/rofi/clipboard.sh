#!/usr/bin/env bash

dir="$HOME/.config/rofi"

cliphist list | rofi -dmenu -display-columns 2 -no-show-icons -theme "${dir}/clipboard.rasi" | cliphist decode | wl-copy
