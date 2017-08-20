#!/bin/bash

rm -rf /vagrant/binutils-2.17+os161-2.0.1
rm -rf /vagrant/gcc-4.1.2+os161-2.0
rm -rf /vagrant/sys161-1.99.06/
rm -rf /vagrant/mk
rm -rf /vagrant/bmake
rm -rf /vagrant/os161-1.99
rm -rf /vagrant/cs350-os161/os161.tar.gz
rm -f *.*~
rm -f /vagrant/Vagrantfile~

apt-get clean
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
cat /dev/null > ~/.bash_history && history -c
