#!/bin/bash
CFG="${HOME}/.cache/wal/colors-rofi-light.rasi"
# argument $1 expected to be window/run
exec rofi -show $1 -config $CFG
