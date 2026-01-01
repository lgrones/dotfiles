#!/usr/bin/env bash

# Current Theme
dir="$HOME/.config/rofi"
theme='powermenu-style'

# Options
shutdown=''
reboot=''
lock=''
logout=''

# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-theme ${dir}/${theme}.rasi
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$shutdown\n$reboot\n$lock\n$logout" | rofi_cmd
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    "$shutdown")
		  systemctl poweroff
        ;;
    "$reboot")
		  systemctl reboot
        ;;
    "$lock")
		  hyprlock
        ;;
    "$logout")
		  yprctl dispatch exit
        ;;
esac
