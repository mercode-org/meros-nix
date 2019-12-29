build-iso:
	nix-build -j auto -v -A iso
start-vm:
	nix -j auto run -f default.nix vm -c run-nixos-vm
start-iso: build-iso
	qemu-system-x86_64 -cdrom result/iso/* -m 2048 -enable-kvm -cpu max -smp 5
