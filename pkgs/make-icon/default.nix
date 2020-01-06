{ stdenv
, imagemagick
, makeWrapper
}:

stdenv.mkDerivation {
  pname = "make-icon";
  version = "1.0.0";

  src = ../../config/empty.tar.gz;

  buildInputs = [
    imagemagick
    makeWrapper
  ];

  installPhase = ''
    install -D ${./make-icon.sh} $out/bin/makeIcon
    wrapProgram $out/bin/makeIcon --prefix PATH : "${imagemagick}/bin"
  '';
}
