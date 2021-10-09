#!/bin/bash

install_homebrew() {
  local exitCode=0

  if ! cmd_exists brew; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    exitCode=$?

    if [ $exitCode -eq 0 ]; then
      print_success "Homebrew"
    else
      print_error "Homebrew failed to install"
    fi

  else
    print_success "Homebrew already installed."
  fi
}
