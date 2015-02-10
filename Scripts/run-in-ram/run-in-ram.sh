#!/bin/sh
# Description: Script to make your Debian system run in memory.
# Author: Xuan Ngo
# Usage: On boot, select the RAM boot entry.
#       run-in-ram.sh <version>
# Reference:
#   -http://reboot.pro/topic/14547-linux-load-your-root-partition-to-ram-and-boot-it/


### VERSION
VERSION=$1
if [ $# -eq 0 ]; then
  echo "No version supplied."
  echo "Available versions are:"
  echo "\t debian-7.x"
  echo "\t mint-201403"
  exit 1;
fi

### Get the path location of the executing script
## http://stackoverflow.com/questions/630372/determine-the-path-of-the-executing-bash-script
BASE_RAM_DIR="`dirname \"$0\"`"                    # relative
BASE_RAM_DIR="`( cd \"$BASE_RAM_DIR\" && pwd )`"  # absolutized and normalized
if [ -z "$BASE_RAM_DIR" ] ; then
  # error; for some reason, the path is not accessible
  # to the script (e.g. permissions re-evaled after suid)
  exit 1  # fail
fi

PRE_MADE_DIR=${BASE_RAM_DIR}/pre-made-files

### fstab 
FSTAB_FILE=/etc/fstab
  # Backup /etc/fstab
  cp -n ${FSTAB_FILE} ${FSTAB_FILE}.bck

  # Replace root(/) line with 'none / tmpfs defaults 0 0'
  sed -i "/^#/b; s/\(^.* \/ .*\)/#\1\nnone \/ tmpfs defaults 0 0/" ${FSTAB_FILE}

### local
INITRAMFS_SCRIPT_DIR=/usr/share/initramfs-tools/scripts
LOCAL_FILE=${INITRAMFS_SCRIPT_DIR}/local

  # Backup local
  cp -n ${LOCAL_FILE} ${LOCAL_FILE}.bck

  # Override local
  cp ${PRE_MADE_DIR}/local.ram-${VERSION} ${LOCAL_FILE}

  # Rebuild initramfs
  cd ${INITRAMFS_SCRIPT_DIR}
  mkinitramfs -o /boot/initrd.img-ramboot

  # Put back the original local
  yes|cp ${LOCAL_FILE}.bck ${LOCAL_FILE}

### grub.cfg
GRUB_FILE=/boot/grub/grub.cfg
  # Backup grub.cfg
  cp -n ${GRUB_FILE} ${GRUB_FILE}.bck
  
  # Add a new boot entry(RAM) in /boot/grub/grub.cfg
  cp ${PRE_MADE_DIR}/grub.cfg.ram-${VERSION} ${GRUB_FILE}




