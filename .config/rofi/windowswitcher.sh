#!/usr/bin/env bash

# Current Theme
dir="$HOME/.config/rofi"

mapfile -t addresses < <(
	hyprctl clients -j | jq -r '.[] | select(.mapped) | .address'
)

hyprctl clients -j | jq -r '
.[] | select(.mapped) |
"\(.initialTitle) - \(.title)\u0000icon\u001f\(.class)"
' | rofi -dmenu -i -format i -theme "${dir}/windowswitcher.rasi" |
	{
		read -r idx || exit
		hyprctl dispatch focuswindow address:${addresses[$idx]}
	}
