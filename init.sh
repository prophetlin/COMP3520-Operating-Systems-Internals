#! bin/sh

echo "Running init"
echo "Setting up ttys"
mknod /dev/tty1 c 4 1
mknod /dev/tty2 c 4 2
mknod /dev/tty3 c 4 3
mknod /dev/tty4 c 4 4

mount -t proc none /proc
mount -t sysfs none /sys

echo "Execing into a shell" 
exec /bin/sh
