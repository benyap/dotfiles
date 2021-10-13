#!/bin/bash


install_fish() {
  brew_install "fish" "fish"
  _install_fisher
  _install_fish_plugins
}


# NOTE: even though fisher is "installed" already by existing in the .config/fish directory,
# running this function anyway will ensure that it is up to date.
_install_fisher() {
  local exitCode=0

  /usr/local/bin/fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher" &> /dev/null

  exitCode=$?

  if test $exitCode -eq 0; then
    print_success "fisher"
  else
    print_error "fisher failed to install"
  fi
}


_install_fish_plugins() {
  _install_fish_plugin "z" "jethrokuan/z"
  _install_fish_plugin "autopair" "jorgebucaran/autopair.fish"
  _install_fish_plugin "bass" "edc/bass"
  _install_fish_plugin "fish-nvm" "FabioAntunes/fish-nvm"
  _install_fish_plugin "tide" "IlanCosman/tide@v5"
  _install_fish_plugin "google-cloud-sdk-fish-completion" "lgathy/google-cloud-sdk-fish-completion"
  _install_fish_plugin "colored_man_pages" "patrickf1/colored_man_pages.fish"
}


_install_fish_plugin() {
  local -r name="$1"
  local -r plugin="$2"
  local -r plugins_list="$(cd .. && pwd)/home/.config/fish/fish_plugins"

  if ! grep "$plugin" "$plugins_list" &> /dev/null; then
    execute "/usr/local/bin/fish -c 'fisher install $plugin'" "fish plugin - $name"
  else
    print_ok "fish plugin - $name already installed"
  fi
}
