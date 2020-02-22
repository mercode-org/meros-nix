#!/bin/bash

nix run nixos.nix-prefetch-github -c nix-prefetch-github mkg20001 nixpkgs --rev mkg-patch-a > lib/nixpkgs.json
nix run nixos.nix-prefetch-github -c nix-prefetch-github mkg20001 nix-node-package --rev master > lib/nix-node-package.json
nix run nixos.nix-prefetch-github -c nix-prefetch-github nixos nixos-hardware --rev master > lib/nixos-hardware.json
