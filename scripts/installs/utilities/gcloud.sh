#!/bin/bash

install_gcloud() {
  if ! test _is_gcloud_installed_by_brew; then
    brew_install "Google Cloud SDK" "google-cloud-sdk" "--cask"
  else
    print_ok "Google Cloud SDK already installed (via brew)"
  fi
}

# Need a custom check because `brew list google-cloud-sdk` doesn't behave as expected
_is_gcloud_installed_by_brew() {
  brew list | grep 'google-cloud-sdk' &> /dev/null
}
