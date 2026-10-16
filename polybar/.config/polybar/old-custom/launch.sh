#!/bin/bash
# kill existing bars
killall -q polybar

# wait until they're all dead
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# launch bars
polybar mybar &
