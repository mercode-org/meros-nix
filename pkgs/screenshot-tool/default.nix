{ stdenv
, imagemagick
, xvfb_run
, writeShellScriptBin
, xorg
}:

let
  writeShellScriptBinPath = name : deps : text :
  writeShellScriptBin name ''
    export PATH="${stdenv.lib.makeBinPath deps}:$PATH"

    ${text}
    '';
in
  writeShellScriptBinPath "screenshot-tool" [ imagemagick xvfb_run xorg.xwininfo ] (builtins.readFile ./screenshot-tool.sh)
