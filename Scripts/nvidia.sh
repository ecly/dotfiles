#!/bin/bash 

if [ "$HOSTNAME" = ecly ]; then
    nvidia-settings --assign CurrentMetaMode="HDMI-0: nvidia-auto-select +0+0 { ForceFullCompositionPipeline=On }, DVI-I-1: 1920x1080_144 +1920+0 { ForceFullCompositionPipeline=On }, DP-0: nvidia-auto-select +3840+0 { ForceFullCompositionPipeline = On, Rotation=Right}"
fi
