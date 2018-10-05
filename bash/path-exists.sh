#!/bin/bash
set -e
# Description: Test if path exists: Whether file, directory or broken symbolic

function ispathexists()
{
	local path=$1
	if ls "${path}" &> /dev/null; then
		echo "path exists"
	else
		echo "path NOT exists"
	fi 
}

# Test negative.
	echo -n "Test NEGATIVE: "; ispathexists "path-doesnt-exists"

	
# Test file.
	tmpfile="$0".file.txt
	rm -rf "${tmpfile}"
	touch "${tmpfile}"
	echo -n "Test FILE: "; ispathexists "${tmpfile}"
	rm -f "${tmpfile}"

# Test directory.
	dirfile="$0".dir
	rm -rf "${dirfile}"
	mkdir "${dirfile}"
	echo -n "Test DIR: "; ispathexists "${dirfile}"
	rm -rf "${dirfile}"

# Test symbolic.
	tmpfile="$0".file.txt
	rm -rf "${tmpfile}"
		touch "${tmpfile}";
			tmplink="${tmpfile}.link"
			rm -f "${tmplink}"
		ln -s "${tmpfile}" "${tmplink}"
	echo -n "Test LINK: "; ispathexists "${tmplink}"
	rm -f "${tmpfile}"	# Make link broken.
	#rm -f "${tmplink}"
	
# Test broken symbolic.
	echo -n "Test broken LINK: "; ispathexists "${tmplink}"
	rm -f "${tmplink}"

