#!/bin/bash
set -e
# Description: Examples of printf usage.
# Reference: http://wiki.bash-hackers.org/commands/builtin/printf

# INTEGER
#############
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
echo ""

# DECIMAL
#############
# Test data
  LABEL_OIL="Oil"
  LABEL_GASOLINE="Gasoline"
  VALUE_OIL=7792.015
  VALUE_GASOLINE=-56.6

# Printf: Add field character width.
  printf "%10s: %11f\n" "${LABEL_OIL}"       "${VALUE_OIL}"
  printf "%10s: %11f\n" "${LABEL_GASOLINE}"  "${VALUE_GASOLINE}"  
echo ""

# Printf: Limit to 2 decimal digits. Left and right alignment. It also rounds up.
  printf "%10s: %'8.2f\n" "${LABEL_OIL}"       "${VALUE_OIL}"
  printf "%10s: %'-8.2f\n" "${LABEL_GASOLINE}"  "${VALUE_GASOLINE}"  
echo ""    
 