#!/usr/local/opt/node@14/bin/node

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title lsof port list
// @raycast.mode fullOutput
//
// Optional parameters:
// @raycast.icon ⚓
// @raycast.packageName Developer Utilities
// @raycast.argument1 { "type": "text", "placeholder": "port" }

const [port] = process.argv.slice(2);

require("child_process").exec(`lsof -PF pcLfn -i :${port}`, (_, stdout) => {
  const rows = [];
  let row = null;

  for (const item of stdout.split("\n")) {
    const type = item[0];
    const value = item.slice(1);

    switch (type) {
      case "p":
        if (row) rows.push(row);
        row = { pid: value };
        break;
      case "c":
        row.name = value;
        break;
      case "L":
        row.login = value;
        break;
      case "n":
        row.address = value;
        break;
    }
  }

  if (row) rows.push(row);

  console.log(rows);
});
