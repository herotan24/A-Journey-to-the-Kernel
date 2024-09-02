#!/bin/sh
set -xe

cp config ./busybox/.config
cd ./busybox
make clean
make -j$(($(nproc) - 2))
make install
cd -
touch ./_install/init
echo -e "#!/bin/sh\nmount -t proc none /proc\nmount -t sysfs none /sys\nexec /bin/sh" > ./_install/init
chmod +x ./_install/init

dd if=/dev/zero of=busybox-rootfs.ext4 bs=1M count=32
mkfs.ext4 busybox-rootfs.ext4

sudo mkdir -p /mnt/busybox

sudo mount busybox-rootfs.ext4 /mnt/busybox
sudo cp -Rf ./_install/* /mnt/busybox/
sudo mkdir -p /mnt/busybox/dev
sudo mknod /mnt/busybox/dev/console c 5 1
sudo mknod /mnt/busybox/dev/null c 1 3

sudo umount /mnt/busybox
