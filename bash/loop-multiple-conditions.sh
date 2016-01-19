#!/bin/bash
set -e
# Description: Multiple conditions in loop

# WHILE loop
W_IDX=1
W_BOOL="true"
while [[ "${W_IDX}" -lt 5 && "${W_BOOL}" = "true" ]]; do

  echo "While loop: ${W_IDX}"
  W_IDX=$[$W_IDX + 1]
  
  # Get out before index is exhausted.
  if [ "${W_IDX}" -gt 2 ]; then
    W_BOOL="false"
  fi
  
done