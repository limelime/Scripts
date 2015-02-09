# Description: This script will run only once and after the first boot.
# Author: Xuan Ngo

POST_INSTALL_DIR=/root/post-install

### Change console resolution.
echo "GRUB_GFXMODE=1024x768x32" >> /etc/default/grub
echo "GRUB_GFXPAYLOAD_LINUX=keep" >> /etc/default/grub
update-grub

### Add .bashrc.
cp ${POST_INSTALL_DIR}/bashrc_root /root/.bashrc


### Preload *.deb: Copy *.deb to /var/cache/apt/archives
DEB_CACHE_DIR=/var/cache/apt/archives/
cp -Rf ${POST_INSTALL_DIR}/apt.386/archives/* ${DEB_CACHE_DIR} 

### Modify sources.list
# Disable the cdrom path from the apt sources.list automatically.
sed -i 's/^deb cdrom/#deb/' /etc/apt/sources.list
cat ${POST_INSTALL_DIR}/add-sources.list >> /etc/apt/sources.list
aptitude -y update

### Install other packages
# These packages are need to install VirtualBox Guest Additions.
aptitude -y install bzip2
aptitude -y install dkms build-essential linux-headers-$(uname -r)

### Is it really running once?
DATE_STRING=`date +"%Y-%m-%d_%0k.%M.%S"`
echo "firstboot.sh ran on ${DATE_STRING}." >> ${POST_INSTALL_DIR}/firstboot.log

### Remove our firstboot service so that it won't run again
update-rc.d firstboot remove

### Reboot into the new kernel
/sbin/reboot