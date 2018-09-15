NAME=~/Pictures/Screenshots/$(date +%s).png
if maim -s $NAME; then 
    notify-send "Screenshot saved at $NAME" --icon=camera-photo
fi

