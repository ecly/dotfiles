#!/bin/sh 

# start session or attach if exists
tmux new-session -A -d -s 'code'

# setup the splits
tmux split-window -h
tmux split-window -v 

# set the active pane to the editor one
tmux select-pane -t 0

# attach to the created session
tmux -2 attach-session -t 'code'
