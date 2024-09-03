
1. 关闭随机地址化（KASLR），否则会 gdb 断点无法命中。
Symbol: RANDOMIZE_BASE [=n]
Type  : bool
Defined at arch/x86/Kconfig:2184
  Prompt: Randomize the address of the kernel image (KASLR)
    Depends on: RELOCATABLE [=y]
      Location:
          -> Processor type and features
                -> Build a relocatable kernel (RELOCATABLE [=y])
    (3)     -> Randomize the address of the kernel image (KASLR) (RANDOMIZE_BASE [=n])

2. 添加调试符号信息
Kernel hacking  --->
  Compile-time checks and compiler options  --->
    Debug information
      Rely on the toolchain's implicit default DWARF version
