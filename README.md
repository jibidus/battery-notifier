# Description
Battery-notifier can send notifications when battery capacity of your MacBook is lower than 5% or reaches 100%.
Notifications are sent to Notification Center with playing a sound.
This tool runs as a service scheduled every minutes.

# Requirements
- MacOSX 10.10 (Yosmite)

# Installation
- Execute following commands in terminal (you may need to enter your password):
```bash
curl -Lk https://github.com/jibidus/battery-notifier/archive/1.0.2.zip -o battery-notifier-1.0.2.zip &&
unzip battery-notifier-1.0.2.zip &&
cd battery-notifier-1.0.2 &&
. scripts/install.bash
```

# Uninstallation
- Execute following commands in terminal:
```bash
curl -Lk https://github.com/jibidus/battery-notifier/archive/1.0.2.zip -o battery-notifier-1.0.2.zip &&
unzip battery-notifier-1.0.2.zip &&
cd battery-notifier-1.0.2 &&
. scripts/uninstall.bash
```

# TODO
- Uninstallation: terminal-notifier can be used by another program!! Do not uninstall it like that.
- Add (unit) tests in bash?
- Create script to buidl new release (update README, commit, create tag and push)
- Create script for update
- Rendre les seuil paramétrables
- Optimize performances
- Complete this README.md
- Manage translation
- Simplify installer (with real application)
- Create admin window in General Settings
- Make threshold parametreables
- Publish application in AppStore?

# External documentation
- [Create Mac daemon](https://developer.apple.com/library/mac/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/CreatingLaunchdJobs.html)
- [launchd.plist](https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man5/launchd.plist.5.html#//apple_ref/doc/man/5/launchd.plist)
- Play sound command: afplay
- [send notification to Notification center](http://osxdaily.com/2012/08/03/send-an-alert-to-notification-center-from-the-command-line-in-os-x/)
- [Terminal notifier](https://github.com/alloy/terminal-notifier)
- How to get battery info?
	ioreg -w0 -l
	With:
		ExternalChargeCapable = Yes|No
		MaxCapacity
		CurrentCapacity
		