#!/bin/bash

# We install a keg-only version of Node using brew so that it can be used
# by Raycast as it isn't able to make use of Node versions installed via nvm.
#
# To use this version of Node, use this shebang: 
#   Intel - #!/usr/local/opt/node@18/bin/node
#   Apple - #!/opt/homebrew/opt/node@18/bin/node
install_keg_only_node18() {
  brew_install "Node 18" "node@18"
}
