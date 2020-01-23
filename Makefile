.PHONY: build-iso
build-iso:
	nix-build -j auto -v -A iso

.PHONY: start-vm-mate
start-vm-mate:
	nix -j auto run -f default.nix mate.vm -c run-nixos-vm

.PHONY: start-vm-xfce
start-vm-xfce:
	nix -j auto run -f default.nix xfce.vm -c run-nixos-vm

.PHONY: start-vm-cinnamon
start-vm-cinnamon:
	nix -j auto run -f default.nix cinnamon.vm -c run-nixos-vm

.PHONY: start-vm-lxde
start-vm-lxde:
	nix -j auto run -f default.nix lxde.vm -c run-nixos-vm

.PHONY: start-iso
start-iso: build-iso
	qemu-system-x86_64 -cdrom result/iso/* -m 2048 -enable-kvm -cpu max -smp 5

.PHONY: update
update:
	bash update.sh
	make -C pkgs update
