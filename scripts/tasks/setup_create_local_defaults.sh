#!/bin/bash

# Execute relative to location of this file
cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1


setup_create_local_defaults() {
  # These files are gitignored, so it's helpful to create them for new installs
  local -ar FILES=(
    ".gitconfig.local"
    ".zshrc.local"
    ".config/fish/config.fish.local"
  )

  local targetFile=""
  local targetFileEscaped=""

  for file in "${FILES[@]}"; do
    targetFile="$(cd .. && pwd)/home/$file"
    targetFileEscaped="$(escape_path_containing_spaces "$targetFile")"

    if ! test -e "$targetFile"; then
      execute "touch $targetFileEscaped" "Create local default $file"
    else
      print_ok "Default local file exists $file"
    fi
  done
}
