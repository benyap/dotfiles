# Opt out of Homebrew analytics
# https://github.com/Homebrew/brew/blob/0c95c60511cc4d85d28f66b58d51d85f8186d941/share/doc/homebrew/Analytics.md#opting-out
export HOMEBREW_NO_ANALYTICS=1

# Opt out of Homebrew auto update when running commands like install
# https://docs.brew.sh/Manpage#environment
export HOMEBREW_NO_AUTO_UPDATE=1

DISABLE_AUTO_TITLE=true

# Configure aliases
alias reload="source ~/.zshrc"
alias c="clear"
alias ls="lsd"
alias ll="lsd -al"
alias tree="lsd -al --tree"
alias cat="bat"
alias lg="lazygit"
alias v="nvim"
alias n="nvim"

# Set up syntax helpers
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Initialise fzf
export FZF_COMPLETION_TRIGGER='?'
source <(fzf --zsh)

export FZF_DEFAULT_OPTS="--height 50% --layout=default --border"
export FZF_TMUX_OPTS=" -p90%,70% "

# Use fd with fzf
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# Use previews with fzf
show_file_or_dir_preview="if [ -d {} ]; then lsd -al --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'lsd -al --tree --color=always | head -200'"

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)            fzf --preview "lsd -al --tree --color=always {} | head -200" "$@" ;;
    export|unset)  fzf --preview "eval 'echo \${}'" "$@" ;;
    ssh)           fzf --preview "dig {}" "$@" ;;
    *)             fzf --preview "$show_file_or_dir_preview" "$@";;
  esac
}

# Initialise yazi
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

# Initialise fzf-git
source ~/.bin/fzf-git.sh

# Initialise asdf
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
. ~/.asdf/plugins/java/set-java-home.zsh

# Initialise zoxide
eval "$(zoxide init --cmd cd zsh)"

# Use starship prompt
eval "$(starship init zsh)"

