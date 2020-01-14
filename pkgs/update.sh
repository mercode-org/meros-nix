#!/bin/bash

if [ -z "$1" ]; then
  repos="mercode-jbrawn mercode-bazik mer-os-backgrounds papirus-mer-icon-theme merculator meros-welcome-legacy distrocards dwarfs2019 nixiquity meros-linux-tune"
else
  repos="$*"
fi

for repo in $repos; do
  if [ ! -d "$repo" ]; then
    mkdir "$repo"
    cat template.nix | sed "s|NAME|$repo|g" > "$repo/default.nix"
  fi
  nix-prefetch-git "https://github.com/mercode-org/$repo" > "$repo/source.json"
done
