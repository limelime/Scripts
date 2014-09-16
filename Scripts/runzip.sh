#!/bin/bash

# Description: This script will unzip all files, including files in subdirectories.
# Author: Xuan Ngo
# Usage: runzip.sh 

# color codes:
red='\e[0;31m'
green='\e[0;32m'
no_color='\e[0m' # No Color


processed=0

# Unziping
find ./ -type f | grep "\.zip" |
while read filename          # As long as there is another line to read ...
do
	dir=$(dirname "$filename")
	if [ "$2" = "commit" ]
	then
		unzip -q -o "$filename" -d "$dir"
		processed=$((processed+1))
		if [ "$?" -eq 0 ] # Get the status of command executed.
		then
			printf "[$filename][${green}OK${no_color}]\n"
		else
			printf "[$filename][${red}NOK${no_color}]\n"
	    fi
	else
		echo "unzip -o $filename -d $dir"
	fi
done

echo "${processed} processed."
