---
name: raycast-local-extensions
description: Create and maintain private Raycast extensions in the user's local custom-extensions workspace. Use when authoring, editing, testing, building, linting, or locally installing a Raycast extension, not when publishing to the Raycast Store.
---

# Local Raycast Extensions

The local Raycast workspace is a private, machine-local pnpm workspace at:

```text
~/.config/raycast/custom-extensions
```

Before creating or changing an extension, read its `README.md`. The README is the authoritative source for the workspace layout, package metadata, dependency management, development commands, build and lint commands, and local Raycast installation workflow. Follow its existing examples, especially `packages/timestamp`.

Keep credentials, tokens, and runtime/session data out of the workspace. These extensions are intended for direct local installation and are not automatically intended for publication to the Raycast Store.
