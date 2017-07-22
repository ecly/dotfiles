wal -i "$(< "${HOME}/.cache/wal/wal")"
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
exec i3
