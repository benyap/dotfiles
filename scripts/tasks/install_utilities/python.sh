#!/bin/bash

install_python() {
  brew_install "Python@3.8" "python@3.8"
  execute "pip3 install --upgrade pip" "Update pip"
}
