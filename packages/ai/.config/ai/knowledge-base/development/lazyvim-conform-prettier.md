---
id: lazyvim-conform-prettier
title: Fix project-local Prettier reported as unavailable in LazyVim
summary: Repair the executable bit on a project-local Prettier bin target so Conform can discover it without changing system-wide Neovim configuration.
topics: [lazyvim, neovim, conform, prettier, yarn]
updated: 2026-08-26
---

## Symptom

Conform reports:

```text
prettier unavailable: Command 'prettier' not found
```

even though the project has Prettier installed.

## Cause

Conform searches for an executable `node_modules/.bin/prettier`. In a Yarn workspace, the Prettier package may be present at the repository root but its bin target can lose its executable bit. For example:

```text
node_modules/prettier/bin/prettier.cjs  # mode 644 instead of executable
```

Conform then falls back to searching the global `PATH`, where `prettier` may not exist.

## Fix

From the project root, reinstall dependencies first:

```sh
yarn install
```

If the bin target is still not executable, repair it locally:

```sh
chmod +x node_modules/prettier/bin/prettier.cjs
```

Verify the project-local command:

```sh
test -x node_modules/.bin/prettier && node_modules/.bin/prettier --version
```

Restart Neovim after changing the executable bit. No system-wide Neovim configuration change is required; Conform's standard `prettier` formatter will discover the project-local executable.

## Related note

`~/.local/state/nvim/conform.log` is append-only. Old syntax errors in that log describe the buffer contents at the time of the failed formatting attempt and may not match the current file.
