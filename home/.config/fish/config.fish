alias whichshell="echo fish"

# Don't need to be greeted by fish every time
set fish_greeting

# Set shortcut for enabling and disabling vi mode

function v
  switch $fish_bind_mode
    case default
      echo Currently using default key bindings
    case insert
      echo Currently VIM key bindings
  end
end

function vv
  switch $fish_bind_mode
    case default
      fish_vi_key_bindings
      echo Using VIM key bindings
    case '*'
      fish_default_key_bindings
      echo Using default key bindings
  end
end

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Load tabtab (for auto completion)
[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true

# Set path for programs in ~/.bin
# Disabled as not really used at the moment
# set PATH $HOME/.bin/apache-maven-3.8.4/bin $PATH

# Load jenv (Java env manager)
set PATH $HOME/.jenv.bin $PATH
status --is-interactive; and source (jenv init -|psub)

# Load Python 3.8
set PATH /usr/local/opt/python@3.8/bin $PATH

# pnpm
set -gx PNPM_HOME "$HOME/Library/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Define fish specific aliases
alias reload="source $HOME/.config/fish/config.fish"
alias pyenv="source venv/bin/activate.fish"

# Source shared aliases
[ -f $HOME/.config/aliases ] && source $HOME/.config/aliases;

# Source local config if it exists
[ -f $HOME/.config/fish/config.fish.local ] && source $HOME/.config/fish/config.fish.local;

# Use starship prompt
starship init fish | source

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
