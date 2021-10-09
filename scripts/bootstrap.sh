#!/bin/bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


declare -r FILENAME="bootstrap.sh"

declare -r REPOSITORY="benyap/dotfiles"
declare -r UTILS_URL="https://raw.githubusercontent.com/$REPOSITORY/main/scripts/utils.sh"
declare -r TARBALL_URL="https://github.com/$REPOSITORY/tarball/main"

declare installDirectory="$HOME/.dotfiles"


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


download() {
  local -r url="$1"
  local -r output="$2"
  curl --location --silent --show-error --output "$output" "$url" &> /dev/null
  return $?
}


extract() {
  local -r archive="$1"
  local -r outputDir="$2"

  if command -v "tar" &> /dev/null; then
    tar \
      --extract \
      --gzip \
      --file "$archive" \
      --strip-components 1 \
      --directory "$outputDir"
    return $?
  fi

  return 1
}


download_utils() {
  local -r tempFile="$(mktemp /tmp/XXXXX)"

  # shellcheck source=/tmp/dotfiles-utils
  download "$UTILS_URL" "$tempFile" \
      && source "$tempFile" \
      && rm -rf "$tempFile" \
      && return 0

   return 1
}


download_source() {
  local -r tempFile="$(mktemp /tmp/XXXXX)"
  local -r prompt="Please specify another location for the dotfiles (path): "

  # Download latest source
  execute "download $TARBALL_URL $tempFile" "Download $REPOSITORY"
  ask_for_confirmation "Extract dotfiles to $installDirectory?"

  # Get directory to extract to
  if ! answer_is_yes; then
    installDirectory=""
    while [ -z "$installDirectory" ]; do
      ask "$prompt"
      installDirectory="$(get_answer)"
    done
  fi

  # Ensure the install directory is available
  while [ -e "$installDirectory" ]; do
    ask_for_confirmation "$installDirectory already exists, do you want to overwrite it?"
    if answer_is_yes; then
      rm -rf "$installDirectory"
      break
    else
      installDirectory=""
      while [ -z "$installDirectory" ]; do
        ask "$prompt"
        installDirectory="$(get_answer)"
      done
    fi
  done

  # Extract archive into the install directory
  execute "mkdir -p $installDirectory" "Created directory $installDirectory"
  execute "extract $tempFile $installDirectory" "Extracted $REPOSITORY to $installDirectory"
  rm -rf tempFile

  # Navigate to directory
  cd "$installDirectory/scripts" || return 1
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


main() {
  # Ensure that the following actions are made relative to this file's path
  cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1

  # Load in utils
  if test -f "utils.sh"; then
    source "utils.sh" || exit 1
  else
    download_utils || exit 1
  fi

  # Check if this script was run directly (this will be empty if run using bash inline).
  # If not, download the dotfiles repository and navigate to it.
  echo "${BASH_SOURCE[0]}" | grep $FILENAME &> /dev/null || download_source

  # Run the init script
  ./init.sh
}

main
