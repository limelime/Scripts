#!/bin/bash
# Description: Open 2 terminal windows, one on top of each other and taking full width

# http://unix.stackexchange.com/a/98493

# http://stackoverflow.com/a/263900
COLUMNS=$(tput cols)
LINES=$(tput lines)
LINES_HALF=$((${LINES}/2-1))

# http://superuser.com/a/487598
SCREEN_RESOLUTION=$(xrandr | head -n1 | cut -d, -f2 | cut -d" " -f3-5)
WIDTH=$(echo ${SCREEN_RESOLUTION}|sed 's/ .*//')
HEIGHT=$(echo ${SCREEN_RESOLUTION}|sed 's/^.*x //')
HEIGHT_HALF=$((${HEIGHT}/2))

xfce4-terminal --title="Top" --geometry=${COLUMNS}x${LINES_HALF}+0+0 &
xfce4-terminal --title="Bottom" --geometry=${COLUMNS}x${LINES_HALF}+0+${HEIGHT_HALF} &
