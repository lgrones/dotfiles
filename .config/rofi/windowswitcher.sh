#!/usr/bin/env bash

# Current Theme
dir="$HOME/.config/rofi"
theme='windowswitcher-style'

mapfile -t addresses < <(
  hyprctl clients -j | jq -r '.[] | select(.mapped) | .address'
)

hyprctl clients -j | jq -r '
.[] | select(.mapped) |
"\(.initialTitle) - \(.title)\u0000icon\u001f\(.class)"
' | rofi -dmenu -i -show-icons -format i -theme "${dir}/${theme}.rasi" |
{
  read -r idx || exit
  hyprctl dispatch focuswindow address:${addresses[$idx]}
}