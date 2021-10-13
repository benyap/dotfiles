#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Custom environment link
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon 🔗
# @raycast.packageName Quicklink
# @raycast.argument1 { "type": "text", "placeholder": "environment" }


# Helper for creating quicklinks to a website (e.g. for work)
# where there are multiple environments you frequently access

environment=$1

if [ "$environment" = "dev" ]; then
    environment="development."
elif [ "$environment" = "test" ]; then
    environment="test."
elif [ "$environment" = "prod" ]; then
    environment=""
fi

open "https://${environment}website.com"
