#!/bin/bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Execute relative to location of this file
cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

init() {
  # Set starting directory
  local -r startDir=$(pwd)

  # Load utils and functions
  source utils.sh && cd "$startDir" || exit 1
  source installs/main.sh && cd "$startDir" || exit 1
  source tasks/main.sh && cd "$startDir" || exit 1

  print_line
  print_info "SYSTEM POST SET UP - benyap/dotfiles"
  print_info "These scripts are going to modify your system."
  print_info "Make sure you know what you are doing!"
  print_line

  ask_for_confirmation "⚠️ Use these scripts at your own risk. Are you sure you want to proceed?"

  if ! answer_is_yes; then
    print_line
    print_success "Nothing was changed. Goodbye 👋🏻"
    exit 0
  fi
}

main() {
  print_info "You may be asked for your password to execute sudo."
  ask_for_sudo
  print_line

  print_info "Installing system configuration..."
  setup_symlinks_post
  print_info "Finished configuring system"
  print_line

  print_success "🎉 System post set up complete!"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

init
main

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
