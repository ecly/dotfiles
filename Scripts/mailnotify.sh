#!/bin/bash

# Expected input
# $1 Number of new
# $2 Number of unread

sound=~/Scripts/ding.ogx
volume=40000 # value between 0 and 65536
current_mailbox=$1

# don't notify if no new/unread messages
if [$2 != "0"] && [$3 != "0"]
then
    notify-send "New Email" "$2 new messages, $3 unread."\
    && paplay --volume $volume $sound &
fi
