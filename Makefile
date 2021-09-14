CC := gcc

.PHONY: all clean help

LINUX := linux-5.10.62
BUSYBOX := busybox-1.33.1
BUILD := build
BUSYBOX_INITRAMFS := $(BUILD)/busybox_initramfs

.PHONY: clean initramfs qemu-busybox qemu-busybox-debug

all: qemu-busybox

init: busybox initramfs linux
	touch .inited

busybox:
	mkdir -p $(BUSYBOX_INITRAMFS)
	mkdir -p $(BUSYBOX_INITRAMFS)/bin
	mkdir -p $(BUSYBOX_INITRAMFS)/dev
	mkdir -p $(BUSYBOX_INITRAMFS)/etc
	mkdir -p $(BUSYBOX_INITRAMFS)/proc
	$(MAKE) -C $(BUSYBOX) CFLAGS=--static -j`nproc`
	$(MAKE) -C $(BUSYBOX) CFLAGS=--static CONFIG_PREFIX=$(PWD)/$(BUSYBOX_INITRAMFS) install

initramfs: init.sh
	cp $^ $(BUSYBOX_INITRAMFS)/init
	rm -rf $(BUSYBOX_INITRAMFS)/test_progs
	cp -r test_progs/ $(BUSYBOX_INITRAMFS)/test_progs
	(cd $(BUSYBOX_INITRAMFS) && `find . | cpio -o -H newc | gzip > ../busybox_initramfs.cpio.gz`)

linux:
	mkdir -p build
	$(MAKE) -C $(LINUX)  -j`nproc`
	mv $(LINUX)/arch/x86/boot/bzImage build

qemu-busybox: linux initramfs .inited
	(cd build && qemu-system-x86_64 -kernel bzImage -initrd busybox_initramfs.cpio.gz -append "init=/bin/sh console=ttyS0" -nographic)

qemu-busybox-debug: linux initramfs .inited
	(cd build && qemu-system-x86_64 -kernel bzImage -initrd busybox_initramfs.cpio.gz -append "init=/bin/sh nokaslr console=ttyS0" -nographic -s -S)

qemu-fed: fedora34.qcow2
	qemu-system-x86_64 -m 2G fedora34.qcow2 -nographic --enable-kvm

qemu-fed-custom-kern: linux .inited
	qemu-system-x86_64 -kernel build/bzImage -drive file=fedora34.qcow2,if=virtio -append "root=/dev/vda3 ro console=tty0 rd_NO_PLYMOUTH console=ttyS0,115200" -nographic

help:
	$(info ==========Build things for COMP3520 assignment 1==========)
	$(info init: builds busybox and linux, mainly a check to see if you've configured both of them.)
	$(info linux: runs make in the linux directory, builds the kernel.)
	$(info qemu-busybox: Runs your linux kernel with the the busybox initramfs in qemu.)
	$(info qemu-busybox-deb: Runs your linux kernel with the the busybox initramfs in qemu in a way that it can be debugged easily by gdb.)
	$(info qemu-fed: Runs the fedora image in qemu, uses it's own kernel.)
	$(info qemu-fed-custom-kern: Runs the fedora image in qemu, using your kernel.)
	$(info clean: Deletes the build directory. Before rebuilding, you may have to run make busybox/make init again.)
	$(info ==========================================================")

clean:
	make -C $(BUSYBOX) clean
	make -C $(LINUX) clean
	rm -rf $(BUILD)
	rm -f .inited
