#!/bin/bash

setup_terminal_theme() {
  # Set up custom profile as default in Terminal.app
  osascript tasks/setup_terminal_theme.applescript
  print_success "Default theme for Terminal set up"
}
