#!/bin/bash

# Always bind caps to escape and keybind to shuffle key layouts
setxkbmap -option caps:escape; setxkbmap -option grp:switch,grp:win_space_toggle,grp_led:scroll us,dk

# Make sure beeping is disabled
xset b off
