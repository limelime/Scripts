#!/bin/bash
# Description: Close current terminal and open a terminal.
# Author: Xuan Ngo
# Require: nohup, xfce4-terminal

# * Don't suffix command with '&'. Otherwise, command doesn't have time to complete
#       before close this current terminal.
# * 2>/dev/null: Supress "nohup: ignoring input and appending output to `nohup.out'" 
# * Adding -e COMMAND to xfce4-terminal doesn't work. Don't know why.
nohup xfce4-terminal --geometry=190x21+0+0 2>/dev/null

# Or
# Simpler to use --hold option.
#xfce4-terminal --geometry=190x21+0+0 --hold

### Close current terminal.
kill -9 $PPID
