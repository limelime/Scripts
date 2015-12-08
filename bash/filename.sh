#!/bin/bash
set -e
# Description: Filename informations.

# Create test data.
TMP_DIR="./tmp some directory"
mkdir -p "${TMP_DIR}"
TMP_FILE="${TMP_DIR}/./tmp.some.file.txt"
echo "some text" > "${TMP_FILE}"


# Get different information of file.
FULL_PATH=$(realpath "${TMP_FILE}")
FILENAME=$(basename "${FULL_PATH}")
DIR_OF_FILE=$(dirname "${FULL_PATH}")

echo "Full path = ${FULL_PATH}"
echo "Filename  = ${FILENAME}"
echo "Directory = ${DIR_OF_FILE}"
echo "Don't process file extension. Otherwise, it will not be cross platform."
echo "File type = $(file -ib "${FULL_PATH}")"


# Clean up.
rm -rf "${TMP_DIR}"
