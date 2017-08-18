NAME=~/Pictures/Screenshots/$(date +%s).png
maim -s $NAME
notify-send "Screenshot saved at $NAME" --icon=camera-photo
