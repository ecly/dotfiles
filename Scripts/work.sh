#!/bin/bash

sh /home/ecly/Scripts/keymap.sh; \
xset b off; \
intel-virtual-output; \
sleep 3; \
xrandr --output eDP1 --primary --mode 1920x1080; \
xrandr --output VIRTUAL1 --mode 2560x1440 --right-of eDP1; \
xrandr --output VIRTUAL2 --mode 2560x1440 --right-of VIRTUAL1; \
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

# remove any modes if they are still there
# xrandr --delmode VIRTUAL1 2560x1440_60
# xrandr --delmode VIRTUAL3 2560x1440_60
# xrandr --rmmode 2560x1440_60

# now add the modes again
# xrandr --newmode "2560x1440_60"  312.25  2560 2752 3024 3488  1440 1443 1448 1493 -hsync +vsync
# xrandr --addmode VIRTUAL3 2560x1440_60
# xrandr --addmode VIRTUAL1 2560x1440_60
