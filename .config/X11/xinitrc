#!/bin/sh
sh ~/Scripts/wal.sh
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# No keyboard beeping
xset b off

exec i3
