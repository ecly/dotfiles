#!/bin/sh
sh ~/Scripts/wal.sh
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# No keyboard beeping
xset b off

# If laptop, scale display
if [ "$HOSTNAME" = trsh ]; then
    xrandr --output eDP1 --mode 1920x1200
fi
# xrandr --setprovideroutputsource Intel NVIDIA-0

exec i3
