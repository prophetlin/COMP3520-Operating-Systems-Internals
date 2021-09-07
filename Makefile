CC := gcc

.PHONY: build

LINUX := linux-5.10.62
BUSYBOX := busybox-1.33.1
BUILD := build
BUSYBOX_INITRAMFS := $(BUILD)/busybox_initramfs

all: qemu-busybox

init: busybox linux
	touch .inited

busybox: init.sh
	mkdir -p $(BUSYBOX_INITRAMFS)
	mkdir -p $(BUSYBOX_INITRAMFS)/bin
	mkdir -p $(BUSYBOX_INITRAMFS)/dev
	mkdir -p $(BUSYBOX_INITRAMFS)/etc
	mkdir -p $(BUSYBOX_INITRAMFS)/proc
	$(MAKE) -C $(BUSYBOX) CFLAGS=--static -j12
	$(MAKE) -C $(BUSYBOX) CFLAGS=--static CONFIG_PREFIX=$(PWD)/$(BUSYBOX_INITRAMFS) install
	cp $^ $(BUSYBOX_INITRAMFS)/init
	cp -r test_progs $(BUSYBOX_INITRAMFS)/test_progs
	(cd $(BUSYBOX_INITRAMFS) && `find . | cpio -o -H newc | gzip > ../busybox_initramfs.cpio.gz`)

linux:
	mkdir -p build
	$(MAKE) -C $(LINUX)  -j12
	mv $(LINUX)/arch/x86/boot/bzImage build

qemu-busybox: linux .inited
	(cd build && qemu-system-x86_64 -kernel bzImage -initrd busybox_initramfs.cpio.gz -append "init=/bin/sh console=ttyS0" -nographic)

qemu-busybox-debug: linux .inited
	(cd build && qemu-system-x86_64 -kernel bzImage -initrd busybox_initramfs.cpio.gz -append "init=/bin/sh nokaslr console=ttyS0" -nographic -s -S)

clean:
	rm -rf $(BUILD)
	rm .inited
