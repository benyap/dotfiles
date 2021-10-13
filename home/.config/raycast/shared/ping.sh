#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Ping
# @raycast.mode fullOutput
#
# Optional parameters:
# @raycast.icon 🌐
# @raycast.packageName Developer Utilities
# @raycast.argument1 { "type": "text", "placeholder": "URL or IP address" }
#
# Documentation:
# @raycast.description Ping an IP address or URL.
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf

ping -i 0.25 -t 3 "$1"
