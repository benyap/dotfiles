#!/usr/bin/env bash
#
# install.sh — idempotent dotfiles bootstrap using GNU Stow
#
# Two ways to run this file:
#
#   1. BOOTSTRAP (first time, no repo on disk yet):
#        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/benyap/dotfiles/main/install.sh)"
#      Checks required tools (Xcode CLI tools + Homebrew on macOS, git,
#      stow), clones the repo to ~/.dotfiles, then hands off to the
#      cloned copy of this same script.
#
#   2. NORMAL (already inside a cloned dotfiles repo):
#        cd ~/.dotfiles && ./install.sh
#      Package-agnostic: discovers stow packages under packages/,
#      links/unlinks them, and runs any per-package hooks.
#      See hooks/README.md.
#
# Usage (normal mode):
#   ./install.sh                    # stow all discovered packages
#   ./install.sh codex zsh          # stow only specific packages
#   ./install.sh -D                 # unstow all discovered packages
#   ./install.sh -D codex           # unstow specific packages
#   DRY_RUN=1 ./install.sh          # preview changes without linking/unlinking
#
# Flags:
#   -D, --unstow   unlink instead of link
#   -n, --dry-run  same as DRY_RUN=1

set -euo pipefail

log()  { printf '\033[1;34m[info]\033[0m %s\n' "$1"; }
warn() { printf '\033[1;33m[warn]\033[0m %s\n' "$1"; }
err()  { printf '\033[1;31m[err ]\033[0m %s\n' "$1" >&2; }

# ---------------------------------------------------------------------------
# Config
# ---------------------------------------------------------------------------
DOTFILES_REPO="${DOTFILES_REPO:-https://github.com/benyap/dotfiles.git}"
DOTFILES_INSTALL_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

DRY_RUN="${DRY_RUN:-0}"
MODE="stow"   # stow | unstow

# ---------------------------------------------------------------------------
# Detect bootstrap vs normal mode.
#
# When piped via `bash -c "$(curl ...)"`, this script has no backing file
# on disk — BASH_SOURCE[0] is just the literal string "bash" and doesn't
# resolve to a real path. That's the bootstrap case: clone the repo, then
# exec the real on-disk copy so everything downstream (hooks/, packages/)
# is actually present.
# ---------------------------------------------------------------------------
if [ -n "${BASH_SOURCE[0]:-}" ] && [ -f "${BASH_SOURCE[0]}" ]; then
  DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  IS_BOOTSTRAP=0
else
  DOTFILES_DIR=""
  IS_BOOTSTRAP=1
fi

# ---------------------------------------------------------------------------
# Preflight: required tools. Safe to call repeatedly — every check is a
# no-op if the tool is already present.
# ---------------------------------------------------------------------------
ensure_xcode_cli_tools() {
  [ "$(uname -s)" = "Darwin" ] || return 0
  if xcode-select -p >/dev/null 2>&1; then
    return 0
  fi
  log "Xcode Command Line Tools not found — triggering installation"
  xcode-select --install >/dev/null 2>&1 || true
  warn "A system popup should appear — complete the install, then this will continue automatically"
  until xcode-select -p >/dev/null 2>&1; do
    sleep 5
  done
  log "Xcode Command Line Tools installed"
}

ensure_homebrew() {
  [ "$(uname -s)" = "Darwin" ] || return 0
  if command -v brew >/dev/null 2>&1; then
    return 0
  fi
  log "Homebrew not found — installing"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [ -d /opt/homebrew/bin ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -d /usr/local/bin ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
}

ensure_git() {
  if command -v git >/dev/null 2>&1; then
    return 0
  fi
  log "git not found — attempting install"
  if command -v brew >/dev/null 2>&1; then
    brew install git
  elif command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update && sudo apt-get install -y git
  elif command -v pacman >/dev/null 2>&1; then
    sudo pacman -S --noconfirm git
  else
    err "Could not install git automatically. Install it manually and re-run."
    exit 1
  fi
}

ensure_stow() {
  if command -v stow >/dev/null 2>&1; then
    return 0
  fi
  log "GNU Stow not found — attempting to install"
  if command -v brew >/dev/null 2>&1; then
    brew install stow
  elif command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update && sudo apt-get install -y stow
  elif command -v pacman >/dev/null 2>&1; then
    sudo pacman -S --noconfirm stow
  else
    err "Could not find a supported package manager. Install GNU Stow manually and re-run."
    exit 1
  fi
}

preflight() {
  ensure_xcode_cli_tools   # macOS only, no-op elsewhere
  ensure_homebrew          # macOS only, no-op elsewhere
  ensure_git
  ensure_stow
}

# ---------------------------------------------------------------------------
# Bootstrap: clone the repo (if not already present) and hand off to the
# real on-disk install.sh.
# ---------------------------------------------------------------------------
bootstrap() {
  preflight

  if [ -d "$DOTFILES_INSTALL_DIR/.git" ]; then
    log "Dotfiles already present at $DOTFILES_INSTALL_DIR"
  elif [ -e "$DOTFILES_INSTALL_DIR" ]; then
    err "$DOTFILES_INSTALL_DIR exists but isn't a git repo. Move or remove it, then re-run."
    exit 1
  else
    log "Cloning $DOTFILES_REPO to $DOTFILES_INSTALL_DIR"
    git clone "$DOTFILES_REPO" "$DOTFILES_INSTALL_DIR"
  fi

  log "Handing off to $DOTFILES_INSTALL_DIR/install.sh"
  exec "$DOTFILES_INSTALL_DIR/install.sh" "$@"
}

if [ "$IS_BOOTSTRAP" = "1" ]; then
  bootstrap "$@"
  # exec above never returns
fi

# ---------------------------------------------------------------------------
# Normal mode from here on — DOTFILES_DIR is a real path on disk.
# ---------------------------------------------------------------------------
PACKAGES_DIR="$DOTFILES_DIR/packages"
BACKUP_DIR="$DOTFILES_DIR/.backup/$(date +%Y%m%d-%H%M%S)"

# ---------------------------------------------------------------------------
# 0. Parse args: flags can appear anywhere, remaining args are package names
# ---------------------------------------------------------------------------
ARGS=()
for arg in "$@"; do
  case "$arg" in
    -D|--unstow) MODE="unstow" ;;
    -n|--dry-run) DRY_RUN=1 ;;
    -h|--help)
      grep '^#' "${BASH_SOURCE[0]}" | sed 's/^#//'
      exit 0
      ;;
    *) ARGS+=("$arg") ;;
  esac
done

# ---------------------------------------------------------------------------
# Discover packages dynamically: every directory under packages/ is a
# package. Nothing needs to be ignored — anything that isn't meant to be
# stowed simply doesn't belong under packages/. Override by passing
# package names as args.
# ---------------------------------------------------------------------------
discover_packages() {
  local pkg
  [ -d "$PACKAGES_DIR" ] || return 0
  for pkg in "$PACKAGES_DIR"/*/; do
    [ -d "$pkg" ] || continue
    basename "$pkg"
  done
}

if [ "${#ARGS[@]}" -gt 0 ]; then
  PACKAGES=("${ARGS[@]}")
else
  PACKAGES=()
  while IFS= read -r line; do
    [ -n "$line" ] && PACKAGES+=("$line")
  done < <(discover_packages)
fi

if [ "${#PACKAGES[@]}" -eq 0 ]; then
  err "No packages found in $PACKAGES_DIR (and none passed as args)."
  exit 1
fi

# Tracks every top-level target path actually stowed, for dynamic verification
declare -a STOWED_TARGETS=()

# ---------------------------------------------------------------------------
# 1. Back up any real (non-symlink) files that would collide with a package
#
# Stow "folds" directories: if a whole subdirectory comes from one package,
# stow symlinks the parent directory itself rather than each file inside
# it. So a nested file's own path is never a symlink — only an ancestor
# directory is. Walking leaf files directly and checking `[ -L file ]`
# misses this and treats already-linked nested files as fresh conflicts on
# every run, breaking idempotency. This walk mirrors stow's folding logic:
# it only descends into a target directory (and only backs something up)
# when a *real* directory or file is actually in the way; once it hits an
# existing symlink, that subtree is already stow's to manage and is left
# alone entirely.
# ---------------------------------------------------------------------------
resolve_conflict() {
  local pkg_entry="$1" rel="$2"
  local target="$HOME/$rel"

  if [ -L "$target" ]; then
    if [ ! -e "$target" ]; then
      log "Removing stale symlink: $target"
      rm "$target"
    fi
    return 0
  fi

  if [ ! -e "$target" ]; then
    return 0
  fi

  if [ -d "$pkg_entry" ] && [ -d "$target" ]; then
    local child
    for child in "$pkg_entry"/* "$pkg_entry"/.[!.]*; do
      [ -e "$child" ] || continue
      resolve_conflict "$child" "$rel/$(basename "$child")"
    done
    return 0
  fi

  log "Backing up existing real file: $target"
  mkdir -p "$BACKUP_DIR/$(dirname "$rel")"
  mv "$target" "$BACKUP_DIR/$rel"
}

backup_conflicts() {
  local pkg="$1"
  local pkg_path="$PACKAGES_DIR/$pkg"
  [ -d "$pkg_path" ] || { warn "Package '$pkg' not found, skipping"; return; }

  local entry
  for entry in "$pkg_path"/* "$pkg_path"/.[!.]*; do
    [ -e "$entry" ] || continue
    resolve_conflict "$entry" "$(basename "$entry")"
  done
}

# ---------------------------------------------------------------------------
# 2. Stow / unstow a single package
# ---------------------------------------------------------------------------
stow_package() {
  local pkg="$1"
  local pkg_path="$PACKAGES_DIR/$pkg"
  [ -d "$pkg_path" ] || { warn "Package '$pkg' not found, skipping"; return; }

  local stow_args=(-v -t "$HOME" -d "$PACKAGES_DIR")
  [ "$DRY_RUN" = "1" ] && stow_args+=(-n)

  log "Stowing package: $pkg"
  stow "${stow_args[@]}" "$pkg"

  local entry
  for entry in "$pkg_path"/* "$pkg_path"/.[!.]*; do
    [ -e "$entry" ] || continue
    STOWED_TARGETS+=("$(basename "$entry")")
  done
}

unstow_package() {
  local pkg="$1"
  local pkg_path="$PACKAGES_DIR/$pkg"
  [ -d "$pkg_path" ] || { warn "Package '$pkg' not found, skipping"; return; }

  local stow_args=(-v -D -t "$HOME" -d "$PACKAGES_DIR")
  [ "$DRY_RUN" = "1" ] && stow_args+=(-n)

  log "Unstowing package: $pkg"
  stow "${stow_args[@]}" "$pkg"
}

# ---------------------------------------------------------------------------
# 3. Plugin-style hooks: each package may define hooks/<pkg>.sh with any of
#    pre_stow / post_stow / pre_unstow / post_unstow. install.sh has no
#    idea what any package does — it only calls whichever functions exist.
#
#    Hooks run in a subshell so function defs / vars never leak between
#    packages, and get log/warn/err plus PKG_PATH/TARGET_DIR/DRY_RUN in scope.
# ---------------------------------------------------------------------------
run_hook() {
  local pkg="$1" stage="$2"
  local hook_file="$DOTFILES_DIR/hooks/$pkg.sh"
  [ -f "$hook_file" ] || return 0

  (
    local PKG_PATH="$PACKAGES_DIR/$pkg"
    local TARGET_DIR="$HOME"
    # shellcheck source=/dev/null
    source "$hook_file"
    if declare -f "$stage" >/dev/null 2>&1; then
      "$stage"
    fi
  )
}

# ---------------------------------------------------------------------------
# main
# ---------------------------------------------------------------------------
main() {
  log "Dotfiles dir: $DOTFILES_DIR"
  log "Packages dir: $PACKAGES_DIR"
  log "Target dir:   $HOME"
  log "Mode:         $MODE"
  [ "$DRY_RUN" = "1" ] && warn "DRY_RUN=1 — no changes will be made"

  preflight

  if [ "$MODE" = "stow" ]; then
    for pkg in "${PACKAGES[@]}"; do
      backup_conflicts "$pkg"
      run_hook "$pkg" pre_stow
      stow_package "$pkg"
      run_hook "$pkg" post_stow
    done

    if [ -d "$BACKUP_DIR" ]; then
      log "Backed-up originals saved to: $BACKUP_DIR"
    fi

    if [ "$DRY_RUN" = "1" ]; then
      log "Dry run complete. Re-run without DRY_RUN=1 to apply."
    elif [ "${#STOWED_TARGETS[@]}" -gt 0 ]; then
      local unique_targets=()
      while IFS= read -r line; do
        [ -n "$line" ] && unique_targets+=("$line")
      done < <(printf '%s\n' "${STOWED_TARGETS[@]}" | sort -u)
      local verify_paths=()
      for t in "${unique_targets[@]}"; do
        verify_paths+=("$HOME/$t")
      done
      log "Done. Verify with: ls -la ${verify_paths[*]}"
    else
      log "Done. No new links were created."
    fi

  else
    for pkg in "${PACKAGES[@]}"; do
      run_hook "$pkg" pre_unstow
      unstow_package "$pkg"
      run_hook "$pkg" post_unstow
    done
    log "Done. Packages unstowed: ${PACKAGES[*]}"
  fi
}

main
