---
name: manage-agent-skills
description: Manage globally shared agent skills through this dotfiles package, including importing, updating, auditing, and organizing third-party or self-authored skills. Do not use for project-local skills unless requested.
---

# Manage Agent Skills

Manage canonical skills from `packages/ai/.config/ai/skills/`, which GNU Stow exposes at `~/.config/ai/skills/`. Keep agent-specific adapters separate from the canonical skill source.

## Source of Truth

- Keep approved skill directories and their complete contents in `packages/ai/.config/ai/skills/` and commit them to Git.
- Treat `packages/ai/.config/ai/skills.toml` as the provenance record for third-party skills. For each imported skill, record its name, source URL or repository, reviewed commit SHA, and source subpath.
- Do not add a provenance entry for a self-authored skill.

## Third-Party Skills

- Use `npx skills` in a temporary directory to discover or import candidates. Do not install it directly into an agent-managed skills directory.
- Review every imported `SKILL.md`, script, and resource before copying the approved skill directory into the package.
- When updating an existing skill, import the candidate separately, compare it with the tracked version, and commit the reviewed change with updated provenance.

## Agent-Specific Configuration

Add an adapter for each agent that should discover a shared skill. Adapters must point to the canonical directory rather than duplicate its contents.

### Codex

- Add or update `packages/ai/.codex/skills/<skill-name>` as a relative symlink to `packages/ai/.config/ai/skills/<skill-name>`.
- Stow exposes that adapter at `~/.codex/skills/<skill-name>`.
- Do not install candidates directly into `~/.codex/skills/`.
- Validate changed canonical skills with `$CODEX_HOME/skills/.system/skill-creator/scripts/quick_validate.py`; when `CODEX_HOME` is unset, use `~/.codex/skills/.system/skill-creator/scripts/quick_validate.py`.

## Verification

- Run `./install.sh -n ai` to verify the Stow changes before installing them.
