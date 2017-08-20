#!/bin/bash

apt-get update
apt-get install -y emacs git gettext texinfo libncurses5-dev cscope ctags

# binutils
cd /vagrant
curl -S -L -O http://www.student.cs.uwaterloo.ca/~cs350/os161_repository/os161-binutils.tar.gz
tar -xf os161-binutils.tar.gz
rm os161-binutils.tar.gz
cd binutils-2.17+os161-2.0.1
./configure --nfp --disable-werror --target=mips-harvard-os161 --prefix=/vagrant/sys161/tools
make
make install
cd /vagrant
mkdir -p sys161/bin

#env
echo "source /vagrant/export.sh" >> /home/vagrant/.bashrc

# GCC Cross-compiler
curl -S -L -O http://www.student.cs.uwaterloo.ca/~cs350/os161_repository/os161-gcc.tar.gz
tar -xzf os161-gcc.tar.gz
rm os161-gcc.tar.gz
cd gcc-4.1.2+os161-2.0
./configure -nfp --disable-shared --disable-threads --disable-libmudflap --disable-libssp --target=mips-harvard-os161 --prefix=/vagrant/sys161/tools
make
make install 

# GDB
curl -S -L -O http://www.student.cs.uwaterloo.ca/~cs350/os161_repository/os161-gdb.tar.gz
tar -xf os161-gdb.tar.gz
rm os161-gdb.tar.gz
cd gdb-6.6+os161-2.0
./configure --target=mips-harvard-os161 --prefix=/vagrant/sys161/tools --disable-werror 
make
make install
cd ..
pwd
# bmake
curl -S -L -O http://www.student.cs.uwaterloo.ca/~cs350/os161_repository/os161-bmake.tar.gz
curl -S -L -O http://www.student.cs.uwaterloo.ca/~cs350/os161_repository/os161-mk.tar.gz
tar -xzf os161-bmake.tar.gz
rm os161-bmake.tar.gz
cd bmake
tar -xzf ../os161-mk.tar.gz
rm ../os161-mk.tar.gz
./boot-strap --prefix=/vagrant/sys161/tools
mkdir -p /vagrant/sys161/tools/bin
cp /vagrant/bmake/Linux/bmake /vagrant/sys161/tools/bin/bmake-20101215
rm -f /vagrant/sys161/tools/bin/bmake
if [ ! -e "/vagrant/sys161/tools/bin/bmake" ]; then
    ln -s /vagrant/sys161/tools/bin/bmake-20101215 /vagrant/sys161/tools/bin/bmake
fi
mkdir -p /vagrant/sys161/tools/share/man/cat1
cp /vagrant/bmake/bmake.cat1 /vagrant/sys161/tools/share/man/cat1/bmake.1
sh /vagrant/bmake/mk/install-mk /vagrant/sys161/tools/share/mk
cd /vagrant

pwd
#link
mkdir -p /vagrant/sys161/bin
cd /vagrant/sys161/tools/bin
sh -c 'for i in mips-*; do ln -s /vagrant/sys161/tools/bin/$i /vagrant/sys161/bin/cs350-`echo $i | cut -d- -f4-`; done'
if [ ! -e "/vagrant/sys161/bin/bmake" ]; then
    ln -s /vagrant/sys161/tools/bin/bmake /vagrant/sys161/bin/bmake
fi
cd /vagrant



# sys161 sim
curl -S -L -O http://www.student.cs.uwaterloo.ca/~cs350/os161_repository/sys161.tar.gz
tar -xzf sys161.tar.gz
rm sys161.tar.gz
cd sys161-1.99.06
./configure --prefix=$HOME/sys161 mipseb
make
make install
cd /vagrant/sys161
if [ ! -e "sys161.conf" ]; then
    ln -s share/examples/sys161/sys161.conf.sample sys161.conf
fi
cd /vagrant


# download os/161 if not already there
if [ ! -d "/vagrant/cs350-os161" ]; then
    curl -S -L -O http://www.student.cs.uwaterloo.ca/~cs350/os161_repository/os161.tar.gz
    mkdir -p cs350-os161
    mv os161.tar.gz cs350-os161
    cd cs350-os161
    tar -xzf os161.tar.gz
    rm os161.tar.gz
    cd /vagrant
fi

exit 0
