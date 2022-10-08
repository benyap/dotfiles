#!/bin/bash

setup_fish_plugins() {
  # `fisher` is installed by existing in the .config/fish/functions directory
  # See this URL for source: https://github.com/jorgebucaran/fisher
  # We run this command to ensure all required plugins are up to date
  fish -c "fisher update"
}
