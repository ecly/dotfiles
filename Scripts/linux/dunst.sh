#!/usr/bin/env bash

reload_dunst() {
    pkill dunst
    dunst -config ~/.config/dunst/dunstrc
}

main() {
    reload_dunst &
}

main
