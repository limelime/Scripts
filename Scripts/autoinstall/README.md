Warning
=======
These scripts will delete all your data.


Autoinstall
===========
* Autoinstall is a set of scripts to create an ISO for an unattended installation of Debian.
* See **Autoinstall-min** branch if you want to see the bare minimum script.

Usage
=====
* In order to create the ISO, adjust `deb.sh` to match your paths and run it.
* On CD boot, select **Custom Installation**.

Features
========
* Username/Password = root/debian
* Username/Password = debian/debian
* Install base system
* Increase console resolution to 1024x768.
* Replace `/root/.bashrc`.
* Preload *.deb packages. Copy all your *.deb package to `./preseed/post-install/apt.386/archives/`.

