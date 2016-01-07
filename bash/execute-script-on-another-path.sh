#!/bin/bash
set -e
# Description: Execute script located on another path without leaving the current working directory.
#   Solution: Use subshell, i.e. ().


TMP_DIR="$0_tmp-test-folder983"
mkdir -p "${TMP_DIR}"

touch "${TMP_DIR}/file-from-another-path.txt"


( 
  cd "${TMP_DIR}"; echo "List the other directory:"
  ls *
  echo "" # Add newline.
)



echo "List current directory:"
ls $0

# Clean up
rm -rf "${TMP_DIR}"