#!/bin/bash
# Ring the terminal bell on this pane's tty so tmux sets the window bell flag
# (highlighted via window-status-bell-style in .tmux.conf; clears on visit).
# Hook stdout is captured by Claude Code, so the BEL must go to the tty itself.
if [ -n "$TMUX" ] && [ -n "$TMUX_PANE" ]; then
  pane_tty=$(tmux display-message -p -t "$TMUX_PANE" '#{pane_tty}' 2>/dev/null)
  if [ -n "$pane_tty" ] && [ -w "$pane_tty" ]; then
    printf '\a' > "$pane_tty" && exit 0
  fi
fi
# Fallback: controlling terminal (works when not in tmux too)
printf '\a' > /dev/tty 2>/dev/null || true
