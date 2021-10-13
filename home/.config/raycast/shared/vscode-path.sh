#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open path in VS Code
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon ../images/vscode.png
# @raycast.packageName Visual Studio Code
# @raycast.argument1 { "type": "text", "placeholder": "path" }

code ~/"$1"
