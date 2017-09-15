#!/bin/bash

wget -q http://ftp.gnu.org/gnu/texinfo/texinfo-4.13.tar.gz
gzip -dc < texinfo-4.13.tar.gz | tar -xf -
cd texinfo-4.13

./configure
make
make install

cd ..
rm texinfo-4.13.tar.gz
rm -rf texinfo-4.13
