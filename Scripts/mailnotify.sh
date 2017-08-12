#!/bin/bash

# Expected input
# $1 Number of new
# $2 Number of unread

sound=~/Scripts/ding.ogx
volume=40000 # value between 0 and 65536

notify-send 'New Email' "$1 new messages, $2 unread."\
&& paplay --volume $volume $sound &
