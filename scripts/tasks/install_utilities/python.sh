#!/bin/bash

install_python() {
  brew_install "Python@3.8" "python@3.8"
  # Currently broken: https://github.com/Homebrew/homebrew-core/issues/76621
  # execute "pip3 install --upgrade pip" "Update pip"
}
