#!/bin/bash
set -e
# Description: Examples of error handling.


# Is argument supplied?
# Use -z to check whether argument is supplied or not instead of '$# -eq 0'.
#  It will also handle an empty string.
if [ -z "$1" ]; then
    echo "Error: Directory path is required. Aborted!"
    echo "   e.g.: $0  /my/directory/path/"
    exit 1;
fi

# Does directory existed?
DIR_PATH=$(realpath $1)
if [ ! -d ${DIR_PATH} ]; then
  echo "Error: ${DIR_PATH}: No such directory. Aborted!"
  exit 1;
fi
