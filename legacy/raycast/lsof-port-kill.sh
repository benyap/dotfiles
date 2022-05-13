#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title lsof port kill
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon 🔪
# @raycast.packageName Developer Utilities
# @raycast.argument1 { "type": "text", "placeholder": "port" }

lsof -ti :"$1" | xargs kill
echo Killed processes on port "$1"
