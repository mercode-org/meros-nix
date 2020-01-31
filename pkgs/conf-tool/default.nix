{ fetchFromGitHub
, stdenv
, mkNode
, nodejs-12_x
, makeWrapper
}:

with (builtins);

let
  srcData = fromJSON (readFile ./source.json);
  name = "conf-tool";
  src = fetchFromGitHub {
    repo = name;
    owner = "mercode-org";
    rev = srcData.rev;
    sha256 = srcData.sha256;
  };
in
mkNode { root = src; nodejs = nodejs-12_x; } rec {
  pname = name;

  nativeBuildInputs = [
    makeWrapper
  ];

  buildPhase = ''
    # BANG="#!${nodejs-12_x}/bin/node"
    # sed "s&oclif-dev manifest&sed 's|^#!.*|$BANG|g' -i node_modules/.bin/oclif-dev ; cd node_modules/@oclif/dev-cli ; oclif-dev manifest&g" -i package.json
    # export HOME=/tmp
    # export DEBUG=*
    sed "s|oclif-dev|true|g" -i package.json
  '';

  installPhase = ''
    wrapProgram "$out/bin/conf" \
      --suffix PATH : "/run/current-system/sw/bin" # to get access to the nixos-* tools
  '';

  meta = with stdenv.lib; {
    description = "Tool to manage the nixOS config";
    homepage = https://github.com/mercode-org/conf-tool;
    # license = licenses.mpl2;
    maintainers = with maintainers; [ mkg20001 ];
  };
}
