#!/bin/bash

# source wal colors so we can align output colors
# with those expected to be used by polybar
source "${HOME}/.cache/wal/colors.sh"
foreground_alt="$color2"

on_msg="%{F$foreground_alt}%{F-} on"
off_msg="%{F$foreground_alt}%{F-}%{F#f00} off%{F-}"

if ! [ -x "$(command -v mullvad)" ]; then
    echo "$off_msg"
fi

if mullvad status | grep "Connected" >&/dev/null; then
    echo "$on_msg"
else
    echo "$off_msg"
fi
