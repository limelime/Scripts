#!/bin/sh
# Description: Script to make your Debian system run in memory.
# Author: Xuan Ngo
# Usage: On boot, select the RAM boot entry.
# Reference:
#   -http://reboot.pro/topic/14547-linux-load-your-root-partition-to-ram-and-boot-it/

### Get the path location of the executing script
## http://stackoverflow.com/questions/630372/determine-the-path-of-the-executing-bash-script
BASE_RAM_DIR="`dirname \"$0\"`"                    # relative
BASE_RAM_DIR="`( cd \"$BASE_RAM_DIR\" && pwd )`"  # absolutized and normalized
if [ -z "$BASE_RAM_DIR" ] ; then
  # error; for some reason, the path is not accessible
  # to the script (e.g. permissions re-evaled after suid)
  exit 1  # fail
fi



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
  cp ${BASE_RAM_DIR}/local.ram ${LOCAL_FILE}

  # Rebuild initramfs
  cd ${INITRAMFS_SCRIPT_DIR}
  mkinitramfs -o /boot/initrd.img-ramboot

  # Put back the original local
  yes|cp ${LOCAL_FILE}.bck ${LOCAL_FILE}

  # Add a new boot entry(RAM) in /boot/grub/grub.cfg
  cp ${BASE_RAM_DIR}/grub.cfg.ram /boot/grub/grub.cfg




