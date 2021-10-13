#!/usr/bin/osascript

# Install Amphetamine via Mac App Store: https://apps.apple.com/us/app/amphetamine/id937984704

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Start Amphetamine session
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon ../images/amphetamine.png
# @raycast.packageName Amphetamine
#
# Documentation:
# @raycast.description Start Amphetamine Session
# @raycast.author James Lyons
# @raycast.authorURL https://github.com/jamesjlyons

tell application "Amphetamine" to start new session

log "Started Amphetamine session"
