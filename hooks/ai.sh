# Shell functions loaded by install.sh for the ai Stow package.

ai_link_instruction() {
  local target="$1" source="$TARGET_DIR/.config/ai/INSTRUCTIONS.md"
  if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
    log "AI instructions already linked: $target"
    return
  fi
  if [ -e "$target" ] && [ -s "$target" ]; then
    warn "Preserving existing non-empty agent instructions: $target"
    return
  fi
  if [ "$DRY_RUN" = "1" ]; then
    log "Would link AI instructions: $target -> $source"
    return
  fi
  mkdir -p "$(dirname "$target")"
  rm -f "$target"
  ln -s "$source" "$target"
  log "Linked AI instructions: $target"
}

ai_verify_brewfile() {
  local brewfile="$TARGET_DIR/.homebrew/Brewfile" entry
  for entry in 'brew "ripgrep"' 'brew "jq"' 'brew "fzf"' 'brew "tmux"' 'cask "1password-cli"' 'cask "codex"'; do
    if [ ! -f "$brewfile" ] || ! grep -Fqx "$entry" "$brewfile"; then
      warn "AI dependency authority is missing expected Brewfile declaration: $entry"
    fi
  done
}

post_stow() {
  ai_link_instruction "$TARGET_DIR/.codex/AGENTS.md"
  ai_link_instruction "$TARGET_DIR/.claude/CLAUDE.md"
  ai_verify_brewfile

  if command -v claude >/dev/null 2>&1; then
    log "Claude Code is available"
  elif [ "$DRY_RUN" = "1" ] || [ "${AI_SKIP_EXTERNAL_INSTALL:-0}" = "1" ]; then
    warn "Claude Code is absent; native installation skipped"
  else
    log "Claude Code is absent — installing with its official native installer"
    curl -fsSL https://claude.ai/install.sh | bash
  fi
  log "Complete Codex and Claude's interactive sign-ins locally before first use"
}
