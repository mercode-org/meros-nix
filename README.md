# MerOS - Nix
Meros Nix Channel / NixOS Distro Base Config

# Usage

This config is mainly used by meros images and will later be provided to users as a nix channel

# Building the ISO / Running the VM

Replace `DE` with either xfce, mate or cinnamon

## Install Nix on your running system

```
curl https://nixos.org/nix/install | sh
```

## Switch to nix unstable channel

```
nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --update
```

## Enable the meros cache

```
nix-env -iA cachix -f https://cachix.org/api/v1/install
cachix use meros
```

## Start a VM with qemu

```
make start-vm-DE
```

## Build the ISO

```
make build-iso-DE
```

### Start the ISO

```
make start-iso-DE
```
