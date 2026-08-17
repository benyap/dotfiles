#!/bin/bash

DOTFILES="$HOME/.dotfiles"
DOTFILES_CONFIG="$HOME/.dotfiles/home/.config"
echo "ℹ️ Dotfiles directory: $DOTFILES"

# Install xcode

is_xcode_installed() {
  xcode-select --print-path &>/dev/null
}

if ! is_xcode_installed; then
  echo "⏳ Installing: XCode CLI tools..."
  xcode-select --install &>/dev/null
  until is_xcode_installed; do sleep 10; done
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
if [[ ! -d "$DOTFILES" ]]; then
  echo "⏳ Cloning: benyap/dotfiles..."
  git clone "https://github.com/benyap/dotfiles.git" "$DOTFILES"
  echo "✅ Cloned: benyap/dotfiles"
else
  echo "ℹ️ Directory $DOTFILES already exists"
fi

# Install apps with brew
echo "🔄 Updating homebrew..."
brew update
echo "⏳ Installing: Brewfile..."
brew bundle --file=$DOTFILES/Brewfile install

# Symlink files
cd $DOTFILES
stow -t ~ home
echo "📦 Symlinked configs with stow"

# Configure asdf
echo "⏳ Installing: asdf plugins..."
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin add java https://github.com/halcyon/asdf-java.git
echo "✅ Installed asdf plugins"

echo "⏳ Installing: asdf tools..."
asdf install nodejs latest:22
asdf install nodejs latest:24
asdf install java latest:openjdk
echo "✅ Installed asdf tools"

echo "🔧 Setting: asdf tool versions..."
asdf set -u nodejs latest:24
asdf set -u java latest:openjdk
echo "✅ Set asdf tool versions"

# Configure bat
echo "🔧 Setting: updating bat cache"
bat cache --build
echo "✅ Updated bat cache"

# Configure tmux
if [[ ! -d "$DOTFILES_CONFIG/tmux/plugins/tpm" ]]; then
  echo "⏳ Cloning: tmux-plugins/tpm..."
  git clone "https://github.com/tmux-plugins/tpm" "$DOTFILES_CONFIG/tmux/plugins/tpm"
  echo "✅ Cloned: tmux-plugins/tpm"
else
  echo "ℹ️ Directory $DOTFILES_CONFIG/tmux/plugins/tpm already exists"
fi
