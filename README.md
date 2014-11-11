# Description
TODO

# Requirements
- MacOSX 10.10 (Yosmite)

# Installation
TODO

# TODO
- Complete this README.md
- Manage translation
- Add (unit) tests in bash?
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
		