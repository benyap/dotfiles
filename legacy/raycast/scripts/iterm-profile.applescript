#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open iTerm profile
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon images/iterm2.png
# @raycast.packageName iTerm
# @raycast.argument1 { "type": "text", "placeholder": "profile", "optional": true }

on run argv

  set defaultProfile to "default"

  set profileName to (item 1 of argv)
  if profileName is "" then
    set profileName to defaultProfile
  end if

  set createdProfile to false

  tell application "iTerm"
    # IMPORTANT: window restoration policy should NOT restore previous sessions
    # otherwise you will run into issues when starting iTerm when it is unopened
    activate

    repeat with currentWindow in windows
      tell current session of currentWindow
        # If we found a session with the correct profile, create a new tab in this window
        if profile name is equal to profileName then
          tell currentWindow
            set windowId to (create tab with profile profileName)
            return "Created new iTerm tab for " & profileName
          end tell
        end if
      end tell
    end repeat

    # If we didn't find a window to create the profile in, create new window
    if not createdProfile then
      set windowId to (create window with profile profileName)
      return "Created new iTerm window for " & profileName
    end if

  end tell

end run
