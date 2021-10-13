#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Color Conversion
# @raycast.mode compact
#
# Optional parameters:
# @raycast.icon 🎨
# @raycast.packageName Developer Utilities
# @raycast.argument1 { "type": "text", "placeholder": "#ffeeff | rgb() " }
# @raycast.argument2 { "type": "text", "placeholder": "rgb | hex" }
#
# Documentation:
# @raycast.description Convert color formats (e.g. #FFEEFF -> rgba(255,238,255)
# @raycast.author quelhasu
# @raycast.authorURL https://github.com/quelhasu

function rgbToHex() {
  RGB=$(echo "$1" | awk -F '[()]' '{print $2}')
  IFS=,
  set "$RGB"
  R=$1
  G=$2
  B=$3
  printf "%02x%02x%02x" "$R" "$G" "$B"
}

color=$(echo "$1" | tr '[:upper:]' '[:lower:]')
to_format=$(echo "$2" | tr '[:upper:]' '[:lower:]')

if test "${color:0:1}" = "#"; then
  hex="${color:1:6}"
elif test "${color:0:3}" = "rgb"; then
  hex=$(rgbToHex "$color")
else
  echo "Incorrect color format $to_format"
  exit 1
fi

case $to_format in

  rgb)
    transformed_color=$(printf "rgb(%d,%d,%d)" 0x"${hex:0:2}" 0x"${hex:2:2}" 0x"${hex:4:2}")
    ;;

  hex)
    transformed_color="#${hex}"
    ;;

  *)
    echo "Incorrect color format $to_format"
    exit 1
    ;;

esac

if [ "${transformed_color}" ]; then
  echo "$transformed_color" | pbcopy
  echo "$transformed_color"
fi
