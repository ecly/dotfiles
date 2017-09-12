#!/bin/sh
sh ~/Scripts/wal.sh
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# If laptop, scale display
if [ "$HOSTNAME" = trsh ]; then
    xrandr --output eDP1 --mode 1920x1200
fi

exec i3
