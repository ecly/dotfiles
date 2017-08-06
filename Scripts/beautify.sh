#!/bin/bash 
# Loads last used wal colorscheme, runs wal-set to start dunst with right colors, and runs polybar launch script

# Generate correct path for last used colorscheme
scheme=$(cat ~/.cache/wal/wal)
scheme=${scheme/./_} #replace . with _
ext=".json"

wal -f "${HOME}/.cache/wal/schemes/$scheme$ext" -o ~/Scripts/bin/wal-set && ~/.config/polybar/launch.sh
