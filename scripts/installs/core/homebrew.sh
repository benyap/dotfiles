#!/bin/bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


install_homebrew() {
  local exitCode=0

  if ! cmd_exists brew; then
    # Install brew using bash, simulate "ENTER" key press
    printf "\n" | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    exitCode=$?

    if test $exitCode -eq 0; then
      print_success "Homebrew"
    else
      print_error "Homebrew failed to install"
    fi

  else
    print_ok "Homebrew already installed"
  fi

  brew_update
  brew_upgrade
  brew_cleanup
}


# NOTE: this needs to be run after git is installed
opt_out_of_hombrew_analytics() {
  local -r brew_config_path="$(brew --repository)/.git/config"
  if [ "$(git config --file="$brew_config_path" --get homebrew.analyticsdisabled)" != "true" ]; then
    execute "git config --file=$brew_config_path --replace-all homebrew.analyticsdisabled true" "Configure Homebrew to opt out of analytics"
  else
    print_ok "Homebrew already opted out of analytics"
  fi
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


brew_tap() {
  local -r name="$1"
  local -r formula="$2"
  if ! _is_brew_tapped "$2"; then
    execute "brew tap $2 &> /dev/null" "$1 (via brew tap)"
  else
    print_ok "$name already tapped via brew"
  fi
}

brew_install() {
  local -r name="$1"
  local -r formula="$2"
  local -r arguments="$3"

  # Install the formula
  if ! _is_installed_via_brew "$formula"; then
    execute "brew install $formula $arguments" "$name (via brew)"
  else
    print_ok "$name already installed (via brew)"
  fi
}

brew_install_app() {
  local -r name="$1"
  local -r formula="$2"
  local -r arguments="$3"

  if ! test -e "/Applications/$1.app"; then
    brew_install "$1" "$2" "--cask $3"
  else
    print_ok "$1 already installed (via brew)"
  fi
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


_is_installed_via_brew() {
  brew list "$1" &> /dev/null && return 0 || return 1
}

_is_brew_tapped() {
  brew tap | grep "$1" &> /dev/null && return 0 || return 1
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


brew_update() {
  execute "brew update" "Homebrew update"
}

brew_upgrade() {
  execute "brew upgrade" "Homebrew upgrade"
}

brew_cleanup() {
  execute "brew cleanup" "Homebrew cleanup"
}
