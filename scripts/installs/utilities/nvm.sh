#!/bin/bash

install_nvm() {
  if ! test -d "$HOME/.nvm"; then
    execute "/bin/bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh' | bash" "nvm"
  else
    print_ok "nvm already installed"
  fi

  # Install a default version of node
  local -r defaultNodeVersion=14
  if ! _is_nvm_version_installed "$defaultNodeVersion"; then
    source "$HOME/.nvm/nvm.sh"
    execute "nvm install $defaultNodeVersion" "Node $defaultNodeVersion (via nvm)"
    execute "nvm use 14 && npm i -g yarn" "yarn (via npm)"
  else
    print_ok "Node $defaultNodeVersion (via nvm) already installed"
  fi
}

_is_nvm_version_installed() {
  local -r version="$1"
  if find "$HOME/.nvm/versions/node/v$version"* -d 0 &> /dev/null; then
    return 0;
  else
    return 1;
  fi
}
