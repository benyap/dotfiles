#!/bin/bash

install_xcode_command_line_tools() {
  if ! _xcode_command_line_tools_installed; then
    xcode-select --install &> /dev/null
    execute "until _xcode_command_line_tools_installed; do sleep 10; done" "XCode Command Line Tools"
  else
    print_ok "XCode Command Line Tools already installed"
  fi
}

_xcode_command_line_tools_installed() {
  xcode-select --print-path &> /dev/null
}
