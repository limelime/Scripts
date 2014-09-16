#!/bin/bash

# Description: This script will unzip all files, including files in subdirectories.
# Author: Xuan Ngo
# Usage: runzip.sh 

# color codes:
red='\e[0;31m'
green='\e[0;32m'
no_color='\e[0m' # No Color


processed=0
find ./ -type f | grep "\.zip" |
while read line          # As long as there is another line to read ...
do
	dir=$(dirname "$line")
	if [ "$2" = "commit" ]
	then
		unzip -o "$line" -d "$dir"
		processed=$((processed+1))
		if [ "$?" -eq 0 ] # Get the status of command executed.
		then
			echo -e "[$line][${green}OK${no_color}]"
		else
			echo -e "[$line][${red}NOK${no_color}]"
	    fi
	else
		echo "unzip -o $line -d $dir"
	fi
done

echo "${processed} processed."
