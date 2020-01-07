{ owner, repo, rev, name ? "source"
, fetchSubmodules ? false, private ? false
, githubBase ? "github.com", varPrefix ? null
, ... # For hash agility
}@args: assert private -> !fetchSubmodules;
  builtins.fetchTarball {
    inherit (args) sha256;
    url = "https://${githubBase}/${owner}/${repo}/archive/${rev}.tar.gz";
  }
