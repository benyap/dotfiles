#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Restart Finder
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon 👨🏻‍💻
# @raycast.packageName System
#
# Documentation:
# @raycast.description Restart Finder
# @raycast.author Jordi Clement
# @raycast.authorURL https://github.com/jordicl

killall Finder
echo "Restarted Finder"
