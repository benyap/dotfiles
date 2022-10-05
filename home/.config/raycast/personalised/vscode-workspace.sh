#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Code workspace
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon ../images/vscode.png
# @raycast.packageName Visual Studio Code
# @raycast.argument1 { "type": "text", "placeholder": "workspace" }
#
# Documentation:
# @raycast.description Open VS Code workspace

code ~/Code/.workspaces/"$1".code-workspace
