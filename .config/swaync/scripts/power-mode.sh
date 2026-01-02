#!/bin/bash

if powerprofilesctl get | grep -q "balanced"; 
then
    notify-send "Setting power-saver mode..." powerprofilesctl -i battery-profile-powersave -a powerprofilesctl
    powerprofilesctl set power-saver
else
    notify-send "Setting balanced power mode..." powerprofilesctl -i battery-profile-balanced -a powerprofilesctl
    powerprofilesctl set balanced
fi

