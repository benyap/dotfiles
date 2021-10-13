#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open path in Finder
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon ../images/finder.png
# @raycast.packageName Finder
# @raycast.argument1 { "type": "text", "placeholder": "path" }

open ~/"$1"
