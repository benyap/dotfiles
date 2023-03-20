#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Connect to VPN
# @raycast.mode fullOutput

/opt/cisco/anyconnect/bin/vpn -s connect "<vpn-address>" <<CREDENTIALS
$(op item get "<name>" --fields username)
$(op item get "<name>" --fields password)
3
$(op item get "<name>" --otp)
y
CREDENTIALS
