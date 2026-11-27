# AGENTS.md

This repository manages portable, non-secret dotfiles with GNU Stow; each directory in `packages/` mirrors `$HOME`, and `install.sh` discovers and links those packages.

- Edit configuration in `packages/<package>/...`.
- Keep credentials, tokens, and runtime/session data untracked.
- Before changing install or package behavior, verify with `./install.sh -n`.
- When the user says “root AGENTS.md,” they mean `packages/ai/.agents/AGENTS.md`, which provides shared guidance for agents configured to load it. This file is the Dotfiles repository’s own `AGENTS.md`.
