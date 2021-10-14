# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Don't need to be greeted by fish every time
set fish_greeting

# Opt out of Homebrew analytics
# https://github.com/Homebrew/brew/blob/0c95c60511cc4d85d28f66b58d51d85f8186d941/share/doc/homebrew/Analytics.md#opting-out
export HOMEBREW_NO_ANALYTICS=1

# Opt out of Homebrew auto update when running commands like install
# https://docs.brew.sh/Manpage#environment
export HOMEBREW_NO_AUTO_UPDATE=1

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Export GPG
set -gx GPG_TTY (tty)

# Define fish specific aliases
alias reload="source ~/.config/fish/config.fish"
alias pyenv="source venv/bin/activate.fish"

# Source aliases
[ -f ~/.config/aliases ] && source ~/.config/aliases;

# Source local config if it exists
[ -f ~/.config/fish/config.fish.local ] && source ~/.config/fish/config.fish.local;

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
