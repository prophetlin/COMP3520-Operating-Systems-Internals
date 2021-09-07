# Packages include dependencies for building linux
# and also qemu, virtbuilder

FROM fedora:latest
RUN dnf -y update && dnf install -y\
	gcc clang make binutils flex bison util-linux kmod\
	e2fsprogs jfsutils reiserfs-utils xfsprogs squashfs-tools\
	btrfs-progs pcmciautils quota ppp nfs-utils\
	procps udev mcelog iptables openssl bc\
	python-sphinx \
	qemu libguestfs-tools-c tmux vim git zsh\
	python3 bcc cpio strace ltrace glibc-static
