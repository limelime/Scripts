#!/bin/bash
set -e
# Description: Print numbers with color: Negative is red and positive is green.

function F_PRINT_COLOR_NUMBERS()
{
  local LABEL=$1
  local VALUE=$2
  local COLOR_CODE=""
  if [ "${VALUE}" -lt 0 ]; then
    COLOR_CODE=$(tput setaf 1) # red color.
  else
    COLOR_CODE=$(tput setaf 2) # green color.
  fi
  
  local RESET_COLOR=$(tput sgr0)
  printf "%22s: ${COLOR_CODE}%'6d${RESET_COLOR}\n" "${LABEL}" "${VALUE}"
}

F_PRINT_COLOR_NUMBERS "Oil"      7921
F_PRINT_COLOR_NUMBERS "Gasoline" -369