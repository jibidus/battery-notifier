#!/bin/bash


is_debug() {
	return 1
}


$(is_debug) && echo "is debug"

get_battery_property() {
	ioreg -w0 -l | grep $1 | cut -d'=' -f 2 | tr -d ' '
}

result=$(get_battery_property "ExternalChargeCapable")
echo get_battery_property: $result

get_current_charge() {
	max_charge=$(get_battery_property "MaxCapacity")
	current_charge=$(get_battery_property "CurrentCapacity")
	expr 100 \* $current_charge / $max_charge
}


result=$(get_current_charge)
echo "get_current_charge (%): $result"

#terminal-notifier -message "Batterie is up to x%" -title "Battery Notifier" -sound default
echo "---------------"

if [ $(get_battery_property "ExternalChargeCapable") == "No" ]; then
	echo "not on charges"
	# TODO To implement
else
	echo "on charge..."
	threshold=85
	if [ "$(get_current_charge)" -lt "$threshold" ]; then
		echo "<= $threshold"
			# TODO Send notification
	else
		echo "> $threshold"
	fi
fi