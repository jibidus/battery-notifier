#!/bin/sh

plist_filename=com.jibidus.batteryNotifier.plist
script_filename=battery-notifier.bash

agents_folder=~/Library/LaunchAgents
scripts_folder=~/Library/Scripts/battery-notifier

launchctl unload $agents_folder/$plist_filename &&
rm -Rf $scripts_folder &&
rm $agents_folder/$plist_filename &&
sudo gem uninstall terminal-notifier -x &&

echo "Battery-notifier successfully uninslled."
