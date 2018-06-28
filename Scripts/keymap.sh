#!/bin/bash
if [ "$HOSTNAME" = trsh ]; then
    # On laptop swap alt and win
    setxkbmap -option altwin:swap_lalt_lwin
fi

# Always bind caps to escape and keybind to shuffle key layouts
setxkbmap -option caps:escape; setxkbmap -option grp:switch,grp:win_space_toggle,grp_led:scroll us,dk
