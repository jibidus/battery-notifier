#!/bin/sh

agent_plist=com.jibidus.batteryNotifier.plist

sudo gem install terminal-notifier &&
cp src/$agent_plist ~/Library/LaunchAgents &&
launchctl load ~/Library/LaunchAgents/$agent_plist &&
echo Battery notifier successfully installed.