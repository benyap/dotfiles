#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Encode URL
# @raycast.mode compact
#
# Optional parameters:
# @raycast.icon 💻
# @raycast.packageName Developer Utilities
# @raycast.argument1 { "type": "text", "placeholder": "url" }

echo -n "$1" | (curl -Gso /dev/null -w "%{url_effective}" --data-urlencode @- "" | cut -c 3- || true)
