#!/bin/sh

# nokaslr: no kernel address space randomization，调试需要用，否则不能命中断点；也可以在内核编译的时候加上这个参数
# -s: gdb server, port 1234
# -S: stop at entry point

qemu-system-x86_64 \
        -kernel `pwd`/kernel/linux/arch/x86/boot/bzImage \
        -hda `pwd`/rootfs/busybox-rootfs.ext4 \
        -append "root=/dev/sda console=ttyS0 nokaslr" \
        -nographic \
        -s -S
