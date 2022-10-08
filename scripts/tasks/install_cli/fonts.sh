#!/bin/bash

install_fonts() {
  brew_tap "Homebrew Cask Fonts" "homebrew/cask-fonts"
  brew_install "Hack Nerd Font" "font-hack-nerd-font" "--cask"
}
