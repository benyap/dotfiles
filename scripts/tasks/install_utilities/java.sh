#!/bin/bash

install_java() {
  brew_install "jEnv" "jenv"
  brew_install "Java 8" "openjdk@8"
  brew_install "Java (latest)" "openjdk"
}
