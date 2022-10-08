alias whichshell="echo zsh"

# Antibody update - run this when new bundles are added to bundles.txt
alias antibody_update="[ -f ~/.config/antibody/bundles.txt ] && antibody bundle < ~/.config/antibody/bundles.txt > ~/.zsh_plugins.sh"

# Load plugins from antibody
[ -f ~/.zsh_plugins.sh ] && source ~/.zsh_plugins.sh

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Load tabtab (for autocompletion)
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

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
