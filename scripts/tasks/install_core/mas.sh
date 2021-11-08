#!/bin/bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


# Used to install apps from the App Store
install_mas() {
  brew_install "Mas" "mas"
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


mas_install() {
  local -r name="$1"
  local -r id="$2"
  
  # Install the formula
  if ! _is_installed_via_mas "$id"; then
    execute "mas install $id" "$name (via mas)"
  else
    print_ok "$name already installed"
  fi
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


_is_installed_via_mas() {
  mas list | grep "$1" &> /dev/null && return 0 || return 1
}
