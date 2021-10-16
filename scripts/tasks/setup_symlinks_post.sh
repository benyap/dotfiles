#!/bin/bash

# Execute relative to location of this file
cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1

setup_symlinks_post() {
  # Files or directories to symlink
  local -ar links=(
    ".config/lvim/config.lua"
  )

  _create_symlinks "${links[@]}"
}
