#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open GitHub repository
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon ../images/github.png
# @raycast.packageName Quicklink
# @raycast.argument1 { "type": "text", "placeholder": "repository" }

open "https://github.com/$1"
