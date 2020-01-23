{ fetchFromGitHub
, stdenv
}:

stdenv.mkDerivation rec {
  pname = "meros-skel-lxde";
  version = "0.0.1";

  src = ./skel;

  installPhase = ''
    cp -rp $PWD $out
  '';
}
