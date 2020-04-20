#!/bin/bash

set -exo pipefail

input="$1"
id="$2"
path="$3"

glob_copy() {
  DEST="$1"
  while true; do
    shift
    if [ -z "$1" ]; then
      return 0
    fi
    if [ -e "$1" ]; then
      cat "$1" > "$DEST/$(basename $1)"
      return 0
    fi
  done

  return 1
}

mkdir -p "$out"

if [ ! -z "$input/share/applications" ]; then
  echo 1 > "$out/isGui"

  screenshot-tool "$id" "$out/screenshot.png" || /bin/true

  mkdir "$out/icon"
  mkdir "$out/desktop"

  glob_copy "$out/icon" $input/share/icons/hicolor/*/apps/"$id".* || glob_copy "$out/icon" $input/share/icons/hicolor/*/apps/* || true

  glob_copy "$out/desktop" $input/share/applications/"$id".desktop || glob_copy "$out/desktop" $input/share/applications/*.desktop || true
fi

find -type f -exec nuke-refs '{}' \;
