#!/bin/bash

rm -rf /home/vagrant/binutils-2.17+os161-2.0.1
rm -rf /home/vagrant/gcc-4.1.2+os161-2.0
rm -rf /home/vagrant/gdb-6.6+os161-2.0
rm -rf /home/vagrant/sys161-1.99.06/
rm -rf /home/vagrant/mk
rm -rf /home/vagrant/bmake

rm -rf /vagrant/os161-1.99
rm -rf /vagrant/cs350-os161/os161.tar.gz
rm -f /vagrant/*.*~
rm -f /vagrant/Vagrantfile~

apt-get clean
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
cat /dev/null > ~/.bash_history && history -c
