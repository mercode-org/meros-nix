#!/bin/bash

set -euo pipefail

git fetch origin
BRANCH=$(date +%d%m%y)
BRANCH="up$BRANCH"
git checkout -b "$BRANCH"
git reset --hard origin/master
git clean -dxf

export GIT_SSH_COMMAND="ssh -i $PRIV_KEY"
make update
git add .
git commit -m "chore: update stuff"
git push -u origin "$BRANCH"
