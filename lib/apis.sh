#!/bin/bash

set -euo pipefail

urlencode() {
    # urlencode <string>
    old_lc_collate=${LC_COLLATE:C}
    LC_COLLATE=C

    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf "$c" ;;
            *) printf '%%%02X' "'$c" ;;
        esac
    done

    LC_COLLATE=$old_lc_collate
}

urldecode() {
    # urldecode <string>

    local url_encoded="${1//+/ }"
    printf '%b' "${url_encoded//%/\\x}"
}

log() {
  echo " => $*"
}

H_BASE="https://hercules-ci.com/api/v1"

get_h_jobs() {
  JOBS_JSON=$(curl -s "$H_BASE/jobs?site=github&account=mercode-org&project=meros-nix&latest=100")
  ACCOUNT_ID=$(echo "$JOBS_JSON" | jq -r ".[0].project.ownerId")
}

get_h_last_success() {
  BRANCH="$1"

  LAST_SUCCESS=$(echo "$JOBS_JSON" | jq ".[0].jobs[] | select(.derivationStatus == \"Success\") | select(.source.ref == \"refs/heads/$BRANCH\")" | jq -s ".[0]")
  LAST_SUCCESS_ID=$(echo "$LAST_SUCCESS" | jq -r ".id")

  START_TIME=$(echo "$LAST_SUCCESS" | jq -r ".startTime")
  REV=$(echo "$LAST_SUCCESS" | jq -r ".source.revision")
}

get_h_output_for_success() {
  DRV_PATH="$1"
  DERIVATION_PATH=$(curl -s "$H_BASE/jobs/$LAST_SUCCESS_ID/evaluation" | jq -r ".attributes[] | select(.path[0] == \"$DRV_PATH\") | .value.Ok.derivationPath")

  ENCODED=$(urlencode "$DERIVATION_PATH")
  OUT_PATH=${2:"out"}
  OUT_PATH=$(curl -s "$H_BASE/accounts/$ACCOUNT_ID/derivations/$ENCODED" | jq -r ".outputs[] | select(.outputName == \"$OUT_PATH\") | .outputPath")
}

get_c_drv_info_from_drv() {
  ID=$(echo "$1" | sed -r "s|.+store/([a-z0-9]+)-.+|\1|g")
  NARINFO=$(curl -s "$CACHE/$ID.narinfo")
  URL=$(echo "$NARINFO" | grep "^URL:" | sed "s|^URL: ||g")
  FULL_URL="$CACHE/$URL"
}

get_c_drv() {
  log "Pulling $1..."
  drvInfo "$1"
  wget -O "$2.xz" "$FULL_URL"
  xz -d "$2.xz"
}
