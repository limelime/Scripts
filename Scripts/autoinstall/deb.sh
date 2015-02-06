#!/bin/sh
# Description: Generate custom auto install ISO
# Author: Xuan Ngo

MOD_ISO_DIR=/media/sf_vm_sharedfolder/moddebdir
ISO_FILE_PATH=/media/sf_vm_sharedfolder/debian-7.8.0-i386-CD-1.iso
#./extract-deb-iso.sh ${ISO_FILE_PATH} ${MOD_ISO_DIR}

PRESEED_FILE_PATH=preseed/deb-7.8.0-i386-CD-1-preseed.cfg
OUTPUT_ISO_DIR=/media/sf_vm_sharedfolder
#./mkdeb.sh ${MOD_ISO_DIR} ${PRESEED_FILE_PATH} ${OUTPUT_ISO_DIR}


# Copy post-install folder to root path of CD-ROM.
cp -R preseed/post-install/ ${MOD_ISO_DIR}


YOUR_ISOLINUX_CFG=preseed/isolinux.cfg
./mk-deb-iso.sh ${MOD_ISO_DIR} ${PRESEED_FILE_PATH} ${OUTPUT_ISO_DIR} ${YOUR_ISOLINUX_CFG}