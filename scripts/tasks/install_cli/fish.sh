#!/bin/bash

install_fish() {
  brew_install "fish" "fish"
}

_fish_path() {
   if is_arm; then
    echo /opt/homebrew/bin/fish
  else
    echo /usr/local/bin/fish
  fi
}
