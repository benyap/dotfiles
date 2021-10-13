#!/usr/local/opt/node@14/bin/node

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title JWT Decode
// @raycast.mode fullOutput
//
// Optional parameters:
// @raycast.icon ../images/jwt.png
// @raycast.packageName Developer Utilities
// @raycast.argument1 { "type": "text", "placeholder": "token" }

const parseJwt = (token) => {
  const [header, payload] = token.split(".");
  const decodedHeader = Buffer.from(header, "base64");
  const decodedPayload = Buffer.from(payload, "base64");
  return [
    JSON.parse(decodedHeader.toString()),
    JSON.parse(decodedPayload.toString()),
  ];
};

const [token] = process.argv.slice(2);
const [header, payload] = parseJwt(token);

console.log(JSON.stringify(header, null, 2));
console.log(JSON.stringify(payload, null, 2));
