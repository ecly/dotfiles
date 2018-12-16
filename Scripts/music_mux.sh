#!/bin/sh
mpc random on
mpc repeat on
tmux new-session -d 'ncmpcpp -s browser'
tmux split-window -p 20 -v 'cava'\; last-pane
tmux -2 attach-session -d
