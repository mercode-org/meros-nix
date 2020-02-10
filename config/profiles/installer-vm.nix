{ config, pkgs, lib, ... }:

with lib;

{
  imports = [
    "${import ../../lib/nixpkgs.nix}/nixos/modules/profiles/installation-device.nix"
    ./installer.nix
    ./vm.nix
  ];

  services.mingetty.autologinUser = mkForce "meros";

  virtualisation.qemu.networkingOptions = [
    "-hda $(readlink -f \${INSTALL_DISK_IMAGE:-$(dirname $NIX_DISK_IMAGE)/install.img})"
  ];

  environment.systemPackage = [
    (pkgs.writeShellScriptBin "quick-install-vm" (builtins.readFile ./quick-install-vm.sh))
  ];
}
