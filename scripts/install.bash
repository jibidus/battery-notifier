#!/bin/sh
set -u -e

agent_id=com.jibidus.battery.notifier
plist_filename=com.jibidus.batteryNotifier.plist
script_filename=battery-notifier.bash

agents_folder=$HOME/Library/LaunchAgents
scripts_folder=$HOME/Library/Scripts/battery-notifier


if [ ! $(launchctl list | grep -cF $agent_id) -eq 0 ]; then
	echo "Agent already running. Stopping agent..."
	launchctl unload $agents_folder/$plist_filename
fi

echo "Installing required dependencies (might take a while)..." 
[ $(gem list | grep -c terminal-notifier) -eq 0 ] && sudo gem install terminal-notifier 

echo "Installing script..."
[ -d $scripts_folder/logs ] || mkdir -p $scripts_folder/logs
cp src/$script_filename $scripts_folder/$script_filename

echo "Installing agent..."
[ -d $agents_folder ] || mkdir -p $agents_folder
cp src/$plist_filename $agents_folder/$plist_filename

echo "Configuring agent..." 
sed -i "" -e "s#\${script_folder}#$scripts_folder#g" $agents_folder/$plist_filename 

echo "Starting agent..." 
launchctl load $agents_folder/$plist_filename 

echo "Battery-notifier successfully installed."
