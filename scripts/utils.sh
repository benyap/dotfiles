#!/bin/bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


_print_in_color() {
  printf "%b" \
    "$(tput setaf "$2" 2> /dev/null)" \
    "$1" \
    "$(tput sgr0 2> /dev/null)"
}

_print_in_blue() {
  _print_in_color "$1" 4
}

_print_in_green() {
  _print_in_color "$1" 2
}

_print_in_purple() {
  _print_in_color "$1" 5
}

_print_in_red() {
  _print_in_color "$1" 1
}

_print_in_yellow() {
  _print_in_color "$1" 3
}

_print_in_gray() {
  _print_in_color "$1" 7
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


print_line() {
  echo
}

print_question() {
  _print_in_yellow "[?] $1"
}

print_info() {
  _print_in_blue "[i] $1\n"
}

print_success() {
  _print_in_green "[✔] $1\n"
}

print_ok() {
  _print_in_gray "[✔] $1\n"
}

print_warning() {
  _print_in_yellow "[!] $1\n"
}

print_error() {
  _print_in_red "[✖] $1 $2\n"
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


print_error_stream() {
  while read -r line; do
    print_error "↳ ERROR: $line"
  done
}

print_result() {
  if test "$1" -eq 0; then
    print_success "$2"
  else
    print_error "$2"
  fi
  return "$1"
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


ask_for_sudo() {
  # Ask for the administrator password
  sudo -v &> /dev/null

  # Update existing `sudo` time stamp until this script has finished.
  # https://gist.github.com/cowboy/3118588
  while true; do
    sudo -n true
    sleep 60
    # Check if the parent process is still running. Exit if the parent process is dead.
    kill -0 "$$" || exit
  done &> /dev/null &
}

ask_for_confirmation() {
  print_question "$1 (Y/n) "
  read -r -n 1
  printf "\n"
}

ask() {
  print_question "$1"
  read -r
}

get_answer() {
  printf "%s" "$REPLY"
}

answer_is_yes() {
  [[ "$REPLY" =~ ^[Yy]?$ ]] && return 0 || return 1
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


cmd_exists() {
  command -v "$1" &> /dev/null
}

escape_path_containing_spaces() {
  printf "%s" "$1" | sed 's/ /\\ /g'
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


_set_trap() {
  trap -p "$1" | grep "$2" &> /dev/null || trap '$2' "$1"
}

execute() {
  local -r commands="$1"
  local -r message="${2:-$1}"
  local -r tempFile="$(mktemp /tmp/XXXXX)"

  local exitCode=0
  local commandsPID=""

  # If the current process is ended, also end all its subprocesses
  _set_trap "EXIT" "kill_all_subprocesses"

  # Execute commands in background
  # shellcheck disable=SC2261
  eval "$commands" \
    &> /dev/null \
    2> "$tempFile" &
  commandsPID=$!

  # Show a spinner if the commands require more time to complete
  show_spinner "$commandsPID" "$message"

  # Wait for the commands to no longer be executing in the background
  wait "$commandsPID" &> /dev/null
  exitCode=$?

  # Print output based on what happened.
  print_result $exitCode "$message"
  if [ $exitCode -ne 0 ]; then
    print_error_stream < "$tempFile"
  fi

  # Clear temp file
  rm -rf "$tempFile"

  return $exitCode
}

show_spinner() {
  local -r frames='/-\|'
  local -r number_of_frames=${#frames}

  local -r pid="$1"
  local -r message="$2"

  local i=0
  local frameText=""

  # Display spinner while the commands are being executed.
  while kill -0 "$pid" &>/dev/null; do
    frameText="[${frames:i++%number_of_frames:1}] $message"

    # Print frame text.
    printf "%s" "$frameText"
    sleep 0.2

    # Clear frame text.
    printf "\r"
  done
}
