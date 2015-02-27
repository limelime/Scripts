#!/bin/sh
# Description: Execute a command if linux is idle for 5 minutes.
# Requirements: xprintidle, xte(xautomation)
# Reference: http://superuser.com/questions/638357/execute-a-command-if-linux-is-idle-for-5-minutes

# Wanted trigger timeout in milliseconds.
IDLE_TIME=$((2*60*1000))

# Sequence to execute when timeout triggers.
trigger_cmd() {
  echo "Move mouse: $(date)" >> mousemove.log
  #xte 'mousemove 80 80'
  xdotool mousemove --window 0 --sync 230 65 click --window 0 1
}

sleep_time=$IDLE_TIME
triggered=false

# ceil() instead of floor()
while sleep $(((sleep_time+999)/1000)); do
    idle=$(xprintidle)
#	echo "$(date +'%Y-%m-%d_%0k.%M.%S') hello"
#	echo "idle=$idle  IDLE_TIME=$IDLE_TIME "
    if [ $idle -ge $IDLE_TIME ]; then
        if ! $triggered; then
            trigger_cmd
            triggered=true
            sleep_time=$IDLE_TIME
        fi
    else
        triggered=false
        # Give 100 ms buffer to avoid frantic loops shortly before triggers.
        sleep_time=$((IDLE_TIME-idle+100))
    fi
done