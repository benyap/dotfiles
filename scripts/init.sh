#!/bin/bash

main() {
  # Set starting directory
  local -r start_dir=$(pwd)

  # Load utils and functions
  source utils.sh && cd "$start_dir" || exit 1
  source installs/main.sh && cd "$start_dir" || exit 1

  # Install core tools
  print_info "Installing core tools..."
  install_xcode_command_line_tools
  install_homebrew

  # Install developer tools & applications
}

main
