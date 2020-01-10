#!/bin/bash

nix run nixos.nix-prefetch-github -c nix-prefetch-github mkg20001 nixpkgs --rev mkg-patch-a > lib/nixpkgs.json
