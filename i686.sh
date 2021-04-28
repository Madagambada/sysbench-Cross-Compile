#!/bin/bash

dpkg --add-architecture i386
apt update
apt -y install make crossbuild-essential-i386 git automake libtool pkg-config libaio-dev:i386 libluajit-5.1-dev:i386 -y

git clone https://github.com/akopytov/sysbench.git
cd sysbench
git checkout $(git tag | sort -V | tail -1)

./autogen.sh
./configure CFLAGS="-static -m32" LDFLAGS="-static" --host=i686-linux-gnu --with-system-luajit --without-mysql
make -j$(nproc)
