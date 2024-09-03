#!/bin/sh
set -e

# 关闭内核随机地址，
cd linux
cp ../config .config
make -j$(($(nproc) - 1))
cd -
