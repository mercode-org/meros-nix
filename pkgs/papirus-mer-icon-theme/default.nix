{ fetchFromGitHub,
  stdenv
}:

with (builtins);

let
  srcData = fromJSON (readFile ./source.json);
in
stdenv.mkDerivation rec {
  pname = "papirus-mer-icon-theme";
  version = "0.0.1";

  src = fetchFromGitHub {
    repo = pname;
    owner = "mercode-org";
    rev = srcData.rev;
    sha256 = srcData.sha256;
  };

  installPhase = ''
    mkdir -p $out/share/icons
    cp -rp $PWD/papirus-mer $out/share/icons/papirus-mer
  '';
}
