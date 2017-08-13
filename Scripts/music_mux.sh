#!/bin/sh 
tmux new-session -d 'ncmpcpp'
tmux split-window -p 20 -v 'cava'\; last-pane
tmux -2 attach-session -d   
tmux swap-pane
