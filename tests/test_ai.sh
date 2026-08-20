#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
AI="$ROOT/packages/ai/.local/bin/ai"
TEMP_ROOT="$(mktemp -d)"
cleanup() { rm -rf "$TEMP_ROOT"; }
trap cleanup EXIT

fail() { printf 'FAIL: %s\n' "$*" >&2; exit 1; }

command -v stow >/dev/null || fail "GNU Stow is required"
mkdir -p "$TEMP_ROOT/home"
HOME="$TEMP_ROOT/home" stow -d "$ROOT/packages" -t "$TEMP_ROOT/home" ai
[ -x "$TEMP_ROOT/home/.local/bin/ai" ] || fail "ai command was not stowed"

mkdir -p "$TEMP_ROOT/home/.codex" "$TEMP_ROOT/home/.claude" "$TEMP_ROOT/home/.homebrew"
printf 'keep me\n' > "$TEMP_ROOT/home/.codex/AGENTS.md"
cp "$ROOT/packages/brew/.homebrew/Brewfile" "$TEMP_ROOT/home/.homebrew/Brewfile"
mkdir "$TEMP_ROOT/bin"
printf '#!/usr/bin/env bash\ntouch "$AI_BREW_MARKER"\n' > "$TEMP_ROOT/bin/brew"
chmod +x "$TEMP_ROOT/bin/brew"
AI_HOOK_TEST=1 HOME="$TEMP_ROOT/home" TARGET_DIR="$TEMP_ROOT/home" DRY_RUN=0 AI_SKIP_EXTERNAL_INSTALL=1 AI_BREW_MARKER="$TEMP_ROOT/brew-called" PATH="$TEMP_ROOT/bin:$PATH" \
  bash -c 'log(){ :; }; warn(){ :; }; source "$0/hooks/ai.sh"; post_stow' "$ROOT"
[ "$(cat "$TEMP_ROOT/home/.codex/AGENTS.md")" = 'keep me' ] || fail "existing Codex instructions were overwritten"
[ -L "$TEMP_ROOT/home/.claude/CLAUDE.md" ] || fail "Claude instructions were not linked"
[ ! -e "$TEMP_ROOT/brew-called" ] || fail "AI hook invoked Homebrew"

mkdir "$TEMP_ROOT/repo"
git -C "$TEMP_ROOT/repo" init -q
git -C "$TEMP_ROOT/repo" config user.email test@example.com
git -C "$TEMP_ROOT/repo" config user.name Test
printf 'x\n' > "$TEMP_ROOT/repo/README.md"
git -C "$TEMP_ROOT/repo" add README.md && git -C "$TEMP_ROOT/repo" commit -qm init
( cd "$TEMP_ROOT/repo" && AI_CONFIG_DIR="$ROOT/packages/ai/.config/ai" AI_NO_LAUNCH=1 "$AI" start 'Test task' )
[ -f "$TEMP_ROOT/repo-test-task/.git" ] || fail "worktree was not created"
git -C "$TEMP_ROOT/repo" show-ref --verify --quiet refs/heads/agent/test-task || fail "branch was not created"

AI_CONFIG_DIR="$ROOT/packages/ai/.config/ai" AI_RESEARCH_DIR="$TEMP_ROOT/inbox" AI_NO_LAUNCH=1 "$AI" research 'Test research'
NOTE="$TEMP_ROOT/inbox/$(date +%F)-test-research.md"
[ -f "$NOTE" ] || fail "research note was not created"
rg -Fq '# Test research' "$NOTE" || fail "research note did not render topic"

printf '%s\n' '#!/usr/bin/env bash' 'printf "%s\n" "$@" > "$AI_CLAUDE_ARGS"' > "$TEMP_ROOT/bin/claude"
chmod +x "$TEMP_ROOT/bin/claude"
AI_CONFIG_DIR="$ROOT/packages/ai/.config/ai" AI_RESEARCH_DIR="$TEMP_ROOT/inbox" AI_AGENT=claude AI_CLAUDE_ARGS="$TEMP_ROOT/claude-args" PATH="$TEMP_ROOT/bin:$PATH" "$AI" research 'Adapter test'
rg -Fq 'Read(//**/.env)' "$TEMP_ROOT/claude-args" || fail "Claude adapter did not deny .env reads"
rg -Fq 'Read(//**/secrets/**)' "$TEMP_ROOT/claude-args" || fail "Claude adapter did not deny secrets reads"

PATH="$TEMP_ROOT/home/.local/bin:$PATH" zsh -dfc 'command -v ai' >/dev/null || fail "ai is not on PATH in a fresh zsh"
printf 'PASS: ai workflow tests\n'
