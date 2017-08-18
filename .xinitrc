#!/bin/sh
sh ~/Scripts/wal.sh
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# If laptop, scale display
if [ "$HOSTNAME" = trsh ]; then
    xrandr --dpi 227
fi

exec i3
