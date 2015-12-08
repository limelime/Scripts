#!/bin/bash

# Description: This script will unzip all files, including files in subdirectories.
# Author: Xuan Ngo
# Usage: 
#	See unzip commands
#		runzip.sh <path>
#	Commit by actually doing the unzip
#		runzip.sh <path> commit

# Handling filename with spaces
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

# Get max file path length
###########################
max_file_length=0
for filename in $(find ./ -type f | grep "\.zip")
do
	if [ "${#filename}" -gt "$max_file_length" ]
	then
		max_file_length=${#filename}
	fi
done

# Color codes
###########################
red='\e[0;31m'
green='\e[0;32m'
no_color='\e[0m' # No Color


# Unzipping
###########################
processed=0
counter=0
for filename in $(find ./ -name "*.zip" -type f)
do
	counter=$((counter+1))
	dir=$(dirname "$filename")
	if [ "$2" = "commit" ]
	then
		processed=$((processed+1))
		unzip -q -o "$filename" -d "$dir"
		if [ "$?" -eq 0 ] # Get the status of previously executed command. Unzip must be before this line.
		then
			printf "[%3d][Unzipping %-${max_file_length}s][${green}OK${no_color}]\n" "$processed" "$filename"
		else
			printf "[%3d][Unzipping %-${max_file_length}s][${red}NOK${no_color}]\n" "$processed" "$filename"
	    fi
	else
		printf "[%3d][unzip -o %-${max_file_length}s -d %-${max_file_length}s]\n" "$counter" "$filename" "$dir"
	fi
done

echo -e "${green}${processed} processed.${no_color}"

# Restore $IFS
IFS=$SAVEIFS
