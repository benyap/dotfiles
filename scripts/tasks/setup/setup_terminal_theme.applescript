set wasTerminalRunning to false

# Check if terminal is running
if application "Terminal" is running then
	set wasTerminalRunning to true
end if

tell application "Terminal"

	local allOpenedWindows
	local initialOpenedWindows
	local windowID

  set themeName to "OneDark"

  # Capture currently open terminal windows
  set initialOpenedWindows to id of every window

	if (name of default settings is not equal to themeName) then
		# Open the theme to add it to terminal (will cause new window to open)
		# and set the new theme as default
		do shell script "open '../assets/" & themeName & ".terminal'"
		delay 1
		set default settings to settings set themeName
	end if

	# Only close new window if terminal was already running
	if wasTerminalRunning then
		set allOpenedWindows to id of every window
		repeat with windowID in allOpenedWindows
			# Close windows that were opened from installing theme
			if initialOpenedWindows does not contain windowID then
				close (every window whose id is windowID)

			# Set current windows to use new theme
			else
				set current settings of tabs of (every window whose id is windowID) to settings set themeName
			end if
		end repeat

	# If terminal wasn't running, quit the application
	else
		quit
	end if

end tell
