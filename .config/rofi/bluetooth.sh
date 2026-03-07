#!/usr/bin/env bash

dir="$HOME/.config/rofi"

declare -A mac_map
labels=()

while read -r _ mac name; do
	info=$(bluetoothctl info "$mac")

	connected=$(echo "$info" | grep "Connected:" | awk '{print $2}')
	battery=$(echo "$info" | grep "Battery Percentage:" | grep -o '([0-9]*)' | tr -d '()')

	[ "$connected" = "yes" ] && status="" || status=""

	if [ -n "$battery" ]; then
		icons=("󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹")
		index=$((battery / 10))
		label="$status  $name ${icons[$index]} $battery%"
	else
		label="$status  $name"
	fi

	mac_map["$label"]="$mac"
	labels+=("$label")
done < <(bluetoothctl devices Paired)

add="  Scan for devices"
labels+=("$add")
choice=$(printf '%s\n' "${labels[@]}" | rofi -dmenu -no-show-icons -p "" -theme "${dir}/bluetooth.rasi")

if [ -z "$choice" ]; then
	exit 0
fi

if [ "$choice" = "$add" ]; then
	if ! command -v expect &>/dev/null; then
		notify-send "Bluetooth" "Install 'expect' to enable device pairing"
		exit 0
	fi

	# Start scan in background
	bt_scan_out=$(mktemp)
	bt_cmd=$(mktemp)
	rm "$bt_cmd"
	mkfifo "$bt_cmd"

	bluetoothctl <"$bt_cmd" >"$bt_scan_out" &
	scan_pid=$!

	# Keep fifo open by holding a fd to it
	exec 3>"$bt_cmd"

	# Start scanning
	echo "scan on" >&3

	# Show notice
	rofi -dmenu -no-show-icons -theme "${dir}/bluetooth.rasi" -theme-str '#textbox { content: "Scanning for 10 seconds..."; }' &
	notice_pid=$!

	# Wait for notice to close, or for 10 seconds
	timer=100
	while [ "$timer" -gt 0 ] && kill -0 $notice_pid 2>/dev/null; do
		sleep 0.2
		timer=$((timer - 2))
	done

	kill $notice_pid 2>/dev/null

	# Stop scan gracefully via the fifo
	echo "scan off" >&3
	sleep 0.1
	echo "devices" >&3
	echo "quit" >&3
	exec 3>&-
	wait $scan_pid
	rm "$bt_cmd"

	# Build labels from whatever was scanned so far
	labels=()
	paired_macs=$(bluetoothctl devices Paired | awk '{print $2}')

	while read -r _ mac name; do
		if ! echo "$paired_macs" | grep -q "$mac"; then
			labels+=("$mac $name")
		fi
	done < <(grep "^Device" "$bt_scan_out")
	rm "$bt_scan_out"

	mac=$(printf '%s\n' "${labels[@]}" |
		grep -v '^$' |
		rofi -dmenu -no-show-icons -theme "${dir}/bluetooth.rasi" -theme-str '#textbox { content: "Available Devices"; }' |
		awk '{print $1}')

	if [ -z "$mac" ]; then
		"${dir}/bluetooth.sh"
		exit 0
	fi

	expect <<EOF
spawn bluetoothctl
expect "Agent registered"
send "agent NoInputNoOutput\r"
expect {
    "Agent is already registered" {
        # already set, just continue
    }
    "Agent registered" {
        send "default-agent\r"
        expect "Default agent request successful"
    }
}
send "pair $mac\r"
expect "Pairing successful"
send "trust $mac\r"
expect "trust succeeded"
send "connect $mac\r"
expect "Connection successful"
send "quit\r"
EOF

	exit 0
fi

mac="${mac_map[$choice]}"

connect='󰂯  Connect'
disconnect='󰂲  Disconnect'
alias='󰗧  Set Alias (Device has to be turned on)'
remove='  Remove'

action=$(echo -e "$connect\n$disconnect\n$alias\n$remove" |
	rofi -dmenu -no-show-icons -theme "${dir}/bluetooth.rasi" -theme-str "#textbox { content: \"$choice\"; }")

if [ -z "$action" ]; then
	"${dir}/bluetooth.sh"
	exit 0
fi

if [ "$action" = "$alias" ]; then
	if ! command -v expect &>/dev/null; then
		notify-send "Bluetooth" "Install 'expect' to enable setting aliases"
		exit 0
	fi

	alias=$(rofi -dmenu -no-show-icons -theme "${dir}/bluetooth.rasi" \
		-theme-str "#textbox { content: \"$choice\"; }" \
		-theme-str "#inputbar { enabled: true;}" \
		-theme-str "#listview { lines: 7;}")

	if [ -z "$alias" ]; then
		"${dir}/bluetooth.sh"
		exit 0
	fi

	expect <<EOF
spawn bluetoothctl
expect "Agent registered"
send "agent NoInputNoOutput\r"
expect {
    "Agent is already registered" {
        # already set, just continue
    }
    "Agent registered" {
        send "default-agent\r"
        expect "Default agent request successful"
    }
}
send "connect $mac\r"
expect "Connection successful"
send "set-alias \"$alias\"\r"
expect "Changing $alias succeeded"
send "quit\r"
EOF

	exit 0
fi

case $action in
"$connect") bluetoothctl connect "$mac" ;;
"$disconnect") bluetoothctl disconnect "$mac" ;;
"$remove") bluetoothctl remove "$mac" ;;
esac
