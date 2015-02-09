#!/bin/sh
# Description: This script will run after the installation from the ISO is completed.
# Author: Xuan Ngo

### Change console resolution.
echo "GRUB_GFXMODE=1024x768x32" >> /etc/default/grub
echo "GRUB_GFXPAYLOAD_LINUX=keep" >> /etc/default/grub
update-grub

### Add .bashrc.
cp /root/post-install/bashrc_root /root/.bashrc

### Replace sources.list
# Disable the cdrom path from the apt sources.list automatically.
sed -i 's/^deb cdrom/#deb/' /etc/apt/sources.list