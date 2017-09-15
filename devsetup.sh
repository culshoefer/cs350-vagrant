#!/bin/bash
set -e
dir=/home/vagrant
echo $dir
# binutils
cd $dir
curl -s -S -L -O http://www.student.cs.uwaterloo.ca/~cs350/os161_repository/os161-binutils.tar.gz
tar -xf os161-binutils.tar.gz
rm os161-binutils.tar.gz
cd binutils-2.17+os161-2.0.1
./configure --nfp --disable-werror --target=mips-harvard-os161 --prefix=$dir/sys161/tools
find . -name '*.info' | xargs touch
make
make install
cd $dir
mkdir -p sys161/bin

#env
export PATH=$dir/sys161/bin:$dir/sys161/tools/bin:$PATH
echo "export PATH=$dir/sys161/bin:$dir/sys161/tools/bin:$PATH" >> $dir/.bashrc
echo $PATH
#setenv PATH $dir/sys161/bin:$dir/sys161/tools/bin:${PATH}
echo "setenv PATH $dir/sys161/bin:$dir/sys161/tools/bin:${PATH}" >> $dir/.cshrc

# GCC Cross-compiler
curl -s -S -L -O http://www.student.cs.uwaterloo.ca/~cs350/os161_repository/os161-gcc.tar.gz
tar -xzf os161-gcc.tar.gz
rm os161-gcc.tar.gz
cd gcc-4.1.2+os161-2.0
./configure -nfp --disable-shared --disable-threads --disable-libmudflap --disable-libssp --target=mips-harvard-os161 --prefix=$dir/sys161/tools
make
make install 
cd ..

# GDB
curl -s -S -L -O http://www.student.cs.uwaterloo.ca/~cs350/os161_repository/os161-gdb.tar.gz
tar -xf os161-gdb.tar.gz
rm os161-gdb.tar.gz
cd gdb-6.6+os161-2.0
./configure --target=mips-harvard-os161 --prefix=$dir/sys161/tools --disable-werror 
make
make install
cd ..
pwd

# bmake
curl -s -S -L -O http://www.student.cs.uwaterloo.ca/~cs350/os161_repository/os161-bmake.tar.gz
curl -s -S -L -O http://www.student.cs.uwaterloo.ca/~cs350/os161_repository/os161-mk.tar.gz
tar -xzf os161-bmake.tar.gz
rm os161-bmake.tar.gz
cd bmake
tar -xzf ../os161-mk.tar.gz
rm ../os161-mk.tar.gz
./boot-strap --prefix=$dir/sys161/tools
# ./make-bootstrap.sh

mkdir -p $dir/sys161/tools/bin
cp $dir/bmake/Linux/bmake $dir/sys161/tools/bin/bmake-20101215
rm -f $dir/sys161/tools/bin/bmake
ln -s bmake-20101215 $dir/sys161/tools/bin/bmake
mkdir -p $dir/sys161/tools/share/man/cat1
cp $dir/bmake/bmake.cat1 $dir/sys161/tools/share/man/cat1/bmake.1
sh $dir/bmake/mk/install-mk $dir/sys161/tools/share/mk
cd $dir

pwd
#link
mkdir -p $dir/sys161/bin
cd $dir
sh -c 'export dir=$(pwd); cd sys161/tools/bin; for i in mips-*; do ln -s $dir/sys161/tools/bin/$i $dir/sys161/bin/cs350\
-`echo $i | cut -d- -f4-`; done'
if [ ! -e "$dir/sys161/bin/bmake" ]; then
    ln -s $dir/sys161/tools/bin/bmake $dir/sys161/bin/bmake
fi
cd $dir

# sys161 sim
curl -s -S -L -O http://www.student.cs.uwaterloo.ca/~cs350/os161_repository/sys161.tar.gz
tar -xzf sys161.tar.gz
rm sys161.tar.gz
cd sys161-1.99.06
./configure --prefix=$dir/sys161 mipseb
make
make install
cd $dir/sys161
if [ ! -e "sys161.conf" ]; then
    ln -s share/examples/sys161/sys161.conf.sample sys161.conf
fi
cd $dir

exit 0
