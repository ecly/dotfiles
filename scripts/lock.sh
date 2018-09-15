#!/usr/bin/env bash

icon="$HOME/Dropbox/Pictures/Icons/icon.png"
tmpbg='/tmp/screen.png'

(( $# )) && { icon=$1; }

maim "$tmpbg"
convert "$tmpbg" -scale 10% -scale 1000% "$tmpbg"
mpc pause

#add icon (not the greatest with multiple monitors
#potentially use i3lock-fancy-mutiple-monitors instead
if [ "$HOSTNAME" = trsh ]; then
    convert "$tmpbg" "$icon" -gravity center -composite -matte "$tmpbg"
    i3lock -u -i "$tmpbg"
else
    i3lock -i "$tmpbg" -n
fi
