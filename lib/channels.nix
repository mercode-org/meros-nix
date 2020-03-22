{ stdenv
, fetchFromGitHub
, lib
}:

with lib;

let
  deterTar = ''

    function deterTar() { # --mode used to be set here, but fucks shit up because dirs need +x to be read
      find "$1" -print0 \
        | sort -z \
        | tar -cf "$2" \
          --format=posix \
          --numeric-owner \
          --owner=0 \
          --group=0 \
          --mtime='1970-01-01' \
          --no-recursion \
          --null \
          --xz \
          --verbose \
          "--exclude=$2" \
          --files-from -
    }

  '';
in
{
  createChannel =
    { channelName
    , binaryCache
    , binaryCacheUrl ? "https://${binaryCache}"

    , ghSrc ? null
    , gitRevision ? ghSrc.rev
    , src ? (fetchFromGitHub ghSrc)

    , artifactName ? "${channelName}-${gitRevision}"
    , postCmd ? ""
    }:

    stdenv.mkDerivation {
      pname = channelName;
      version = gitRevision;

      inherit src;

      buildPhase = ''
        echo ${gitRevision} > .git-revision
      '';

      installPhase = ''
        ${deterTar}
        mkdir -p $out/${channelName}
        echo ${binaryCacheUrl} > $out/${channelName}/binary-cache-url
        echo ${gitRevision} > $out/${channelName}/git-revision
        ${postCmd}
        mv $PWD /tmp/${artifactName}
        cd /tmp
        deterTar ${artifactName} $out/${channelName}/nixexprs.tar.xz
      '';
    };

  createMergedOutput = channelList:
    stdenv.mkDerivation {
      name = "channels-merged";

      dontUnpack = true;

      installPhase = ''
        mkdir -p $out
        ${builtins.concatStringsSep "\n"
          (forEach channelList (out: "cp -rp ${out}/* $out"))}
      '';
    };
}
