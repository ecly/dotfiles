#!/usr/bin/env bash

icon="$HOME/Dropbox/Pictures/Icons/icon.png"
tmpbg='/tmp/screen.png'

(( $# )) && { icon=$1; }

scrot "$tmpbg"
convert "$tmpbg" -scale 10% -scale 1000% "$tmpbg"

#add icon (not the greatest with multiple monitors
#potentially use i3lock-fancy-mutiple-monitors instead
#convert "$tmpbg" "$icon" -gravity center -composite -matte "$tmpbg"
mpc pause

i3lock -i "$tmpbg"

# command that hide defaults icon
#i3lock -u -i "$tmpbg"
