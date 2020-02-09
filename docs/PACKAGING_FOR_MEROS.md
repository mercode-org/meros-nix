# Packaging for MerOS

_Mostly for internal usage_

# Packaging checklist for merOS

## node & electron apps

- [ ] package-lock.json to pull in external dependencies
- [ ] a list of all other dependencies (except electron) that are needed, such as things that the module would normally download after installation
- [ ] name, description, license, supported platforms

_If your app is not using any node or electron specific APIs, then please consider using webkit2-launcher instead of electron_

## General apps

- [ ] a list of all dependencies that need to be included, either during build or runtime
- [ ] name, description, license, supported platforms

# Packaging an application

- Is the source code hosted or forked in the mercode-org organization?
  - Yes
    - cd pkgs
    - Run update.sh repo-name to initialize a package from the template and pull in the source code
    - Add the repo to the list of repositories in update.sh
  - No
    - Create a package in pkgs/PACKAGE_NAME/
    - Add the command to update it's source to update.sh
- Reference the app in pkgs/default.nix
- Which kind of app is this?
  - NodeJS
    - Look at the conf-tool package as a reference. Mostly you'll need to add "inherit mkNode;" in the pkgs/default.nix and then replace stdenv.mkDerivation with mkNode
  - Electron
    - Look at the distrocards package as a reference. Needs the same things as a nodeJS package and additionally needs the electron wrapping at the end and the desktop file.
  - webkit2-launcher
    - TODO
  - Other
    - Take a look at the nixpkgs manual or ask someone.

---

Afterward create either [an issue](https://github.com/mercode-org/meros-nix/issues/new) with the details from the checklist if you need help with packaging or just create a PR with the package.
