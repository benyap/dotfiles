---
name: knowledge-base
description: Search, organize, and maintain the user's portable personal knowledge base in the Brain Obsidian vault. Use when durable personal knowledge, past decisions, prior work, preferences, or documented fixes may help, or when the user asks to capture, update, or organize notes.
---

# Personal Knowledge Base

The knowledge base stores durable, reusable personal knowledge that should remain available across tools and future tasks. Search it when previous experience, decisions, preferences, or reference material may help.

## Vault location

Use the absolute path in `BRAIN_VAULT` when it is set and non-empty. Otherwise, use `~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Brain/`. Apply the resolved vault path to searches, edits, and organization. If the selected directory is missing, ask for the vault path before proceeding.

Read `AGENTS.md` at the root of the selected vault when present. Use its folder roles, templates, and collection conventions to guide searches and edits. If the file is absent, infer conventions from the vault's existing folders and nearby notes.

## Search

Start in the likely project or collection. Search filenames, properties, and note text, then read only the relevant matches. Broaden the search across the vault when the likely area does not yield enough evidence. Exclude `.obsidian/` and `.trash/`.

For a vault-wide text search:

```sh
brain_vault="${BRAIN_VAULT:-$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/Brain}"
rg -n -i -g '*.md' -g '!**/.obsidian/**' -g '!**/.trash/**' -- 'keyword|phrase' "$brain_vault"
```

## Capture and update notes

Find the note that already holds the relevant information and update it in place. Create a note when it has a distinct purpose. Follow the vault's placement guidance, apply a relevant template when available, and follow nearby notes for filenames and properties. Link related notes when a link helps readers find context. Keep credentials, tokens, and secrets out of notes.

## Editing policy

Read the knowledge base by default. Create or modify notes only when the user explicitly requests it. Preserve the vault's existing structure and conventions.

Before requesting write permission, resolve the intended knowledge-base path to its real filesystem location. If any path component is a symbolic link, follow it and request write permission for the resolved directory rather than the symbolic-link path.

Treat the vault's `.obsidian/` directory as Obsidian application data, not knowledge-base content. Do not search, read, create, modify, or delete files in that directory.

## Organize notes

When asked to organize notes, use the named folder, project, or collection as the scope. If the scope is unclear, infer it from the request or ask which area to organize. Inventory the full vault only for an explicitly vault-wide request. Inspect paths and properties first, then read note bodies where placement remains ambiguous. For proposed moves or renames, list each source and destination with a brief reason and obtain approval for any changes the user has yet to authorize.

After the user approves a proposal, apply it without requesting another confirmation. Resolve the affected vault paths to their real filesystem locations and check that every destination is free before making changes. Perform only the approved moves and renames. Update affected relative Markdown links, path-based links, and Obsidian wikilinks throughout the knowledge base, preserving link labels and leaving references unchanged when they still resolve. Apart from necessary reference repairs, preserve note content, titles, frontmatter, and stable `id` values. Do not split, merge, rewrite, or normalize notes unless separately requested.

Verify that destinations exist, old paths no longer exist, updated links resolve, and no references to old paths remain. Report destination conflicts or ambiguous categorization instead of guessing.
