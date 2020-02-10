#!/bin/bash

set -euo pipefail

source apis.sh
source cron-dev-config.sh

do_update_script() {
  git pull
  UPDATE_SCRIPT=false bash "$0"
  exit 0
}

do_build() {
  RESULT_FOLDER="$OUT_FOLDER/.links/$3"
  mkdir -p "$RESULT_FOLDER"
  cd "$RESULT_FOLDER"
  RESULT="$RESULT_FOLDER/result"
  nix-build "$1" -A "$2" -j auto
}

do_cron() {
  branch="$1"
  out_name="$2"
  out_folder="$OUT_FOLDER/$out_name"

  echo
  log "Doing cron for branch $branch:"
  log " - Input: latest successfull CI build for $branch"
  log " - Output: channel $out_name, isos"
  echo

  log "Getting job info..."
  get_h_jobs
  get_h_last_success "$branch"

  REV=$(echo "$LAST_SUCCESS" | jq -r ".source.revision")

  log "Fetching revision $REV..."

  G="$TMP/$REV.$BRANCH"
  git clone --reference "$GIT_REF" https://github.com/mercode-org/meros-nix "$G"
  pushd "$G"
  git -c advice.detachedHead=false checkout "$REV"
  git rev-parse --verify HEAD > .ref

  NIX_FILE="$G/release.nix"
  mkdir -p "$out_folder"

  log "Building isos..."
  do_build "$NIX_FILE" isoAll "$out_name-iso"
  ln -vsf "$RESULT" "$out_folder/iso"

  log "Building channels..."
  do_build "$NIX_FILE" allChannels "$out_name-channels"
  ln -vsf "$RESULT"/* "$out_folder"
  popd

  log "All done!"
}

if $UPDATE_SCRIPT; then
  do_update_script
fi

GIT_REF=$(echo "$(dirname "$(dirname "$(readlink -f "$0")")")/.git")

log "Output $OUT_FOLDER"
TMP=$(mktemp -d)
log "tmp $TMP"
cd "$TMP"

do_cron master dev
