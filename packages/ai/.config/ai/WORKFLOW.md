# Portable AI workflow

`ai` is a terminal-first workflow shared by Codex and Claude Code. It keeps agent configuration, authentication, caches, history, and desktop settings machine-local.

## Setup

Stow the package with `./install.sh ai zsh`. The hook links this package's shared instructions to `~/.codex/AGENTS.md` and `~/.claude/CLAUDE.md` only when those paths are absent or empty. Existing non-empty files are left untouched and reported.

The hook checks the existing `~/.homebrew/Brewfile` as the dependency authority; it does not install any Brew formula or cask. If `claude` is absent, it uses Claude Code's official native installer unless `AI_SKIP_EXTERNAL_INSTALL=1` is set. Complete Codex and Claude's interactive sign-ins locally after setup.

Use `~/.config/ai/local.env` for ignored machine-local overrides and 1Password references. Never put secret values in tracked files. It is sourced only by `ai`; use shell-style `NAME=value` or `export NAME=value` entries.

## Commands

```
ai status
ai agent [codex|claude]
ai env
ai start [--agent codex|claude] <task>
ai research [--agent codex|claude] <topic>
```

`ai start` must run inside a Git repository. It creates `agent/<slug>` and a sibling worktree at `../<repo>-<slug>`, then opens the selected agent with the task.

`ai research` creates `~/Documents/00 - INBOX/YYYY-MM-DD-<slug>.md` from the standard template, then opens the selected agent with that note's context. Set `AI_RESEARCH_DIR` in `local.env` for a different machine-local destination.

Selection is `--agent`, then `AI_AGENT`, then an available `codex` or `claude` command. `ai agent` reports the resolved choice; it does not persist a preference. `ai env` reports whether local overrides were loaded without exposing their values. Set `AI_NO_LAUNCH=1` only for automated checks.

Claude launched through `ai` receives deny rules for `.env` files, `secrets/**`, and common credential locations. Direct `claude` invocation does not receive that adapter.
