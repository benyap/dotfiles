#!/usr/local/opt/node@14/bin/node

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Calculate GEH
// @raycast.mode compact
//
// Optional parameters:
// @raycast.icon 🚙
// @raycast.packageName Formulas
// @raycast.argument1 {"type": "text", "placeholder": "Predicted"}
// @raycast.argument2 {"type": "text", "placeholder": "Actual"}

const [predicted, actual] = process.argv.slice(2);

const m = Number(predicted);
const c = Number(actual);

if (isNaN(m) || m < 0) {
  console.log(`Invalid "predicted" value ${predicted}`);
  process.exit(1);
}

if (isNaN(c) || c < 0) {
  console.log(`Invalid "actual" value ${actual}`);
  process.exit(1);
}

if (m === 0 && c === 0) {
  console.log(`"predicted" and "actual" value are both zero`);
  process.exit(1);
}

const geh = Math.sqrt((2 * Math.pow(m - c, 2)) / (m + c));
console.log(geh.toFixed(3));
