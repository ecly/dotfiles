#!/bin/bash 

# Generate correct path for last used colorscheme
scheme=$(cat ~/.cache/wal/wal)
scheme=${scheme/./_} #replace . with _
ext=".json"

wal -f "${HOME}/.cache/wal/schemes/$scheme$ext" 
