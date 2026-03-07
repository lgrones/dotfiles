#!/usr/bin/env bash

dir="$HOME/.config/rofi"

shutdown=''
reboot=''
lock=''
logout=''

choice="$(echo -e "$shutdown\n$reboot\n$lock\n$logout" | rofi -dmenu -theme "${dir}/powermenu.rasi")"

case ${choice} in
"$shutdown") systemctl poweroff ;;
"$reboot") systemctl reboot ;;
"$lock") hyprlock ;;
"$logout") hyprctl dispatch exit ;;
esac
