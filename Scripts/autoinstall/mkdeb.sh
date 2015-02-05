#!/bin/sh
# Description: Create custom auto install Debian ISO
# Author: Xuan Ngo
# Reference: 
#	-https://wiki.debian.org/DebianInstaller/Preseed/EditIso
#	-https://codeghar.wordpress.com/2011/12/14/automated-customized-debian-installation-using-preseed/
#	-http://blog.ericwhite.ca/articles/2009/11/unattended-debian-lenny-install/
#	-http://www.hps.com/~tpg/notebook/autoinstall.php (A lot of tips)
#	-http://users.telenet.be/mydotcom/howto/boot/boot_linux.htm
#	-https://forums.virtualbox.org/viewtopic.php?f=10&t=46798
#	-https://lists.debian.org/debian-boot/2012/01/msg00016.html (isolinux)


# Manual input variables
ISO_BASE_DIR=/media/apps/iso/debnetinst
#PRESEED_FILE=preseed/cust-deb-preseed.cfg
PRESEED_FILE=preseed/test-preseed.cfg

DATE_STRING=`date +"%Y-%m-%d_%0k.%M.%S"`
OUTPUT_ISO=/media/sf_vm_sharedfolder/cust-deb-${DATE_STRING}.iso


INITRD_PATH=${ISO_BASE_DIR}/install.386/initrd.gz


# Create a temporary folder to do work on.
TMP_DIR=irmod
rm -rf ${TMP_DIR}
mkdir ${TMP_DIR}


# Decompress initrd.gz in the temporary folder
cd ${TMP_DIR}
gzip -d < ${INITRD_PATH} | cpio --extract --verbose --make-directories --no-absolute-filenames

# Copy your preseed file to initrd
cp ${PRESEED_FILE} preseed.cfg

# Backup the original initrd.gz.
cp ${INITRD_PATH} ${INITRD_PATH}.bck

# Repackage initrd.gz and overwrite the original initrd.gz.
find . | cpio -H newc --create --verbose | gzip -9 > ${INITRD_PATH}

# Clean up.
cd ../
rm -rf ${TMP_DIR}

# Fix md5sum
cd ${ISO_BASE_DIR}
cp md5sum.txt md5sum.txt.bck
md5sum `find -follow -type f` > md5sum.txt
cd ..
# find: File system loop detected; `./debian' is part of the same file system loop as `.'.
# md5sum `find ! -name "md5sum.txt" ! -path "./isolinux/*" -follow -type f` > md5sum.txt

# Make ISO
rm -f ${OUTPUT_ISO}
genisoimage  -r -V "cust-deb-iso" -cache-inodes -J -l -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o ${OUTPUT_ISO} ${ISO_BASE_DIR}


# Display info
echo "Created ${OUTPUT_ISO} with ${PRESEED_FILE}."
ls -al ${OUTPUT_ISO}

# Install packages:
# d-i pkgsel/include string ssh rsync initrd-tools cramfsprogs lzop

