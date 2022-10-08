#!/bin/bash

setup_default_shell() {
  local -r fishPath=$(_fish_path)

  if ! grep "$fishPath" /etc/shells &> /dev/null; then
    execute "sudo echo $fishPath | sudo tee /etc/shells" "Make fish a standard shell in /etc/shells"
  else
    print_ok "fish already defined as a standard shell in /etc/shells"
  fi

  if ! test "$(_get_default_shell)" == "$fishPath"; then
    execute "sudo chsh -s $fishPath $USER" "Set fish as default shell"
  else
    print_ok "fish is already the default shell"
  fi
}

_get_default_shell() {
  finger "$USER" | grep -oG 'Shell: .*' | cut -d ' ' -f2
}
