#!/bin/bash 
# Waits for wal to set colors and then starts polybar and wal-set which launches dunst

while true; do
    if [[ ! $color15 ]]; then
        sh ~/.config/polybar/launch.sh && ~/Scripts/bin/wal-set
        break
    fi
    sleep 0.1
done
