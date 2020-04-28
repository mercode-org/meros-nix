{ fetchFromGitHub
, stdenv
, meros-skel-base
}:

stdenv.mkDerivation rec {
  pname = "meros-skel-cinnamon";
  version = "0.0.1";

  src = ./skel;

  installPhase = ''
    mkdir -p $out
    find $PWD ${meros-skel-base} -maxdepth 1 -mindepth 1 -exec cp -r {} $out \;
  '';
}
