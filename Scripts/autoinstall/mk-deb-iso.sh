#!/bin/sh
# Description: Create custom auto install Debian ISO
# Author: Xuan Ngo
# Usage: mkdeb.sh <Image folder path> <Preseed file path> <isolinux.cfg path>
# Reference: 
#	-https://wiki.debian.org/DebianInstaller/Preseed/EditIso
#	-https://codeghar.wordpress.com/2011/12/14/automated-customized-debian-installation-using-preseed/
#	-http://blog.ericwhite.ca/articles/2009/11/unattended-debian-lenny-install/
#	-http://www.hps.com/~tpg/notebook/autoinstall.php (A lot of tips)
#	-http://users.telenet.be/mydotcom/howto/boot/boot_linux.htm
#	-https://forums.virtualbox.org/viewtopic.php?f=10&t=46798
#	-https://lists.debian.org/debian-boot/2012/01/msg00016.html (isolinux)


# Manual input variables
ISO_BASE_DIR=$1
PRESEED_FILE=$2
DATE_STRING=`date +"%Y-%m-%d_%0k.%M.%S"`
OUTPUT_ISO=$3/cust-deb-${DATE_STRING}.iso
YOUR_ISOLINUX_CFG=$4

# Copy your preseed file to the root path of your cdrom.
cp ${PRESEED_FILE} ${ISO_BASE_DIR}/custom.seed

# Backup the original isolinux.cfg.
BASE_ISOLINUX_CFG_FILE_PATH=${ISO_BASE_DIR}/isolinux/isolinux.cfg
if [ ! -f ${BASE_ISOLINUX_CFG_FILE_PATH}.bck ]; then
	cp ${BASE_ISOLINUX_CFG_FILE_PATH} ${BASE_ISOLINUX_CFG_FILE_PATH}.bck
fi

# Replace the original isolinux.cfg with your modified version.
cp ${YOUR_ISOLINUX_CFG} ${BASE_ISOLINUX_CFG_FILE_PATH}

# Fix md5sum
cd ${ISO_BASE_DIR}
cp md5sum.txt md5sum.txt.bck
md5sum `find -follow -type f` > md5sum.txt
#md5sum `find ! -name "md5sum.txt" ! -path "./isolinux/*" -follow -type f` > md5sum.txt
cd ..
# find: File system loop detected; `./debian' is part of the same file system loop as `.'.
# md5sum `find ! -name "md5sum.txt" ! -path "./isolinux/*" -follow -type f` > md5sum.txt

# Make ISO
rm -f ${OUTPUT_ISO}
genisoimage  -r -V "cust-deb-iso" -cache-inodes -J -l -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o ${OUTPUT_ISO} ${ISO_BASE_DIR}


# Display info
echo "***************** Done *****************"
echo "Created ${OUTPUT_ISO} with ${PRESEED_FILE}."


# Install packages:
# d-i pkgsel/include string ssh rsync initrd-tools cramfsprogs lzop

