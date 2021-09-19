#! bin/sh
echo "Running init"
echo "Setting up ttys"

# Creates tty
mknod /dev/tty1 c 4 1
mknod /dev/tty2 c 4 2
mknod /dev/tty3 c 4 3
mknod /dev/tty4 c 4 4

# Open serial file
mknod -m 666 /dev/ttyS0 c 4 64

# Creates /dev/null
mknod /dev/null c 1 3
chmod 666 /dev/null

# mount proc/sysfs
mount -t proc none /proc

echo "Execing into a shell" 
setsid cttyhack sh
