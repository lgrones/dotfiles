#!/bin/bash

STATE_FILE="/tmp/hypr_wallpaper_mode"
MAP_FILE="/tmp/hypr_wallpaper_map"
SPECIAL="wallpaper_view"

if [ -f "$STATE_FILE" ]; then
    # Restore each window to its original workspace
    while IFS=' ' read -r addr ws; do
        hyprctl dispatch movetoworkspacesilent "$ws,address:$addr"
    done < "$MAP_FILE"
    rm -f "$STATE_FILE" "$MAP_FILE"
else
    # Save address→workspace mapping for all non-special windows, then hide them
    hyprctl clients -j | jq -r '.[] | select(.workspace.id > 0) | .address + " " + (.workspace.id | tostring)' > "$MAP_FILE"
    while IFS=' ' read -r addr ws; do
        hyprctl dispatch movetoworkspacesilent "special:$SPECIAL,address:$addr"
    done < "$MAP_FILE"
    touch "$STATE_FILE"
fi
