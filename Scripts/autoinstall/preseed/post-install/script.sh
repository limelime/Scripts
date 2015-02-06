#!/bin/sh
# Description: 
# Author: Xuan Ngo

### Change console resolution.
echo "GRUB_GFXMODE=1024x768x32" >> /etc/default/grub
echo "GRUB_GFXPAYLOAD_LINUX=keep" >> /etc/default/grub
update-grub