
.PHONY: update build-all-iso
update:
	bash update.sh
	make -C pkgs update
build-all-iso:
	nix-build release.nix -A isoAll -j auto
rebuild-makefile: Makefile.template
	node ./lib/buildMakefile.js ./Makefile.template ./Makefile cinnamon lxde mate xfce
install.img:
	qemu-img create install.img 6G
channels:
	git rev-parse --verify HEAD > .ref
	nix-build release.nix -A allChannels
clean:
	rm -f *.qcow2 *.img


.PHONY: build-vm-cinnamon start-vm-cinnamon
build-vm-cinnamon:
	nix-build release.nix -A cinnamon.vm -j auto -Q
start-vm-cinnamon: build-vm-cinnamon
	nix -j auto run -f release.nix cinnamon.vm -c run-nixos-vm

.PHONY: build-installer-vm-cinnamon start-installer-vm-cinnamon
build-installer-vm-cinnamon:
	nix-build release.nix -A cinnamon.installerVm -j auto -Q
start-installer-vm-cinnamon: build-installer-vm-cinnamon install.img
	nix -j auto run -f release.nix cinnamon.installerVm -c run-nixos-vm


.PHONY: build-iso-cinnamon start-iso-cinnamon
build-iso-cinnamon:
	nix-build release.nix -A cinnamon.iso -j auto
start-iso-cinnamon: build-iso-cinnamon install.img
	qemu-system-x86_64 -cdrom result/iso/* -hda install.img -m 2048 -enable-kvm -cpu max -smp 5


.PHONY: build-vm-lxde start-vm-lxde
build-vm-lxde:
	nix-build release.nix -A lxde.vm -j auto -Q
start-vm-lxde: build-vm-lxde
	nix -j auto run -f release.nix lxde.vm -c run-nixos-vm

.PHONY: build-installer-vm-lxde start-installer-vm-lxde
build-installer-vm-lxde:
	nix-build release.nix -A lxde.installerVm -j auto -Q
start-installer-vm-lxde: build-installer-vm-lxde install.img
	nix -j auto run -f release.nix lxde.installerVm -c run-nixos-vm


.PHONY: build-iso-lxde start-iso-lxde
build-iso-lxde:
	nix-build release.nix -A lxde.iso -j auto
start-iso-lxde: build-iso-lxde install.img
	qemu-system-x86_64 -cdrom result/iso/* -hda install.img -m 2048 -enable-kvm -cpu max -smp 5


.PHONY: build-vm-mate start-vm-mate
build-vm-mate:
	nix-build release.nix -A mate.vm -j auto -Q
start-vm-mate: build-vm-mate
	nix -j auto run -f release.nix mate.vm -c run-nixos-vm

.PHONY: build-installer-vm-mate start-installer-vm-mate
build-installer-vm-mate:
	nix-build release.nix -A mate.installerVm -j auto -Q
start-installer-vm-mate: build-installer-vm-mate install.img
	nix -j auto run -f release.nix mate.installerVm -c run-nixos-vm


.PHONY: build-iso-mate start-iso-mate
build-iso-mate:
	nix-build release.nix -A mate.iso -j auto
start-iso-mate: build-iso-mate install.img
	qemu-system-x86_64 -cdrom result/iso/* -hda install.img -m 2048 -enable-kvm -cpu max -smp 5


.PHONY: build-vm-xfce start-vm-xfce
build-vm-xfce:
	nix-build release.nix -A xfce.vm -j auto -Q
start-vm-xfce: build-vm-xfce
	nix -j auto run -f release.nix xfce.vm -c run-nixos-vm

.PHONY: build-installer-vm-xfce start-installer-vm-xfce
build-installer-vm-xfce:
	nix-build release.nix -A xfce.installerVm -j auto -Q
start-installer-vm-xfce: build-installer-vm-xfce install.img
	nix -j auto run -f release.nix xfce.installerVm -c run-nixos-vm


.PHONY: build-iso-xfce start-iso-xfce
build-iso-xfce:
	nix-build release.nix -A xfce.iso -j auto
start-iso-xfce: build-iso-xfce install.img
	qemu-system-x86_64 -cdrom result/iso/* -hda install.img -m 2048 -enable-kvm -cpu max -smp 5
