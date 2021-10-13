#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Chrome profile
# @raycast.mode fullOutput
#
# Optional parameters:
# @raycast.icon ../images/chrome.png
# @raycast.packageName Chrome
# @raycast.argument1 { "type": "text", "placeholder": "profile", "optional": true }

on run argv
	set profileAlias to (item 1 of argv)
	set chromeProfile to "Default"

	# TODO: customise alias and profile names
	# Find your Chrome profile directory by going to chrome://version > Profile Path
	if profileAlias is equal to "alias1"
		set chromeProfile to "Profile 1"
	else if profileAlias is equal to "alias2"
		set chromeProfile to "Profile 2"
	end if

	do shell script "open -na 'Google Chrome' --args --profile-directory=" & chromeProfile's quoted form
end run
