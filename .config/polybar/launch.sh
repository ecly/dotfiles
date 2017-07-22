#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

MONITOR=DVI-I-1 polybar main &
MONITOR=HDMI-0 polybar secondary &
MONITOR=DP-0 polybar secondary &
