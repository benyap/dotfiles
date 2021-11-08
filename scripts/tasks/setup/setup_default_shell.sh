#!/bin/bash

setup_default_shell() {
  local -r shellPath=/usr/local/bin/fish

  if ! grep "$shellPath" /etc/shells &> /dev/null; then
    execute "sudo echo $shellPath | sudo tee /etc/shells" "Make fish a standard shell in /etc/shells"
  else
    print_ok "fish already defined as a standard shell in /etc/shells"
  fi

  if ! test "$(_get_default_shell)" == "$shellPath"; then
    execute "sudo chsh -s $shellPath $USER" "Set fish as default shell"
  else
    print_ok "fish is already the default shell"
  fi
}

_get_default_shell() {
  finger "$USER" | grep -oG 'Shell: .*' | cut -d ' ' -f2
}
