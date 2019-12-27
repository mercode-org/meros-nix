build-iso:
	nix-build -j auto -v iso
start-vm:
	nix -j auto run -f default.nix vm -c run-nixos-vm
