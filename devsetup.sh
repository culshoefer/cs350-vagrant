#!/bin/bash
set -e

# binutils
cd /home/vagrant
curl -S -L -O http://www.student.cs.uwaterloo.ca/~cs350/os161_repository/os161-binutils.tar.gz
tar -xf os161-binutils.tar.gz
rm os161-binutils.tar.gz
cd binutils-2.17+os161-2.0.1
./configure --nfp --disable-werror --target=mips-harvard-os161 --prefix=/home/vagrant/sys161/tools
make
make install
cd /home/vagrant
mkdir -p sys161/bin

#env
export PATH=$HOME/sys161/bin:$HOME/sys161/tools/bin:$PATH
echo "export PATH=$HOME/sys161/bin:$HOME/sys161/tools/bin:$PATH" >> ~/.bashrc
#setenv PATH $HOME/sys161/bin:$HOME/sys161/tools/bin:${PATH}
echo "setenv PATH $HOME/sys161/bin:$HOME/sys161/tools/bin:${PATH}" >> ~/.cshrc

# GCC Cross-compiler
curl -S -L -O http://www.student.cs.uwaterloo.ca/~cs350/os161_repository/os161-gcc.tar.gz
tar -xzf os161-gcc.tar.gz
rm os161-gcc.tar.gz
cd gcc-4.1.2+os161-2.0
./configure -nfp --disable-shared --disable-threads --disable-libmudflap --disable-libssp --target=mips-harvard-os161 --prefix=/home/vagrant/sys161/tools
make
make install 
cd ..

# GDB
curl -S -L -O http://www.student.cs.uwaterloo.ca/~cs350/os161_repository/os161-gdb.tar.gz
tar -xf os161-gdb.tar.gz
rm os161-gdb.tar.gz
cd gdb-6.6+os161-2.0
./configure --target=mips-harvard-os161 --prefix=/home/vagrant/sys161/tools --disable-werror 
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
./boot-strap --prefix=/home/vagrant/sys161/tools
# ./make-bootstrap.sh

mkdir -p /home/vagrant/sys161/tools/bin
cp /home/vagrant/bmake/Linux/bmake /home/vagrant/sys161/tools/bin/bmake-20101215
rm -f /home/vagrant/sys161/tools/bin/bmake
ln -s bmake-20101215 /home/vagrant/sys161/tools/bin/bmake
mkdir -p /home/vagrant/sys161/tools/share/man/cat1
cp /home/vagrant/bmake/bmake.cat1 /home/vagrant/sys161/tools/share/man/cat1/bmake.1
sh /home/vagrant/bmake/mk/install-mk /home/vagrant/sys161/tools/share/mk
cd /home/vagrant

pwd
#link
mkdir -p /home/vagrant/sys161/bin
cd /home/vagrant/sys161/tools/bin
sh -c 'for i in mips-*; do ln -s /home/vagrant/sys161/tools/bin/$i /home/vagrant/sys161/bin/cs350-`echo $i | cut -d- -f4-`; done'
if [ ! -e "/home/vagrant/sys161/bin/bmake" ]; then
    ln -s /home/vagrant/sys161/tools/bin/bmake /home/vagrant/sys161/bin/bmake
fi
cd /home/vagrant



# sys161 sim
curl -S -L -O http://www.student.cs.uwaterloo.ca/~cs350/os161_repository/sys161.tar.gz
tar -xzf sys161.tar.gz
rm sys161.tar.gz
cd sys161-1.99.06
./configure --prefix=$HOME/sys161 mipseb
make
make install
cd /home/vagrant/sys161
if [ ! -e "sys161.conf" ]; then
    ln -s share/examples/sys161/sys161.conf.sample sys161.conf
fi
cd /home/vagrant



exit 0
