#!/bin/bash

set -euo pipefail

squareRescale() {
  local dim="${2}x${2}"
  local o=$(mktemp)

  convert "$1" -resize "$dim" -background transparent -gravity center -extent "$dim" "$o"
  install -D "$o" "$3"
  rm "$o"
}

makeIcon() {
  local src="$1"
  local app="$2"

  for size in 16 22 24 32 48 64 72 96 128 192 256 512; do
    squareRescale "$src" "$size" "$out/share/icons/hicolor/${size}x${size}/apps/$app.png"
  done

  squareRescale "$src" 512 "$out/share/pixmaps/$app.png"
}

# if [ ! -z "$out" ]; then
#   out="$3"
# fi

makeIcon "$@"
