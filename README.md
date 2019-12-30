# MerOS - Nix
Meros Nix Channel / NixOS Distro Base Config

##Install Nix on your running system
```
curl https://nixos.org/nix/install | sh
```

##Generate an iso
```
nix-build -A iso
```

##Open in built-in WM (QEMU)
```
make start-vm
```
