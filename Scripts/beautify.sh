#!/bin/bash 

# Currently wait a bit before executing due to a known bug
# https://bbs.archlinux.org/viewtopic.php?id=200797
# Modify sleep time from machine to machine

sleep 1

# Waits for wal to set colors and then starts polybar and wal-set which launches dunst
while true; do
    if [[ ! $color15 ]]; then
        ~/Scripts/bin/wal-set
        sh ~/.config/polybar/launch.sh
        exit 1
    fi
    sleep 0.1
done
