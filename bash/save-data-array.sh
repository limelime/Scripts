#!/bin/bash
set -e 
# Description: Save data in array through a loop

touch $0-a.txt
touch $0-b.txt

LS_ARRAY=()
while IFS='' read -r LINE || [[ -n "$LINE" ]]; do
 
  LS_ARRAY+=("${LINE}")
 
done < <( ls * )

echo ${LS_ARRAY[1]}

rm -f $0-a.txt $0-b.txt