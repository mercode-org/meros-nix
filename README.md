# MerOS - Nix
Meros Nix Channel / NixOS Distro Base Config

# Usage

This config is mainly used by meros images and will later be provided to users as a nix channel

# Building the ISO / Running the VM

## Install Nix on your running system

```
curl https://nixos.org/nix/install | sh
```

## Switch to nix unstable channel

```
nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --update
```

## Start a VM with qemu

```
make start-vm
```

## Build the ISO

```
make build-iso
```

### Start the ISO

```
make start-iso
```
