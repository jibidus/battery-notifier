#!/bin/bash

echo ""
echo "$(date) --- New execution of battery-notifier"

# return 0 to enable verbose mode
is_verbose() {
	return 0
}

get_battery_property() {
	ioreg -w0 -l | grep $1 | cut -d'=' -f 2 | tr -d ' '
}


send_notification() {
	#terminal-notifier -message "$1" -title "Battery Notifier" -sound default
	echo "Send notification !"
}

# Configuration ---------------------------
# FIXME Rename these variables & files
FLAG_battery_under_high_threshold=/tmp/battery_under_high_threshold.flag
HIGH_THRESHOLD=100
$(is_verbose) && echo "High threshold defined: $HIGH_THRESHOLD"

FLAG_battery_upper_low_threshold=/tmp/battery_upper_low_threshold.flag
LOW_THRESHOLD=5
$(is_verbose) && echo "Low threshold defined: $LOW_THRESHOLD"


# Program ---------------------------------
max_capacity=$(get_battery_property "MaxCapacity")
$(is_verbose) && echo "Max capacity : $max_capacity"
current_capacity=$(get_battery_property "CurrentCapacity")
$(is_verbose) && echo "Current capacity : $current_capacity"
current_charge=$(expr 100 \* $current_capacity / $max_capacity)
$(is_verbose) && echo "Current charge: $current_charge"

if [ $(get_battery_property "ExternalChargeCapable") == "No" ]; then
	rm -f $FLAG_battery_under_high_threshold
	# On battery => check low threshold
	if [ -f $FLAG_battery_upper_low_threshold ]; then
		# Previously upper than low threshold
		if [ "$current_charge" -le "$LOW_THRESHOLD" ]; then
			# Now lower than threshold
			send_notification "Batterie is up to $LOW_THRESHOLD%"
			rm $FLAG_battery_upper_low_threshold  && $(is_verbose) && echo "Flag upper_low_threshold removed"
		fi
	else
		if [ "$current_charge" -gt "$LOW_THRESHOLD" ]; then
			touch $FLAG_battery_upper_low_threshold && $(is_verbose) && echo "Flag upper_low_threshold created"
		fi
	fi
else
	rm -f $FLAG_battery_upper_low_threshold
	# On sector => check high threshold
	if [ -f $FLAG_battery_under_high_threshold ]; then
		# Previously lower than high threshold
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

