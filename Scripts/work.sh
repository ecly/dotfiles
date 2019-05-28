. /home/ecly/Scripts/keymap.sh; \
xset b off; \
optirun intel-virtual-output; \
sleep 4; \
mons -m; \
nohup sh ~/.config/polybar/launch.sh > /dev/null 2>&1 & # rerun polybar
