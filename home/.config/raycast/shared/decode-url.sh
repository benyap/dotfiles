#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Decode URL
# @raycast.mode compact
#
# Optional parameters:
# @raycast.icon 💻
# @raycast.packageName Developer Utilities
# @raycast.argument1 { "type": "text", "placeholder": "url" }

function urldecode() {
    local url_encoded="${1//+/ }"
    printf '%b' "${url_encoded//%/\\x}"
}

urldecode "$(echo -n "$1")"
