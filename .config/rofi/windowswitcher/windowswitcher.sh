#!/usr/bin/env bash

dir="$HOME/.config/rofi/windowswitcher"
theme="$dir/windowswitcher.rasi"

mapfile -t addresses < <(
	hyprctl clients -j | jq -r '.[] | select(.mapped) | .address'
)

hyprctl clients -j | jq -r '
.[] | select(.mapped) |
"\(.initialTitle) - \(.title)\u0000icon\u001f\(.class)"
' | rofi -dmenu -i -format i -theme "$theme" |
	{
		read -r idx || exit
		hyprctl dispatch focuswindow address:${addresses[$idx]}
	}
