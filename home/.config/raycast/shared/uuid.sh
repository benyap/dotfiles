#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Generate UUID
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon 🆔
# @raycast.packageName Developer Utilities

uuid=$(uuidgen)
echo "$uuid" | pbcopy
echo "UUID Generated: $uuid"
