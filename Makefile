
.PHONY: update build-all-iso
update:
	bash update.sh
	make -C pkgs update
build-all-iso:
	nix-build -A isoAll -j auto
rebuild-makefile: Makefile.template
	node ./lib/buildMakefile.js ./Makefile.template ./Makefile cinnamon lxde mate xfce
install.img:
	qemu-img create install.img 2G
channels:
	git rev-parse --verify HEAD > .ref
	nix-build -A allChannels


.PHONY: build-vm-cinnamon start-vm-cinnamon
build-vm-cinnamon:
	nix-build -A cinnamon.vm -j auto -Q
start-vm-cinnamon: build-vm-cinnamon
	nix -j auto run -f default.nix cinnamon.vm -c run-nixos-vm

.PHONY: build-installer-vm-cinnamon start-installer-vm-cinnamon
build-installer-vm-cinnamon:
	nix-build -A cinnamon.installerVm -j auto -Q
start-installer-vm-cinnamon: build-installer-vm-cinnamon install.img
	nix -j auto run -f default.nix cinnamon.installerVm -c run-nixos-vm


.PHONY: build-iso-cinnamon start-iso-cinnamon
build-iso-cinnamon:
	nix-build -A cinnamon.iso -j auto
start-iso-cinnamon: build-iso-cinnamon install.img
	qemu-system-x86_64 -cdrom result/iso/* -hda install.img -m 2048 -enable-kvm -cpu max -smp 5


.PHONY: build-vm-lxde start-vm-lxde
build-vm-lxde:
	nix-build -A lxde.vm -j auto -Q
start-vm-lxde: build-vm-lxde
	nix -j auto run -f default.nix lxde.vm -c run-nixos-vm

.PHONY: build-installer-vm-lxde start-installer-vm-lxde
build-installer-vm-lxde:
	nix-build -A lxde.installerVm -j auto -Q
start-installer-vm-lxde: build-installer-vm-lxde install.img
	nix -j auto run -f default.nix lxde.installerVm -c run-nixos-vm


.PHONY: build-iso-lxde start-iso-lxde
build-iso-lxde:
	nix-build -A lxde.iso -j auto
start-iso-lxde: build-iso-lxde install.img
	qemu-system-x86_64 -cdrom result/iso/* -hda install.img -m 2048 -enable-kvm -cpu max -smp 5


.PHONY: build-vm-mate start-vm-mate
build-vm-mate:
	nix-build -A mate.vm -j auto -Q
start-vm-mate: build-vm-mate
	nix -j auto run -f default.nix mate.vm -c run-nixos-vm

.PHONY: build-installer-vm-mate start-installer-vm-mate
build-installer-vm-mate:
	nix-build -A mate.installerVm -j auto -Q
start-installer-vm-mate: build-installer-vm-mate install.img
	nix -j auto run -f default.nix mate.installerVm -c run-nixos-vm


.PHONY: build-iso-mate start-iso-mate
build-iso-mate:
	nix-build -A mate.iso -j auto
start-iso-mate: build-iso-mate install.img
	qemu-system-x86_64 -cdrom result/iso/* -hda install.img -m 2048 -enable-kvm -cpu max -smp 5


.PHONY: build-vm-xfce start-vm-xfce
build-vm-xfce:
	nix-build -A xfce.vm -j auto -Q
start-vm-xfce: build-vm-xfce
	nix -j auto run -f default.nix xfce.vm -c run-nixos-vm

.PHONY: build-installer-vm-xfce start-installer-vm-xfce
build-installer-vm-xfce:
	nix-build -A xfce.installerVm -j auto -Q
start-installer-vm-xfce: build-installer-vm-xfce install.img
	nix -j auto run -f default.nix xfce.installerVm -c run-nixos-vm


.PHONY: build-iso-xfce start-iso-xfce
build-iso-xfce:
	nix-build -A xfce.iso -j auto
start-iso-xfce: build-iso-xfce install.img
	qemu-system-x86_64 -cdrom result/iso/* -hda install.img -m 2048 -enable-kvm -cpu max -smp 5
