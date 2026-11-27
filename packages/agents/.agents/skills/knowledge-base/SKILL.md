---
name: knowledge-base
description: Search, organize, and maintain the user's portable personal knowledge base under ~/.brain/topics. Use when durable personal knowledge, past decisions, prior work, preferences, or documented fixes may help, or when the user asks to capture, update, or organize notes.
---

# Personal Knowledge Base

The knowledge base stores durable, reusable personal knowledge that should remain available across tools and future tasks. The canonical location is `~/.brain/topics/`. Search it when previous experience, decisions, preferences, or reference material may help.

## Search

Search filenames and entry content first, then read only the matching entries:

```sh
rg --files -g '!**/.obsidian/**' ~/.brain/topics
rg -n -i -g '!**/.obsidian/**' 'keyword|phrase' ~/.brain/topics
```

Frontmatter uses compact YAML fields:

```yaml
id: unique-slug
title: Short descriptive title
summary: One sentence describing what the note contains and when it is useful
topics: [topic, tool]
updated: YYYY-MM-DD
```

Use filenames, `title`, `summary`, and `topics` to identify relevant entries. Do not load the entire knowledge base when a focused search is sufficient.

## Add entries

Create one Markdown file per fix or piece of knowledge under a relevant topic directory, for example:

```text
~/.brain/topics/development/tool-problem.md
```

Keep frontmatter compact and make the `summary` useful for search. Put commands, cause, fix, verification, and important caveats in the body. Do not add secrets, credentials, tokens, or runtime data.

## Editing policy

Read the knowledge base by default. Create or modify notes only when the user explicitly requests it. Preserve the vault's existing structure and conventions.

Before requesting write permission, resolve the intended knowledge-base path to its real filesystem location. If any path component is a symbolic link, follow it and request write permission for the resolved directory rather than the symbolic-link path. Continue to use `~/.brain/topics/` as the user-facing canonical path in notes and explanations.

Treat `~/.brain/.obsidian/` as Obsidian application data, not knowledge-base content. Do not search, read, create, modify, or delete files in that directory.

## Organize notes

When asked to organize notes, propose an arrangement before changing files. If the user does not specify a narrower scope, inventory all Markdown notes under `~/.brain/topics/`, excluding `.obsidian`. Inspect paths and compact frontmatter first, and read note bodies only when placement remains ambiguous. List every proposed move or rename as a source and destination with a brief reason, then ask the user to approve the proposal.

As a suggested pattern, prefer broad, stable top-level topics and shallow nesting. Add sub-topic directories when several related notes form a useful group, but keep a note directly under its broader topic when another directory would not improve findability. Follow the vault's existing structure and filename conventions where practical. Rename only unclear filenames, using descriptive kebab-case names.

After the user approves a proposal, apply it without requesting another confirmation. Resolve the topics path to its real filesystem location and check that every destination is free before making changes. Perform only the approved moves and renames. Update affected relative Markdown links, path-based links, and Obsidian wikilinks throughout the knowledge base, preserving link labels and leaving references unchanged when they still resolve. Apart from necessary reference repairs, preserve note content, titles, frontmatter, and stable `id` values. Do not split, merge, rewrite, or normalize notes unless separately requested.

Verify that destinations exist, old paths no longer exist, updated links resolve, and no references to old paths remain. Report destination conflicts or ambiguous categorization instead of guessing.
