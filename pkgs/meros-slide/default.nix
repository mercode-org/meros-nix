{ fetchFromGitHub
, stdenv
, perlPackages
}:

with (builtins);

let
  srcData = fromJSON (readFile ./source.json);
in
stdenv.mkDerivation rec {
  pname = "meros-slide";
  version = "0.0.1";

  src = fetchFromGitHub {
    repo = pname;
    owner = "mercode-org";
    rev = srcData.rev;
    sha256 = srcData.sha256;
  };

  nativeBuildInputs = [
    perlPackages.Po4a
  ];

  dontBuild = true;

  # installTargets = "meros";

  installPhase = ''
    mkdir $out
    cp -rp build/meros/* $out/
  '';
}
