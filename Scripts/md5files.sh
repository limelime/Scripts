#!/bin/bash
# Description: This script will calculate md5sum of all files, including files in subdirectories 
#  and output the result as follow:
# YYYY-MM-DD HH:MM:SS | MD5 hash | Size in bytes | Filename
# Author: Xuan Ngo
# Usage:
#	md5files.sh
function recursive()
{
	local sPath="$1"
	if cd "$sPath"
	then
		for sFilename in *
		do
			if [ -d "$sFilename" ]
			then
				recursive "$sFilename"
			else
				if [ -f "$sFilename" ]
				then
					lFileSize=`du -sb "$sFilename" | gawk '{print $1}'`
					md5sum "$sFilename" | gawk -v hFileName="$sFilename" -v filesize="$lFileSize" '{print strftime("%Y-%m-%d %H:%M:%S"),"|", $1, "|", filesize, "|", hFileName}'
				fi
			fi
		done
		cd ..	
	fi
}
recursive "$1"
