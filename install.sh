#!/bin/bash

version=1.1.0

echo "[01/??] Download source code"

fetch https://github.com/viastolfi/blw/archive/refs/tags/v$version.tar.gz

echo "[02/??] Extract source code"

tar -xzf v$version.tar.gz

echo "[03/??] Build blw program"

make -C blw-$version

echo "[04/??] Move programs executable and config file"

ls ~/.local/bin > /dev/null
if [ $? != 0 ]; then
  mkdir ~/.local/bin
fi

mv blw-$version/build/blw ~/.local/bin/blw

ls ~/.local/lib > /dev/null

if [ $? != 0 ];then
  mkdir ~/.local/lib
fi

mv blw-$version/blw.sh ~/.local/lib/blw.sh

ls ~/.local/state > /dev/null

if [ $? != 0 ];then
  mkdir ~/.local/state
fi

mkdir ~/.local/state/blw

echo "[05/??] Init blw setup"

./blw-$version/setup.sh

echo "[06/??] Cleanup"

rm -rf blw-$version v$version.tar.gz install.sh
