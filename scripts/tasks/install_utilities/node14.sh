#!/bin/bash

# We install a keg-only version of Node14 using brew so that it can be used
# by Raycast, as it isn't able to make use of Node versions installed via nvm.
# To use this version of Node, use this shebang: #!/usr/local/opt/node@14/bin/node
install_keg_only_node14() {
  brew_install "Node 14" "node@14"
}
