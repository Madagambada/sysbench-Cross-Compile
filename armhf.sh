#!/bin/bash

dpkg --add-architecture armhf
apt update
apt -y install make crossbuild-essential-armhf git automake libtool pkg-config libaio-dev:armhf libluajit-5.1-dev:armhf -y

git clone https://github.com/akopytov/sysbench.git
cd sysbench
git checkout $(git tag | sort -V | tail -1)

./autogen.sh
./configure CFLAGS="-static -m32" LDFLAGS="-static" --host=arm-linux-gnueabihf --with-system-luajit --without-mysql
make -j$(nproc)

mv src/sysbench ../sysbench-linux-armhf
rm -r ../sysbench
