#!/bin/bash

setup_git_tracking() {
  # If the current directory is not a git repository, set one up
  # The repository to clone from should be provided as $1
  # The root directory of the repo should be provided as $2
  # Contents of current directory will be backed up, and the
  # contents of the new repository will take its place

  local -r origin="$1"
  local -r rootDir="$2"
  local -r startDir="$(pwd)"

  cd "$rootDir" || exit 1

  local -r parentDir="$(cd .. && pwd)"

  if ! _is_git_repository; then
    cd "$parentDir" || exit 1;
    mv "$rootDir" "$rootDir.backup"
    print_info "Moved current dotfiles to $rootDir.backup"
    mkdir "$rootDir"
    git clone "$origin" "$rootDir" --recurse-submodules
    print_success "Tracking repository as $origin"
  else
    print_ok "Git tracking already enabled"
  fi

  cd "$startDir" || exit 1
}

_is_git_repository() {
  git remote get-url origin &> /dev/null
}
