NAME=~/Pictures/$(date +%s).png
maim -s $NAME
notify-send 'Screenshot taken!' "It was saved at $NAME" --icon=camera-photo
