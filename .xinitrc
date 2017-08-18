#!/bin/sh
sh ~/Scripts/wal.sh
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# If laptop, scale display
if [ "$HOSTNAME" = trsh ]; then
    xrandr --output eDP1 1920x1200
    #xrandr --dpi 227
fi

exec i3
