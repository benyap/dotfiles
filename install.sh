#!/bin/bash

# Install xcode

is_xcode_installed() {
  xcode-select --print-path &> /dev/null
}

if ! is_xcode_installed; then
  echo "⏳ Installing: XCode CLI tools..."
  xcode-select --install &> /dev/null
  until is_xcode_installed; do sleep 10; done;
fi
echo "✅ Installed: XCode CLI tools"

# Install homebrew

if [[ $(command -v brew) == "" ]]; then
  echo "⏳ Installing: homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
echo "✅ Installed: homebrew"

# Install git
if [[ $(command -v git) == "" ]]; then
  echo "⏳Install git..."
  brew install git
fi
echo "✅ Installed: git"

# Download dotfiles
if [[ ! -d "$HOME/.dotfiles" ]]; then
  echo "⏳ Cloning: benyap/dotfiles..."
  git clone "https://github.com/benyap/dotfiles.git" "$HOME/.dotfiles"
  echo "✅ Cloned: benyap/dotfiles"
else
  echo "⚠️  Directory $HOME/.dotfiles already exists"
fi

# Install apps
echo "⏳ Installing: Brewfile..."
brew bundle install --file=~/.dotfiles/Brewfile
