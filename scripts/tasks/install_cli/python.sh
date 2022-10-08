#!/bin/bash

install_python() {
  brew_install "Python@3.10" "python@3.10"
  # Currently broken: https://github.com/Homebrew/homebrew-core/issues/76621
  # execute "pip3 install --upgrade pip" "Update pip"
}
