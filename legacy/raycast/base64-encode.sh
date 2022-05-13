#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Base64 Encode
# @raycast.mode compact
#
# Optional parameters:
# @raycast.packageName Developer Utilities
# @raycast.icon 🔒
# @raycast.argument1 { "type": "text", "placeholder": "text" }

result=$(echo "$1" | base64)
echo "$result" | pbcopy
echo "$result"
