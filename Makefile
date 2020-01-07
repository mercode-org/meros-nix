.PHONY: build-iso
build-iso:
	nix-build -j auto -v -A iso

.PHONY: start-vm
start-vm:
	nix -j auto run -f default.nix vm -c run-nixos-vm

.PHONY: start-iso
start-iso: build-iso
	qemu-system-x86_64 -cdrom result/iso/* -m 2048 -enable-kvm -cpu max -smp 5

.PHONY: update
update:
	bash update.sh
	make -C pkgs update
