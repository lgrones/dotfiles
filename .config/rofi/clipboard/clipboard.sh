#!/usr/bin/env bash

dir="$HOME/.config/rofi/clipboard"
theme="$dir/clipboard.rasi"

cliphist list |
	head -n 32 |
	rofi -dmenu -no-show-icons -display-columns 2 -theme "$theme" |
	cliphist decode |
	wl-copy
