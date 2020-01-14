{ fetchFromGitHub,
  stdenv
}:

with (builtins);

let
  srcData = fromJSON (readFile ./source.json);
in
stdenv.mkDerivation rec {
  pname = "meros-linux-tune";
  version = "0.0.1";

  src = fetchFromGitHub {
    repo = pname;
    owner = "mercode-org";
    rev = srcData.rev;
    sha256 = srcData.sha256;
  };

  installPhase = ''
    mkdir -p $out/share/sounds
    cp -rp $PWD $out/share/sounds/meros-tune
  '';
}
