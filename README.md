# cs350-vagrant
Vagrant box for CS350s OS161 setup.
This repository contains the scripts to create a Vagrant box from scratch.
You do not need to create the Vagrant box from scratch, check this out.

Caveat to installing OS161/SYS161 this way (that I have not been able to fix, but maybe you can):
It is not possible to issue commands to sys161 in the style of `sys161 kernel "tt1;q"`. A pull request is welcome.

Otherwise, the installation works fine. In particular, you can use the install script to install OS161/Sys161 on your local machine (well if you change the directory, that is). 

Not maintained after Christmas 2017.

Usage:
```sh
vagrant up
vagrant ssh
cd /vagrant
sudo ./devsetup.sh # I know, it's dirty to exec the entire script in sudo.
sudo ./clean
logout
```
