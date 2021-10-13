#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open localhost
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon 💻
# @raycast.packageName Quicklink
# @raycast.argument1 { "type": "text", "placeholder": "port" }

open "http://localhost:$1"
