#!/bin/bash

# Expected input
# $1 Mailbox name
# $2 Number of new
# $3 Number of unread

sound=~/Scripts/ding.ogx
volume=40000 # value between 0 and 65536
current_mailbox=$1
new_messages=$2
unread_messages=$3

# don't notify if no new messages
if [ $new_messages -ne 0 ]
then
    notify-send "New Email in $current_mailbox" "$2 new messages, $3 unread."\ && paplay --volume $volume $sound &
fi
