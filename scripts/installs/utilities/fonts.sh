#!/bin/bash

install_fonts() {
  brew_tap "Homebrew Cask Fonts" "homebrew/cask-fonts"
  brew_install "Meslo LG Nerd Font" "font-meslo-lg-nerd-font" "--cask"
}
