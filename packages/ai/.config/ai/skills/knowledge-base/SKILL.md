---
name: knowledge-base
description: Search and maintain the user's portable, topic-organized knowledge base under ~/.brain/topics. Use when a prior fix, workaround, setup note, or personal technical convention may be relevant.
---

# Personal Knowledge Base

The canonical knowledge base is at `~/.brain/topics/`. Search it before solving a problem that may have a previously documented fix or personal convention.

## Search

Search filenames and entry content first, then read only the matching entries:

```sh
rg --files ~/.brain/topics
rg -n -i 'keyword|phrase' ~/.brain/topics
```

Frontmatter uses compact YAML fields:

```yaml
id: unique-slug
title: Short descriptive title
summary: One-sentence discovery summary
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
