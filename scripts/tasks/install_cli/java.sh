#!/bin/bash

install_java() {
  brew_install "jEnv" "jenv"
  brew_install "Java 11" "openjdk@11"
  brew_install "Java 17" "openjdk@17"
}
