#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Base64 Decode
# @raycast.mode compact
#
# Optional parameters:
# @raycast.packageName Developer Utilities
# @raycast.icon 🔐
# @raycast.argument1 { "type": "text", "placeholder": "text" }

result=$(echo "$1" | base64 --decode)
echo "$result" | pbcopy
echo "$result"
