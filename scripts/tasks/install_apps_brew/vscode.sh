#!/bin/bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_vscode() {
  brew_install_app "Visual Studio Code" "visual-studio-code"
  execute "defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false" "Enable key repeat for Visual Studio Code"
  _install_vscode_plugins
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

_is_vscode_plugin_installed() {
  local -r extension_identifier="$1"
  if find "$HOME"/.vscode/extensions/*"$extension_identifier"* -d 0 &> /dev/null; then
    return 1
  else
    return 0
  fi
}

_install_vscode_plugin() {
  local -r name="$1"
  local -r extension="$2"
  if _is_vscode_plugin_installed "$extension"; then
    execute "code --install-extension $extension" "VSCode Extension - $name"
  else
    print_ok "VSCode Extension - $name already installed"
  fi;
}

_install_vscode_plugins() {
  _install_vscode_plugin "Project Manager" "alefragnani.project-manager"
  _install_vscode_plugin "PDF Preview" "analytic-signal.preview-pdf"
  _install_vscode_plugin "Color Picker" "anseki.vscode-color"
  _install_vscode_plugin "Tailwind CSS IntelliSense" "bradlc.vscode-tailwindcss"
  _install_vscode_plugin "Better TOML" "bungcip.better-toml"
  _install_vscode_plugin "NDJSON Colorizer" "buster.ndjson-colorizer"
  _install_vscode_plugin "Firestore Rules" "chflick.firecode"
  _install_vscode_plugin "ESLint" "dbaeumer.vscode-eslint"
  _install_vscode_plugin "XML Tools" "dotjoshjohnson.xml"
  _install_vscode_plugin "GitLens" "eamodio.gitlens"
  _install_vscode_plugin "Prettier" "esbenp.prettier-vscode"
  _install_vscode_plugin "Auto Close Tag" "formulahendry.auto-close-tag"
  _install_vscode_plugin "Auto Rename Tag" "formulahendry.auto-rename-tag"
  _install_vscode_plugin "Terraform" "hashicorp.terraform"
  _install_vscode_plugin "AppleScript" "idleberg.applescript"
  _install_vscode_plugin "Edit CSV" "janisdd.vscode-edit-csv"
  _install_vscode_plugin "Rainbow CSV" "mechatroner.rainbow-csv"
  _install_vscode_plugin "JSON5 syntax" "mrmlnc.vscode-json5"
  _install_vscode_plugin "Docker" "ms-azuretools.vscode-docker"
  _install_vscode_plugin "Pyright" "ms-pyright.pyright"
  _install_vscode_plugin "Python" "ms-python.python"
  _install_vscode_plugin "Live Share" "ms-vsliveshare.vsliveshare"
  _install_vscode_plugin "Jupyter" "ms-toolsai.jupyter"
  _install_vscode_plugin "Color Highlight" "naumovs.color-highlight"
  _install_vscode_plugin "VSCode Twoslash Queries" "orta.vscode-twoslash-queries"
  _install_vscode_plugin "Material Icon Theme" "pkief.material-icon-theme"
  _install_vscode_plugin "Markdown Preview Enhanced" "shd101wyy.markdown-preview-enhanced"
  _install_vscode_plugin "Fish" "skyapps.fish-vscode"
  _install_vscode_plugin "Jest Snapshot Language Support" "tlent.jest-snapshot-language-support"
  _install_vscode_plugin "ShellCheck" "timonwong.shellcheck"
  _install_vscode_plugin "MDX" "unifiedjs.vscode-mdx"
  _install_vscode_plugin "Highlight Matching Tag" "vincaslt.highlight-matching-tag"
  _install_vscode_plugin "Vim" "vscodevim.vim"
  _install_vscode_plugin "Which Key" "vspacecode.whichkey"
  _install_vscode_plugin "TODO Highlight" "wayou.vscode-todo-highlight"
  _install_vscode_plugin "VimL" "xadillax.viml"
  _install_vscode_plugin "MDX Preview" "xyc.vscode-mdx-preview"
  _install_vscode_plugin "Markdown All in One" "yzhang.markdown-all-in-one"
  _install_vscode_plugin "One Dark Pro" "zhuangtongfa.material-theme"
}
