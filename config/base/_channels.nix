{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.channels;
in
{
  options = {
    channels = {
      links = mkOption {
        type = types.lines;
        description = "Initial channels for nixos (format: '<url> <name>')";
      };

      preload = mkOption {
        type = types.attrsOf types.path;
        description = "Channels to preload";
        default = {};
      };
    };
  };

  config = {
    system.activationScripts.applyChannels = stringAfter [ "etc" "users" ]
    ''
      # Subscribe the root user to the NixOS channels
      if [ ! -e "/root/.nix-channels" ]; then
          echo ${escapeShellArg cfg.links} > "/root/.nix-channels"
      fi
    '';
  } // (mkIf (cfg.preload != {}) {
    boot.postBootCommands = let

    # begin <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>

    nixpkgs = lib.cleanSource pkgs.path;

    # We need a copy of the Nix expressions for Nixpkgs and NixOS on the
    # CD.  These are installed into the "nixos" channel of the root
    # user, as expected by nixos-rebuild/nixos-install. FIXME: merge
    # with make-channel.nix.
    channelSources = pkgs.runCommand "nixos-${config.system.nixos.version}"
      { preferLocalBuild = true; }
      ''
        mkdir -p $out
        cp -prd ${nixpkgs.outPath} $out/nixos
        chmod -R u+w $out/nixos
        if [ ! -e $out/nixos/nixpkgs ]; then
          ln -s . $out/nixos/nixpkgs
        fi
        echo -n ${config.system.nixos.revision} > $out/nixos/.git-revision
        echo -n ${config.system.nixos.versionSuffix} > $out/nixos/.version-suffix
        echo ${config.system.nixos.versionSuffix} | sed -e s/pre// > $out/nixos/svn-revision

        # OUR STUFF
        ${builtins.concatStringsSep "\n" (mapAttrsToList (key: value: "cp -prd ${value} $out/${key}") cfg.preload)}
      '';

      # end
    in
    mkOrder 1700 # after mkAfter :P
      ''
        if ! [ -e /var/lib/nixos/did-channel-init-2 ]; then
          echo "unpacking the NixOS/Nixpkgs sources (meros-preload stage)..."
          ${config.nix.package.out}/bin/nix-env -p /nix/var/nix/profiles/per-user/root/channels \
            -i ${channelSources} --quiet --option build-use-substitutes false
          touch /var/lib/nixos/did-channel-init-2
        fi
      '';
  });
}
