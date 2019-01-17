#!/usr/bin/env bash

icon="$HOME/Pictures/icons/icon.png"
tmpbg='/tmp/screen.png'

(( $# )) && { icon=$1; }

maim "$tmpbg"
convert "$tmpbg" -scale 5% -scale 2000% "$tmpbg"
mpc pause

#add icon (not the greatest with multiple monitors
#potentially use i3lock-fancy-mutiple-monitors instead
i3lock -i "$tmpbg" -n
