#!/bin/sh
# Description: 
# Author: Xuan Ngo

# Get the path location of the executing script
## http://stackoverflow.com/questions/630372/determine-the-path-of-the-executing-bash-script
BASE_RAM_DIR="`dirname \"$0\"`"                    # relative
BASE_RAM_DIR="`( cd \"$BASE_RAM_DIR\" && pwd )`"  # absolutized and normalized
if [ -z "$BASE_RAM_DIR" ] ; then
  # error; for some reason, the path is not accessible
  # to the script (e.g. permissions re-evaled after suid)
  exit 1  # fail
fi


FSTAB_FILE=/etc/fstab
if [ ! -f ${FSTAB_FILE}.bck ]; then

  ### fstab 
  # Backup /etc/fstab
  cp ${FSTAB_FILE} ${FSTAB_FILE}.bck
  
  # Replace root(/) line with 'none / tmpfs defaults 0 0'
  sed -i "s/\(.* \/ .*\)/#\1\nnone \/ tmpfs defaults 0 0/" ${FSTAB_FILE}

  ### local
	INITRAMFS_SCRIPT_DIR=/usr/share/initramfs-tools/scripts
	LOCAL_FILE=${INITRAMFS_SCRIPT_DIR}/local
  
  # Backup local
	cp ${LOCAL_FILE} ${LOCAL_FILE}.bck

  # Override local
	cp ${BASE_RAM_DIR}/local.ram ${LOCAL_FILE}

  # Rebuild initramfs
	cd ${INITRAMFS_SCRIPT_DIR}
	mkinitramfs -o /boot/initrd.img-ramboot

  # Put back the original local
	cp ${LOCAL_FILE}.bck ${LOCAL_FILE}
	
  # Add a new boot entry in /boot/grub/grub.cfg
	cp ${BASE_RAM_DIR}/grub.cfg.ram /boot/grub/grub.cfg

fi


