#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <exec> <screenshot>"
  exit 2
fi

set -euxo pipefail

get_window_id() {
  CHILD_AMOUNT=$(xwininfo -tree -root | head -n 6 | tail -n 1)
  if [[ "$CHILD_AMOUNT" == *"0 children."* ]]; then
    echo "No windows found, retrying" >&2
    sleep 1s
    get_window_id
  else
    O=$(xwininfo -tree -root | head -n 7 | tail -n 1)
    set -- $(echo $O)
    echo $1
  fi
}

if [ "$1" = "_" ]; then
  shift
  $1 &
  sleep 5s
  # xwininfo -tree -root
  # $(get_window_id)
  import -window root -pause 0 -delay 0 -quality 90 "$2" # imagemagick screenshot tool (window=root for screen)
else
  TMP=$(mktemp -d)
  env -i LC_ALL=C "HOME=$TMP" "PATH=$PATH" xvfb-run -d --server-args="-screen 0, 1440x810x24" "$0" "_" "$@"
fi
