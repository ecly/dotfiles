#!/bin/sh 

tmux new-session -d -s 'code'
tmux split-window -h
tmux split-window -v 
tmux -2 attach-session -t 'code'
tmux select-pane -t 0
tmux swap-pane
tmux select-pane -t 0
