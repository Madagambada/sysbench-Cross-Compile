#!/bin/bash

cat <<EOF >backport.list
deb http://deb.debian.org/debian buster-backports main
EOF
mv backport.list /etc/apt/sources.list.d/

dpkg --add-architecture armhf
apt update
apt -y install make crossbuild-essential-armhf git automake libtool pkg-config libaio-dev:armhf libck-dev:armhf libluajit-5.1-dev:armhf -y

git clone https://github.com/akopytov/sysbench.git
cd sysbench
git checkout $(git tag | sort -V | tail -1)

sudo rm /usr/lib/arm-linux-gnueabihf/libluajit-5.1.s*
./autogen.sh
./configure CFLAGS="-static" LDFLAGS="-static" --host=arm-linux-gnueabihf --with-system-luajit --with-system-ck --without-mysql
make -j$(nproc)

mv src/sysbench ../sysbench-linux-armhf
rm -r ../sysbench
