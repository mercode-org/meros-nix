{ nixpkgs, set }:
let
  pkgs = nixpkgs.pkgs;
  lib = nixpkgs.lib;
  screenshot-tool = pkgs.callPackage ../../pkgs/screenshot-tool {};

  nv = name: value: { inherit name value; };

  recurse = path: target:
    let
      keys = builtins.attrNames target;
    in
      (builtins.listToAttrs
        (
          (builtins.concatMap (key:
            let
              _path = path ++ [ key ];
            in
              [ (nv key (process { path = _path; pTarget = target; key = key; })) ]
            ) keys)
          ++
          [ (nv "recurseForDerivations" true) ]
        )
      );

  process = { path, key, pTarget }:
    if (builtins.tryEval ((builtins.getAttr key pTarget) ? "recurseForDerivations")).value then
      recurse path (builtins.getAttr key pTarget)
    else
      let res = (builtins.tryEval (builtins.getAttr key pTarget));
      in if res.success && res.value ? meta then # most likely a valid package
        realProcess path res.value
      else false;

  realProcess = _path: target:
    let
      path = builtins.concatStringsSep "." _path;
      id = builtins.elemAt _path ((builtins.length _path) - 1);
    in
      with pkgs; stdenv.mkDerivation {
        name = "${id}.metadata";

        dontUnpack = true;

        nativeBuildInputs = [
          nukeReferences
          screenshot-tool
          target
        ];

        installPhase = ''
          bash ${./process.sh} ${lib.escapeShellArgs [ target id path ]}
        '';
      };
in
  recurse [] set
