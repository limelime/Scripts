#!/bin/bash
#########################################################
# Description: Display hard drive info(device, size, 
#               model, serial number)
# Author: Xuan Ngo
# Usage:
#   ./hd-stats.sh
# Note: sh hd-stats.sh gives error. Don't know why.
#########################################################

#### To handle line with spaces.
SAVE_IFS=$IFS
IFS=$(echo -en "\n\b")

for fdisk_data in `fdisk -l | grep 'Disk /dev/' | sed 's/^Disk //'`;
do
  device=$(echo ${fdisk_data}| sed 's/:.*//' )
  hd_info=$(hdparm -i $device 2> /dev/null | grep 'Model')
  
	if [ ${#hd_info} -eq 0 ]; then
	  hd_info=" ERROR: hdparm -i ${device}"
	fi

  echo "${fdisk_data},${hd_info}"

done

### Restore IFS
IFS=$SAVE_IFS

  
  
  