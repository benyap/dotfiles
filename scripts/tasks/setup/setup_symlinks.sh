#!/bin/bash

setup_symlinks() {
  # Directories that need to exist for symlinks to not die
  local -ar directories=(
    ".bin"
    ".config"
    "Library/Application Support/Code/User"
  )

  # Files or directories to symlink
  local -ar links=(
    ".bin"
    ".config/antibody"
    ".config/fish"
    ".config/iterm2"
    ".config/kitty"
    ".config/raycast"
    ".config/aliases"
    ".config/starship.toml"
    "Library/Application Support/Code/User/settings.json"
    "Library/Application Support/Code/User/keybindings.json"
    ".gitconfig"
    ".gitconfig.local"
    ".gitignore"
    ".zshrc"
    ".zshrc.local"
  )

  # Create directories for symlinks
  for dir in "${directories[@]}"; do
    _create_directory "$dir"
  done

  # Create symlinks
  for link in "${links[@]}"; do
    _create_symlink "$link"
  done
}

_create_directory() {
  local -r directory="$1"

  local path=""
  local pathEscaped=""

  path="$HOME/$directory"
  pathEscaped="$(escape_path_containing_spaces "$path")"

  if ! test -d "$path"; then
    execute "mkdir -p $pathEscaped" "Create directory $path"
  else
    print_ok "Directory exists $path"
  fi
}

_create_symlink() {
  local -r link="$1"

  local sourceFile=""
  local targetFile=""
  local sourceFileEscaped=""
  local targetFileEscaped=""

  sourceFile="$(cd .. && pwd)/home/$link"
  targetFile="$HOME/$link"

  sourceFileEscaped="$(escape_path_containing_spaces "$sourceFile")"
  targetFileEscaped="$(escape_path_containing_spaces "$targetFile")"

  # If the symlink doesn't exist, create it
  if ! test -e "$targetFile"; then
    execute "ln -fs $sourceFileEscaped $targetFileEscaped" "Link $targetFile"

  # If the symlink is already and is correct, then do nothing
  elif test "$(readlink "$targetFile")" == "$sourceFile"; then
    print_ok "Already linked $targetFile"

  # Otherwise, check if we want to overwrite the existing file
  else
    ask_for_confirmation "$targetFile already exists, do you want to overwrite it?"
    if answer_is_yes; then
      rm -rf "$targetFile"
      execute "ln -fs $sourceFileEscaped $targetFileEscaped" "Link $targetFile"
    else
      print_error "Link $targetFile"
    fi
  fi
}
