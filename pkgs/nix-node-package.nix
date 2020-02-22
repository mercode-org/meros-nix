{ fetchFromGitHub
, stdenv
}:

with (builtins);

let
  srcData = fromJSON (readFile ../lib/nix-node-package.json);
in
stdenv.mkDerivation rec {
  pname = "nix-node-package";
  version = "0.0.1";

  src = fetchFromGitHub {
    repo = pname;
    owner = "mkg20001";
    rev = srcData.rev;
    sha256 = srcData.sha256;
  };

  dontConfigure = true;
  dontBuild = true;
  dontFixup = true;

  installPhase = ''
    mkdir -p $out/bin
    cp -rp $PWD/nix $out
    # stubs being stubs...
    ln -s $out/nix $out/bin/nix-node-package
  '';
}
