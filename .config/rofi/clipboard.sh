#!/usr/bin/env bash

# Current Theme
dir="$HOME/.config/rofi"
theme='clipboard-style'

cliphist list | rofi -dmenu -display-columns 2 -theme "${dir}/${theme}.rasi" | cliphist decode | wl-copy