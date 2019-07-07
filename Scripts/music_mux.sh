#!/bin/sh
mpc random on
mpc repeat on
tmux -2 new-session -A -s ncmpcpp 'ncmpcpp -s browser'
tmux split-window -p 20 -v 'cava'\; last-pane
