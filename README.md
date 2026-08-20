# benyap's dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/), bootstrapped with a package-agnostic `install.sh` and an optional per-package hook system.

## How it works

Every package lives under `packages/`. Each package's contents mirror `$HOME` and get symlinked into place. For example:

```
dotfiles/
├── install.sh
├── hooks/
│   └── <package>.sh
└── packages/
    ├── zsh/
    │   └── .zshrc
    ├── git/
    │   └── .gitconfig
    ├── config/
    │   └── .config/
    │       └── nvim/
    │           └── init.vim
    └── <tool>/
        └── .<tool>/
            └── config.toml
```

`install.sh` symlinks each package's contents to the matching path under `$HOME`, handles conflicts, and runs any package-specific setup via hooks.

**What's tracked here:** plain-text config — settings, preferences, non-secret defaults.

**What's not tracked here:** credentials, tokens, session data — see [Secrets](#secrets) below.

## First time setup

Run the following command in your terminal in the `HOME` directory:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/benyap/dotfiles/main/install.sh)"
```

This installs the dotfiles into the `~/.dotfiles` directory. Behind the scenes it:

1. Checks for required tools and installs anything missing (see [Preflight checks](#preflight-checks)).
2. Clones this repo to `~/.dotfiles`.
3. Hands off to the cloned copy of `install.sh`, which discovers and stows every package.

It's safe to re-run this command later — if `~/.dotfiles` already exists, it skips the clone and just re-runs the stow step, so running it twice never duplicates anything.

## Managing the dotfiles

### Pulling in remote changes

Navigate to the `~/.dotfiles` directory and run the following commands:

```bash
cd ~/.dotfiles
git pull
./install.sh
```

`./install.sh` re-links anything new and is a no-op for packages that are already correctly linked — safe to run as often as you like, even for packages with deeply nested files.

### Existing machine with pre-existing config files

If real (non-symlinked) files already exist at a target path — say `~/.zshrc` predates this repo — `install.sh` automatically backs them up before linking. See [Conflicts and backups](#conflicts-and-backups).

## Preflight checks

Both the bootstrap one-liner and every normal run of `./install.sh` check for required tools before touching anything, and install what's missing:

| Tool                     | Platform   | How it's ensured                                                               |
| ------------------------ | ---------- | ------------------------------------------------------------------------------ |
| Xcode Command Line Tools | macOS only | Triggers `xcode-select --install` and waits for it to finish before continuing |
| Homebrew                 | macOS only | Installed via the official install script if `brew` isn't found                |
| git                      | all        | Installed via Homebrew / `apt` / `pacman`, whichever is available              |
| GNU Stow                 | all        | Installed via Homebrew / `apt` / `pacman`, whichever is available              |

All checks are idempotent — on a machine that already has everything, they're just `command -v` lookups and add negligible overhead to a normal `./install.sh` run.

## `install.sh` usage

`install.sh` detects which mode it's running in automatically:

- **Bootstrap mode** — no backing file on disk (e.g. piped via `curl | bash`). Runs preflight checks, clones the repo to `~/.dotfiles`, then re-executes the on-disk copy.
- **Normal mode** — running from an actual file inside a cloned repo (e.g. `cd ~/.dotfiles && ./install.sh`). Discovers and stows/unstows packages under `packages/`.

Once inside the repo, normal-mode flags:

```
./install.sh                    # stow all discovered packages
./install.sh <package> ...      # stow only specific packages
./install.sh -D                 # unstow all discovered packages
./install.sh -D <package>       # unstow specific packages
./install.sh -n                 # dry run (alias: DRY_RUN=1 ./install.sh)
./install.sh -h                 # show usage
```

Flags can be combined and appear in any order, e.g. `./install.sh -D -n <package>`.

Packages are **discovered automatically** — every directory under `packages/` is treated as a package. Since anything not meant to be stowed simply doesn't live under `packages/`, there's no ignore list to maintain. Adding a new package requires no edits to `install.sh`.

### Conflicts and backups

Before symlinking a package, `install.sh` checks whether a real file already sits at the target path. If so, it's moved (not deleted) to:

```
~/.dotfiles/.backup/<timestamp>/
```

so you can recover or diff it afterward. This directory is gitignored — backups stay local to the machine and are never committed.

Broken symlinks left over from a previous run are cleaned up automatically.

### Verifying

After a run, `install.sh` prints exactly which top-level paths were touched, e.g.:

```
[install] Done. Verify with: ls -la ~/.zshrc ~/.config
```

## Adding a new package

1. Create a directory under `packages/` that mirrors `$HOME`, e.g. for tmux:
   ```bash
   mkdir -p packages/tmux/.config/tmux
   mv ~/.config/tmux/tmux.conf packages/tmux/.config/tmux/tmux.conf
   ```
2. Run it:
   ```bash
   ./install.sh tmux
   ```
3. If the package needs setup beyond symlinking (installing a plugin manager, writing an ignore file, checking a CLI is installed), add `hooks/tmux.sh` — see [Hooks](#hooks). If it doesn't need anything special, skip this step entirely.

## Hooks

Package-specific logic lives in `hooks/<package>.sh`, not in `install.sh`. Each hook file may define any of:

| Function      | Runs                                      |
| ------------- | ----------------------------------------- |
| `pre_stow`    | before the package is symlinked           |
| `post_stow`   | after the package is symlinked            |
| `pre_unstow`  | before the package's symlinks are removed |
| `post_unstow` | after the package's symlinks are removed  |

All are optional — a package with no special needs has no hook file at all. Hooks run in an isolated subshell with `$PKG_PATH`, `$TARGET_DIR`, `$DRY_RUN`, and the `log`/`warn`/`err` helpers in scope.

A hook typically handles things stow itself can't: writing a `.gitignore` for a tool's runtime/secret files, creating a placeholder for machine-local values, or warning if a CLI the package depends on isn't installed yet. See whatever hooks currently exist under `hooks/` for concrete examples specific to this repo.

## Secrets

The rule: **anything that's a credential, token, or runtime/session data never gets committed — only the pattern for handling it lives in this repo.** Two mechanisms cover most cases:

**1. Per-package `.gitignore` for tool-managed secrets.**
Many CLIs write auth files, session logs, or history directly into their own config directory alongside the settings you _do_ want to track. Add a `.gitignore` inside that package (e.g. `packages/<package>/.<tool>/.gitignore`) listing whatever that specific tool writes — check that tool's docs for exact filenames, since they vary and can change between versions. A hook's `post_stow` can create this file automatically if it doesn't exist yet, so it's there even before the tool has run for the first time.

**2. A local, untracked file for exported values (API keys, tokens).**
Keep these out of any tracked config entirely. Common pattern for shell-sourced secrets:

```bash
# in packages/zsh/.zshrc (tracked)
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
```

```bash
# ~/.zshrc.local (untracked, machine-local)
export SOME_API_KEY="..."
```

A hook can create a placeholder `~/.zshrc.local` on first run so there's somewhere obvious to put real values — fill them in after cloning on each new machine.

**On a new machine:** re-authenticate any CLI tools after stowing — credentials stored in a system keyring or auth file don't travel with the repo, only the config that points at them does.

**Before every commit that touches a package with secrets nearby:** run `git diff` and check nothing sensitive slipped into a tracked file.

## Unstowing

To remove symlinks without deleting the underlying files:

```bash
./install.sh -D               # unstow everything
./install.sh -D <package>     # unstow just one package
```

This only removes the symlinks stow created — it never touches real files a tool wrote directly, like auth files or session logs. Empty directories left behind after unstowing are usually cleaned up automatically by stow; if not:

```bash
find ~/.config -type d -empty
```

## Repo configuration

This repo is already configured to bootstrap from `benyap/dotfiles`:

```bash
DOTFILES_REPO="${DOTFILES_REPO:-https://github.com/benyap/dotfiles.git}"
```

If you fork this repo, update that line in `install.sh` (and the URL in [First time setup](#first-time-setup) and in `install.sh`'s own header comment) to point at your fork instead. Commit and push — the raw URL only resolves once the file exists on the default branch.

## Maintenance checklist

- **Editing a config?** Edit the file inside `packages/<package>/...`, not the symlink target in `$HOME` — they're the same file, but editing inside the repo makes it obvious what to `git commit`.
- **Adding a package?** See [Adding a new package](#adding-a-new-package) above. No `install.sh` changes needed.
- **Rotating a secret?** Update the relevant untracked local file (e.g. `~/.zshrc.local`) on each machine individually — it's intentionally never synced via git.
- **Removing a package?** `./install.sh -D <package>`, then `rm -rf packages/<package>/` and commit.
- **Before committing:** run `./install.sh -n` to confirm nothing unexpected would change, and `git diff` to make sure no secrets snuck into a tracked file.
