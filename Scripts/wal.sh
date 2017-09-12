#!/bin/bash 

# Generate correct path for last used colorscheme
scheme=$(cat ~/.cache/wal/wal)
scheme=${scheme//\//_} #replace all / with _
scheme=${scheme/./_} #replace single . with _
ext=".json"

echo "$scheme"
wal -n -f "${HOME}/.cache/wal/schemes/$scheme$ext" 
