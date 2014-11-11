#!/bin/sh

agent_plist=com.jibidus.batteryNotifier.plist

launchctl unload ~/Library/LaunchAgents/$agent_plist &&
rm ~/Library/LaunchAgents/$agent_plist &&
sudo gem uninstall terminal-notifier &&
echo Battery notifier successfully uninslled.
