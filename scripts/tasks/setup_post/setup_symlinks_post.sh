#!/bin/bash

setup_symlinks_post() {
  # Files or directories to symlink
  local -ar links=(
    ".config/lvim/config.lua"
  )

  _create_symlink "${links[@]}"
}
