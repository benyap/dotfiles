import { Clipboard, showHUD } from "@raycast/api";

export default async function Command() {
  const timestamp = Date.now().toString();

  await Clipboard.copy(timestamp);
  await showHUD(`Copied ${timestamp}`);
}
