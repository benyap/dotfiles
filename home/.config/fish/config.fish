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

# Load Google CLoud SDK autocomplete
source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Export GPG
set -gx GPG_TTY (tty)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Load jenv (Java env manager)
# Disabled as not really used at the moment
# set PATH $HOME/.jenv.bin $PATH
# status --is-interactive; and source (jenv init -|psub)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Load Python 3.8
set PATH /usr/local/opt/python@3.8/bin $PATH

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set path for programs in ~/.bin
set PATH $HOME/.bin/apache-maven-3.8.4/bin $PATH

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Define fish specific aliases
alias reload="source $HOME/.config/fish/config.fish"
alias pyenv="source venv/bin/activate.fish"

# Source aliases
[ -f $HOME/.config/aliases ] && source $HOME/.config/aliases;

# Source local config if it exists
[ -f $HOME/.config/fish/config.fish.local ] && source $HOME/.config/fish/config.fish.local;

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
