#!/bin/bash
set -e
# Description: Examples of printf usage.
# Reference: http://wiki.bash-hackers.org/commands/builtin/printf

# Test data
	LABEL_OIL="Oil"
	LABEL_GASOLINE="Gasoline"
	VALUE_OIL=7792
	VALUE_GASOLINE=-56

# Printf: Add field character width.
  printf "%10s: %6d\n" "${LABEL_OIL}"       "${VALUE_OIL}"
  printf "%10s: %6d\n" "${LABEL_GASOLINE}"  "${VALUE_GASOLINE}"  

echo ""

# Printf: Add thousand separator.
  printf "%10s: %'6d\n" "${LABEL_OIL}"       "${VALUE_OIL}"
  printf "%10s: %'6d\n" "${LABEL_GASOLINE}"  "${VALUE_GASOLINE}"  
  