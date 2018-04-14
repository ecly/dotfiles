#!/bin/bash

# source wal colors so we can align output colors
# with those expected to be used by polybar
source "${HOME}/.cache/wal/colors.sh"
foreground_alt=$color2

if ps aux | rg "[o]penvpn" >&/dev/null; then
    echo %{F$foreground_alt}%{F-} on;
else
    echo %{F$foreground_alt}%{F-}%{F#f00} off%{F-};
fi
