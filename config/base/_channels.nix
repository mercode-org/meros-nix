{ config, pkgs, lib, ... }:

with lib;

{
  options = {
    channels = mkOption {
      type = types.lines;
      description = "Initial channels for nixos (format: '<url> <name>')";
    };
  };

  system.activationScripts.applyChannels = stringAfter [ "etc" "users" ]
  ''
    # Subscribe the root user to the NixOS channels
    if [ ! -e "/root/.nix-channels" ]; then
        echo ${escapeShellArg config.channels} > "/root/.nix-channels"
    fi
  '';
}
