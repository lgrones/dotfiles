#!/usr/bin/env bash

dir="$HOME/.config/rofi/powermenu"
theme="$dir/powermenu.rasi"

shutdown=''
reboot=''
lock=''
logout=''

choice=$(echo -e "$shutdown\n$reboot\n$lock\n$logout" | rofi -dmenu -theme "$theme")

case ${choice} in
"$shutdown") systemctl poweroff ;;
"$reboot") systemctl reboot ;;
"$lock") hyprlock ;;
"$logout") hyprctl dispatch exit ;;
esac
