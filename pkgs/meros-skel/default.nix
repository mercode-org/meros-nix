{ fetchFromGitHub,
  stdenv
}:

stdenv.mkDerivation rec {
  pname = "papirus-mer-icon-theme";
  version = "0.0.1";

  src = ./skel;

  installPhase = ''
    cp -rp $PWD $out
  '';
}
