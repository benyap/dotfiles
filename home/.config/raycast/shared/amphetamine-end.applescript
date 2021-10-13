#!/usr/bin/osascript

# Install Amphetamine via Mac App Store: https://apps.apple.com/us/app/amphetamine/id937984704

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title End Amphetamine session
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon ../images/amphetamine.png
# @raycast.packageName Amphetamine
#
# Documentation:
# @raycast.description End Amphetamine Session
# @raycast.author James Lyons
# @raycast.authorURL https://github.com/jamesjlyons

tell application "Amphetamine" to end session

log "Ended Amphetamine session"
