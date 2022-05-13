#!/bin/env/node

const { readdirSync, readFileSync, writeFileSync, mkdirSync } = require("fs");

function getRaycastExtensions() {
  const path = "home/.config/raycast/extensions";

  const extensionPaths = readdirSync(path).filter((path) => !path.includes("node_modules"));

  const extensions = extensionPaths.map((extensionPath) => {
    const buffer = readFileSync(`${path}/${extensionPath}/package.json`).toString();
    const { name, title, description, author } = JSON.parse(buffer.toString());
    return { name, title, description, author };
  });

  return extensions;
}

function main() {
  const dir = "assets/raycast";
  const path = `${dir}/extensions.json`;

  const extensions = getRaycastExtensions();
  mkdirSync(dir, { recursive: true });
  writeFileSync(path, JSON.stringify(extensions, null, 2));

  console.log("Wrote", extensions.length, "extensions to", path);
}

main();
