#!/bin/bash 
scheme=$(cat ~/.cache/wal/wal)
scheme=${scheme/./_} #replace . with _
ext=".json"
wal -f "${HOME}/.cache/wal/schemes/$scheme$ext"
