#!/bin/sh
#sh ~/Scripts/wal.sh
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
exec i3
