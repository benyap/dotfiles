# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Opt out of Homebrew analytics
# https://github.com/Homebrew/brew/blob/0c95c60511cc4d85d28f66b58d51d85f8186d941/share/doc/homebrew/Analytics.md#opting-out
export HOMEBREW_NO_ANALYTICS=1

# Opt out of Homebrew auto update when running commands like install
# https://docs.brew.sh/Manpage#environment
export HOMEBREW_NO_AUTO_UPDATE=1

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Antibody update - run this when new bundles are added to bundles.txt
alias antibody_update="[ -f ~/.config/antibody/bundles.txt ] && antibody bundle < ~/.config/antibody/bundles.txt > ~/.zsh_plugins.sh"

# Load plugins from antibody
[ -f ~/.zsh_plugins.sh ] && source ~/.zsh_plugins.sh

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Load Google Cloud SDK autocomplete
source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Export GPG
export GPG_TTY=$(tty)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Load jEnv (for managing multiple Java versions)
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Define zsh specific aliases
alias reload="source ~/.zshrc"
alias pyenv="source venv/bin/activate"

# Source shared aliases
[ -f ~/.config/aliases ] && source ~/.config/aliases;

# Source local config if it exists
[ -f ~/.zshrc.local ] && source ~/.zshrc.local;

# Use starship propmt
eval "$(starship init zsh)"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
