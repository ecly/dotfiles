#!/bin/bash
set -e

NATIVE_SCREEN="DP-2"
SECOND_SCREEN="DP-1.2"
THIRD_SCREEN="DP-1.3"
# patched xrandr for pixel perfect 2x scaling for 4k
PATCHED="$HOME/Scripts/xrandr/xrandr"

if ! xrandr --listmonitors | grep -q "$SECOND_SCREEN"; then
    echo "Setting up displays with XRANDR..."
    $PATCHED \
        --output "$NATIVE_SCREEN" --primary --crtc 0 --transform none --scale 1x1 --mode 3840x2160 \
        --output "$SECOND_SCREEN" --crtc 1 --transform none --scale 1x1 --mode 2560x1440 --right-of "$NATIVE_SCREEN" \
        --output "$THIRD_SCREEN" --crtc 2 --transform none --scale 1x1 --mode 2560x1440 --right-of "$SECOND_SCREEN"
fi
# autorandr --load docked

echo "Setting up keymap..."
sh "$HOME/Scripts/keymap.sh"

echo "Setting up i3 workspaces..."
sleep 2
i3-msg "workspace 1 output $SECOND_SCREEN" > /dev/null; \
i3-msg "workspace 2 output $THIRD_SCREEN" > /dev/null; \
i3-msg "workspace 3 output $NATIVE_SCREEN" > /dev/null; \
i3-msg "workspace 4 output $SECOND_SCREEN" > /dev/null; \

# These commands fail if already configured correctly
set +e
i3-msg "workspace 1, move workspace to output $SECOND_SCREEN" > /dev/null 2>&1
i3-msg "workspace 2, move workspace to output $THIRD_SCREEN" > /dev/null 2>&1
i3-msg "workspace 3, move workspace to output $NATIVE_SCREEN" > /dev/null 2>&1
i3-msg "workspace 4, move workspace to output $SECOND_SCREEN" > /dev/null 2>&1
set -e

echo "Setting up polybar..."
nohup sh ~/.config/polybar/launch.sh > /dev/null 2>&1 &

echo "Finished!"
