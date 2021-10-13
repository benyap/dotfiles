#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Largest CPU Process
# @raycast.mode inline
# @raycast.refreshTime 3m
#
# Optional parameters:
# @raycast.icon 📈
# @raycast.packageName System
#
# Documentation:
# @raycast.description Report process with largest system CPU usage.
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf

output=$(ps -exco pcpu,comm | sort -k 1 -n -r | head -n 1)
percentage=$(echo -e "$output" | awk -F " " '{ st = index($0," ");print $1}')

# Using awk like in largest-ram-consumer doesn't work, so do this instead.
cmd=${output/$percentage/}

# Remove leading whitespace...?
cmd=$(echo "$cmd" | awk '{$1=$1};1')

echo "${cmd} - ${percentage}%"
