#!/bin/sh

agent_plist=com.jibidus.batteryNotifier.plist
agents_folder=~/Library/LaunchAgents

sudo gem install terminal-notifier &&

[ -d $agents_folder ] || mkdir $agents_folder &&
cp src/$agent_plist $agents_folder &&

launchctl load $agents_folder/$agent_plist &&
echo Battery notifier successfully installed.