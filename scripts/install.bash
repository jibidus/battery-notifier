#!/bin/sh

plist_filename=com.jibidus.batteryNotifier.plist
script_filename=battery-notifier.bash

agents_folder=$HOME/Library/LaunchAgents
scripts_folder=$HOME/Library/Scripts/battery-notifier

echo "Installing dependencies (might take a while)..." &&
sudo gem install terminal-notifier &&

echo "Installing script..." &&
[ -d $scripts_folder/logs ] || mkdir -p $scripts_folder/logs &&
cp src/$script_filename $scripts_folder/$script_filename &&

echo "Installing agent..." &&
[ -d $agents_folder ] || mkdir -p $agents_folder &&
cp src/$plist_filename $agents_folder/$plist_filename &&

echo "Configuring agent..." &&
sed -i "" -e "s#\${script_folder}#$scripts_folder#g" $agents_folder/$plist_filename &&

echo "Starting agent..." &&
launchctl load $agents_folder/$plist_filename &&

echo "Battery-notifier successfully installed."
