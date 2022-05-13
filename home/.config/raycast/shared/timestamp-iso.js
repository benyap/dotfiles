#!/usr/local/opt/node@16/bin/node

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Timestamp as ISO string
// @raycast.mode inline
// @raycast.refreshTime 1s
//
// Optional parameters:
// @raycast.icon ⏱
// @raycast.packageName Developer Utilities

console.log(new Date().toISOString());
