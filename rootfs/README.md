使用 BusyBox 来制作一个简单的根文件系统

make defconfig
make menuconfig  # Go to 'Settings' -> 'Build static binary (no shared libs)'

make -j$(nproc)
make install
这会在 ./_install 目录下生成一个包含所有 BusyBox 工具的根文件系统结构。

创建根文件系统镜像: 创建一个新的文件系统镜像文件.
dd if=/dev/zero of=busybox-rootfs.ext4 bs=1M count=32
mkfs.ext4 busybox-rootfs.ext4

挂载这个镜像文件并复制 BusyBox 文件系统：
mkdir /mnt/busybox
sudo mount busybox-rootfs.ext4 /mnt/busybox
cp -R ./_install/* /mnt/busybox/

添加必要的设备节点和初始化脚本：
sudo mkdir -p /mnt/busybox/dev
sudo mknod /mnt/busybox/dev/console c 5 1
sudo mknod /mnt/busybox/dev/null c 1 3
echo -e "#!/bin/sh\nmount -t proc none /proc\nmount -t sysfs none /sys\nexec /bin/sh" > /mnt/busybox/init
chmod +x /mnt/busybox/init

卸载镜像：
sudo umount /mnt/busybox
