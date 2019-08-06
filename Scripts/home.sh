sh /home/ecly/Scripts/keymap.sh; \
xset b off; \
optirun intel-virtual-output; \
sleep 4; \
xrandr --output VIRTUAL3 --auto --mode VIRTUAL3.449-3440x1440 --primary; \
xrandr --output eDP1 --off; \
nohup sh ~/.config/polybar/launch.sh > /dev/null 2>&1 & # rerun polybar
