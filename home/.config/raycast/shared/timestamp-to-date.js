#!/usr/local/opt/node@14/bin/node

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Timestamp to date
// @raycast.mode fullOutput
//
// Optional parameters:
// @raycast.icon 🗓️
// @raycast.packageName Developer Utilities
// @raycast.argument1 { "type": "text", "placeholder": "timestamp" }
// @raycast.argument2 { "type": "text", "placeholder": "tz", "optional": true }

const [timestamp, timeZone] = process.argv.slice(2);

const asNumber = Number(timestamp);

try {
  const date = new Date(isNaN(asNumber) ? timestamp : asNumber);
  const dateString = date.toLocaleString("en-US", {
    timeZone: timeZone || "Australia/Melbourne",
    dateStyle: "full",
    timeStyle: "long",
  });
  console.log(dateString);
} catch (error) {
  console.log(error.message);
  process.exit(1);
}
