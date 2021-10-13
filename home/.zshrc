# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Opt out of Homebrew analytics
# https://github.com/Homebrew/brew/blob/0c95c60511cc4d85d28f66b58d51d85f8186d941/share/doc/homebrew/Analytics.md#opting-out
export HOMEBREW_NO_ANALYTICS=1

# Opt out of Homebrew auto update when running commands like install
# https://docs.brew.sh/Manpage#environment
export HOMEBREW_NO_AUTO_UPDATE=1

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Automatically call `nvm use` when switching to a directory that contains a `.nvmrc` file
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Source Google Cloud SDK autocomplete
source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

# Antibody update - run this when new bundles are added to bundles.txt
alias antibody_update="[ -f ~/.config/antibody/bundles.txt ] && antibody bundle < ~/.config/antibody/bundles.txt > ~/.zsh_plugins.sh"

# Load plugins from antibody
[ -f ~/.zsh_plugins.sh ] && source ~/.zsh_plugins.sh

# Load pure prompt
autoload -Uz async && async
autoload -U promptinit && promptinit
prompt pure

# Customise pure
PROMPT='%F{yellow}%* '$PROMPT

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Export GPG
export GPG_TTY=$(tty)

# Define zsh specific aliases
alias reload="source ~/.zshrc"
alias pyenv="source venv/bin/activate"

# Source shared aliases
[ -f ~/.config/aliases ] && source ~/.config/aliases;

# Source local config if it exists
[ -f ~/.zshrc.local ] && source ~/.zshrc.local;

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
