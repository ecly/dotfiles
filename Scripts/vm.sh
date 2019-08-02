# cvt 3440 1440 60
# 3440x1440 59.94 Hz (CVT) hsync: 89.48 kHz; pclk: 419.50 MHz
# Modeline "3440x1440_60.00"  419.50  3440 3696 4064 4688  1440 1443 1453 1493 -hsync +vsync

xrandr --newmode "1440p"  419.11  3440 3688 4064 4688  1440 1441 1444 1490  -HSync +Vsync; \
xrandr --addmode Virtual1 1440p; \
xrandr --output Virtual1 --mode 1440p; \
sh ~/.config/polybar/launch.sh
