#!/bin/bash

networkIP=$1

len=${#networkIP}
if [ "$len" -ne 0 ]
then
	LIMIT=254
	for ((i=0; i <= LIMIT ; i++))  # Double parentheses, and "LIMIT" with no "$".
	do
		if ping -c 1 -w 2 -q $networkIP.$i
		then
			echo "$networkIP.$i is alive." > $0.log
		fi
	done
else
	echo "Invalid command."
	echo "Usage: $0 <NetworkIP>"
	echo "      eg. $0 192.168.0"
fi
