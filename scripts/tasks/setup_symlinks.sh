#!/bin/bash

# Execute relative to location of this file
cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1

setup_symlinks() {
  # Directories that need to exist for symlinks to not die
  local -ar DIRS=(
    "Library/Application Support/Code/User"
    ".config"
  )

  # Files or directories to symlink
  local -ar LINKS=(
    ".bin"
    ".config/antibody"
    ".config/fish"
    ".config/kitty"
    ".config/raycast"
    ".config/aliases"
    "Library/Application Support/Code/User/settings.json"
    ".gitconfig"
    ".gitconfig.local"
    ".gitignore"
    ".zshrc"
    ".zshrc.local"
  )

  local path=""
  local pathEscaped=""

  # Create directories for symlinks
  for dir in "${DIRS[@]}"; do
    path="$HOME/$dir"
    pathEscaped="$(escape_path_containing_spaces "$path")"

    if ! test -d "$path"; then
      execute "mkdir -p $pathEscaped" "Create directory $path"
    else
      print_ok "Directory exists $path"
    fi
  done

  local link=""
  local sourceFile=""
  local targetFile=""
  local sourceFileEscaped=""
  local targetFileEscaped=""

  # Create symlinks
  for link in "${LINKS[@]}"; do
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
  done
}
