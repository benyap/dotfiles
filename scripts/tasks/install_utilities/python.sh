#!/bin/bash

install_python() {
  brew_install "Python3" "python3"
  execute "pip3 install --upgrade pip" "Update pip"
}
