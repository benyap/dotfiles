#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1

# Load install functions
source core/xcode.sh
source core/homebrew.sh
source core/git.sh

source apps/1password.sh
source apps/dbeaver.sh
source apps/docker.sh
source apps/forklift.sh
source apps/gpgsuite.sh
source apps/iina.sh
source apps/kitty.sh
source apps/megasync.sh
source apps/postman.sh
source apps/raycast.sh
source apps/rectangle.sh
source apps/vlc.sh
source apps/vscode.sh

source browsers/chrome.sh
source browsers/firefox.sh

source utilities/antibody.sh
source utilities/awscli.sh
source utilities/bfg.sh
source utilities/duti.sh
source utilities/exa.sh
source utilities/fd.sh
source utilities/fish.sh
source utilities/fonts.sh
source utilities/gcloud.sh
source utilities/gnupg.sh
source utilities/lazydocker.sh
source utilities/lazygit.sh
source utilities/neovim.sh
source utilities/node14.sh
source utilities/nvm.sh
source utilities/python.sh
source utilities/ripgrep.sh
source utilities/terraform.sh
source utilities/vim.sh
source utilities/zsh.sh
