#!/bin/bash

# return 0 to enable verbose mode
is_verbose() {
	return 0
}

get_battery_property() {
	ioreg -w0 -l | grep $1 | cut -d'=' -f 2 | tr -d ' '
}


send_notification() {
	terminal-notifier -message "$1" -title "Battery Notifier" -sound default
}

# Configuration ---------------------------
# FIXME Rename these variables & files
FLAG_battery_under_high_threshold=/tmp/battery_under_high_threshold.flag
HIGH_THRESHOLD=86
$(is_verbose) && echo "High threshold defined: $HIGH_THRESHOLD"

FLAG_battery_upper_low_threshold=/tmp/charge_upper_low_threshold.flag
LOW_THRESHOLD=20
$(is_verbose) && echo "Low threshold defined: $LOW_THRESHOLD"


# Program ---------------------------------
max_capacity=$(get_battery_property "MaxCapacity")
$(is_verbose) && echo "Max capacity : $max_capacity"
current_capacity=$(get_battery_property "CurrentCapacity")
$(is_verbose) && echo "Current capacity : $current_capacity"
current_charge=$(expr 100 \* $current_capacity / $max_capacity)
$(is_verbose) && echo "Current charge: $current_charge"

if [ $(get_battery_property "ExternalChargeCapable") == "No" ]; then
	# On battery
	# TODO To implement
	echo ""
else
	# On sector => check high threshold
	if [ -f $FLAG_battery_under_high_threshold ]; then
		# Previously lower than threshold
		if [ "$current_charge" -ge "$HIGH_THRESHOLD" ]; then
			# Now greater than threshold
			send_notification "Batterie is up to $HIGH_THRESHOLD%"
			rm $FLAG_battery_under_high_threshold  && $(is_verbose) && echo "Flag under_high_threshold removed"
		fi
	else
		if [ "$current_charge" -lt "$HIGH_THRESHOLD" ]; then
			touch $FLAG_battery_under_high_threshold && $(is_verbose) && echo "Flag under_high_threshold created"
		fi
	fi
fi

