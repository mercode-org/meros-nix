{ fetchFromGitHub
, callPackage
}:

with (builtins);

let
  srcData = fromJSON (readFile ./source.json);
  src = fetchFromGitHub {
    repo = "webkit2-launcher";
    owner = "mercode-org";
    rev = srcData.rev;
    sha256 = srcData.sha256;
  };
in
callPackage "${src}/release.nix" { }
