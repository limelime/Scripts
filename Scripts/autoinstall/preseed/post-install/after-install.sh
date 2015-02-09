#!/bin/sh
# Description: This script will run after the installation from the ISO is completed.
# Author: Xuan Ngo

POST_INSTALL_DIR=/root/post-install

### Change console resolution.
echo "GRUB_GFXMODE=1024x768x32" >> /etc/default/grub
echo "GRUB_GFXPAYLOAD_LINUX=keep" >> /etc/default/grub
update-grub

### Add .bashrc.
cp ${POST_INSTALL_DIR}/bashrc_root /root/.bashrc


### Preload *.deb: Copy *.deb to /var/cache/apt/archives
cp -R ${POST_INSTALL_DIR}/apt.386/archives/* /var/cache/apt/archives 

### Modify sources.list
# Disable the cdrom path from the apt sources.list automatically.
sed -i 's/^deb cdrom/#deb/' /etc/apt/sources.list
cat ${POST_INSTALL_DIR}/add-sources.list >> /etc/apt/sources.list
aptitude -y update

### Install other packages
# These packages are need to install VirtualBox Guest Additions.
aptitude -y install bzip2
aptitude -y install dkms build-essential linux-headers-$(uname -r)
