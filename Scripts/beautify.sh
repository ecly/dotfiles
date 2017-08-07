#!/bin/bash 

# Waits for wal to set colors and then starts polybar and wal-set which launches dunst
while true; do
    if [[ ! $color15 ]]; then
        ~/Scripts/bin/wal-set
        sh ~/.config/polybar/launch.sh
        exit 1
    fi
    sleep 0.1
done
