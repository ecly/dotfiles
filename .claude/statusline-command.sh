#!/bin/sh
# Claude Code statusLine command
# Left: cwd in cyan (with ~ home abbreviation)
# Right: rate-limit usage segment, right-aligned when terminal width is known

input=$(cat)
cwd=$(echo "$input" | jq -r '.cwd')

# Abbreviate home directory with ~
home="$HOME"
case "$cwd" in
  "$home"*) cwd="~${cwd#"$home"}" ;;
esac

CYAN='\033[36m'
RESET='\033[0m'
DIM='\033[2m'
YELLOW='\033[33m'
GREEN='\033[32m'
RED='\033[31m'
MAGENTA='\033[35m'

# Model + effort segment — model.display_name is always present; effort.level
# is present only when the current model supports reasoning effort.
model_name=$(echo "$input" | jq -r '.model.display_name // empty')
effort_level=$(echo "$input" | jq -r '.effort.level // empty')

# Build the model segment (colored) and a plain version for width measurement.
model_seg=""
model_seg_plain=""
if [ -n "$model_name" ]; then
  if [ -n "$effort_level" ]; then
    model_seg=$(printf "${DIM}[${RESET}${MAGENTA}%s${RESET} ${DIM}·${RESET} %s${DIM}]${RESET}" "$model_name" "$effort_level")
    model_seg_plain=$(printf '[%s · %s]' "$model_name" "$effort_level")
  else
    model_seg=$(printf "${DIM}[${RESET}${MAGENTA}%s${RESET}${DIM}]${RESET}" "$model_name")
    model_seg_plain=$(printf '[%s]' "$model_name")
  fi
fi

# Rate limit segment — omitted entirely if fields are absent (before first API response)
five_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
week_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

if [ -z "$five_pct" ] || [ -z "$week_pct" ]; then
  # No rate limit data yet — print cwd, plus the model segment if available
  if [ -n "$model_seg" ]; then
    printf "${CYAN}%s${RESET} %s" "$cwd" "$model_seg"
  else
    printf "${CYAN}%s${RESET}" "$cwd"
  fi
else
  five_int=$(printf '%.0f' "$five_pct")
  week_int=$(printf '%.0f' "$week_pct")

  # Color each percentage by severity: <70 green, 70-89 yellow, 90+ red
  if [ "$five_int" -ge 90 ]; then
    five_color="$RED"
  elif [ "$five_int" -ge 70 ]; then
    five_color="$YELLOW"
  else
    five_color="$GREEN"
  fi

  if [ "$week_int" -ge 90 ]; then
    week_color="$RED"
  elif [ "$week_int" -ge 70 ]; then
    week_color="$YELLOW"
  else
    week_color="$GREEN"
  fi

  # Build the plain-text versions to measure visible widths (no ANSI codes).
  # The model segment (if any) sits just left of the rate-limit segment.
  rate_plain=$(printf '[5h %d%% | wk %d%%]' "$five_int" "$week_int")
  if [ -n "$model_seg_plain" ]; then
    right_plain="$model_seg_plain $rate_plain"
  else
    right_plain="$rate_plain"
  fi
  left_plain="$cwd"

  # Detect terminal width: $COLUMNS, then tput, then stty (subshell required so
  # the failed </dev/tty redirection is inside the subshell and 2>/dev/null suppresses it)
  if [ -n "$COLUMNS" ] && [ "$COLUMNS" -gt 0 ] 2>/dev/null; then
    width="$COLUMNS"
  else
    width=$(tput cols 2>/dev/null)
    if [ -z "$width" ]; then
      width=$( (stty size </dev/tty) 2>/dev/null | awk '{print $2}' )
    fi
  fi

  left_len=${#left_plain}
  right_len=${#right_plain}

  if [ -n "$width" ] && [ "$width" -gt 0 ]; then
    # Leave 3 columns: 2 for Claude Code's statusline left indent plus 1 right margin
    available=$((width - 3))
    gap=$((available - left_len - right_len))
  else
    gap=0
  fi

  # Prefix the model segment (with trailing space) when present
  if [ -n "$model_seg" ]; then
    model_prefix="$model_seg "
  else
    model_prefix=""
  fi

  if [ "$gap" -gt 0 ]; then
    # Right-aligned: cwd, padding spaces, model segment, usage segment
    padding=$(printf '%*s' "$gap" '')
    printf "${CYAN}%s${RESET}%s%s${DIM}[${RESET}${DIM}5h${RESET} ${five_color}%d%%${RESET} ${DIM}|${RESET} ${DIM}wk${RESET} ${week_color}%d%%${RESET}${DIM}]${RESET}" \
      "$cwd" "$padding" "$model_prefix" "$five_int" "$week_int"
  else
    # Fallback: cwd, single space, model segment, usage segment
    printf "${CYAN}%s${RESET} %s${DIM}[${RESET}${DIM}5h${RESET} ${five_color}%d%%${RESET} ${DIM}|${RESET} ${DIM}wk${RESET} ${week_color}%d%%${RESET}${DIM}]${RESET}" \
      "$cwd" "$model_prefix" "$five_int" "$week_int"
  fi
fi
