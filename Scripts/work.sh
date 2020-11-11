#!/bin/bash
if xrandr | grep --quiet "VIRTUAL2"; then
    intel-virtual-output; sleep 3
fi
sh /home/ecly/Scripts/keymap.sh; \

# patched xrandr for pixel perfect 2x scaling for 4k
PATCHED="$HOME/Scripts/xrandr/xrandr"
if [[ -f $PATCHED ]] && [[ 1 -eq 2 ]]; then
    $PATCHED --output eDP1 --primary --mode 3840x2160 --scale "0.5x0.5"; \
    $PATCHED --output VIRTUAL1 --mode 2560x1440 --right-of eDP1; \
    $PATCHED --output VIRTUAL2 --mode 2560x1440 --right-of VIRTUAL1; \
else
    xrandr --output eDP1 --primary --mode 1920x1080 --scale "1x1"; \
    xrandr --output VIRTUAL1 --mode 2560x1440 --right-of eDP1; \
    xrandr --output VIRTUAL2 --mode 2560x1440 --right-of VIRTUAL1; \
fi

sleep 2; \
i3-msg "workspace 1 output VIRTUAL1" > /dev/null; \
i3-msg "workspace 2 output VIRTUAL2" > /dev/null; \
i3-msg "workspace 3 output eDP1" > /dev/null; \
i3-msg "workspace 4 output VIRTUAL1" > /dev/null; \
i3-msg "workspace 1, move workspace to output VIRTUAL1" > /dev/null; \
i3-msg "workspace 2, move workspace to output VIRTUAL2" > /dev/null; \
i3-msg "workspace 3, move workspace to output eDP1" > /dev/null; \
i3-msg "workspace 4, move workspace to output VIRTUAL1" > /dev/null; \
nohup sh ~/.config/polybar/launch.sh > /dev/null 2>&1 &
