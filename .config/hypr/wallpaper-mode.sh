#!/bin/bash

STATE_FILE="/tmp/hypr_wallpaper_mode"
MAP_FILE="/tmp/hypr_wallpaper_map"
SPECIAL="wallpaper_view"

# Under the lua config manager `hyprctl dispatch` is a shorthand for
# hl.dispatch(...), so dispatchers must be written in lua syntax.
move_silent() {
    local ws="$1" addr="$2"
    hyprctl dispatch "hl.dsp.window.move({ workspace = \"$ws\", window = \"address:$addr\", follow = false })"
}

if [ -f "$STATE_FILE" ]; then
    # Restore each window to its original workspace
    while IFS=' ' read -r addr ws; do
        move_silent "$ws" "$addr"
    done < "$MAP_FILE"
    rm -f "$STATE_FILE" "$MAP_FILE"
else
    # Save address→workspace mapping for all non-special windows, then hide them
    hyprctl clients -j | jq -r '.[] | select(.workspace.id > 0) | .address + " " + (.workspace.id | tostring)' > "$MAP_FILE"
    while IFS=' ' read -r addr ws; do
        move_silent "special:$SPECIAL" "$addr"
    done < "$MAP_FILE"
    touch "$STATE_FILE"
fi
