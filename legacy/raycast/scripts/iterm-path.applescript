#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open iTerm at path
# @raycast.mode fullOutput
#
# Optional parameters:
# @raycast.icon images/iterm2.png
# @raycast.packageName iTerm
# @raycast.argument1 { "type": "text", "placeholder": "path", "optional": true }

on run argv

  set defaultPath to "~"

  set openPath to (item 1 of argv)

  if openPath is "" then
    set openPath to defaultPath
  end if

  tell application "iTerm"
    activate
    set newWindow to (create window with profile "default")
    tell current session of newWindow
      write text ("cd ~/" & openPath)
    end tell
  end tell

end run
