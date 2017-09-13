# Enable desired plugins with oh my zsh
plugins=(git)
PROMPT='[%F{1}%n%f@%F{5}%m%f%F{3}%f]%F{6}~%f '

bindkey -v

vim_ins_mode="%F{2}[INS]%f"
vim_cmd_mode="%F{1}[CMD]%f"
vim_mode=${vim_ins_mode}

function zle-keymap-select {
  vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
  RPROMPT=${vim_mode}
  zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-finish {
  vim_mode=$vim_ins_mode
}
zle -N zle-line-finish
RPROMPT=${vim_mode}

# Fix a bug when you C-c in CMD mode and you'd be prompted with CMD mode indicator, while in fact you would be in INS mode
# Fixed by catching SIGINT (C-c), set vim_mode to INS and then repropagate the SIGINT, so if anything else depends on it, we will not break it
# Thanks Ron! (see comments)
function TRAPINT() {
  vim_mode=$vim_ins_mode
  return $(( 128 + $1 ))
} 

# Source colors generated by wal.
source "${HOME}/.cache/wal/colors.sh"

# Source aliases
source "${HOME}/Scripts/aliases.sh"

# Source aliases
source "${HOME}/Scripts/functions.sh"

# Used as directory for binaries for vim go plugin
export GOPATH="${HOME}/Programming/go"
export GOBIN="${GOPATH}/bin"

# Stop the lag in vi mode
export KEYTIMEOUT=1

# Set vim  as editor.
export EDITOR="vim"
#
# Use less as pager (this is alised in ~/Scripts/functions.sh)
export PAGER="less"

# Don't log duplicate commands.
export HISTCONTROL=ignoredups

# Import colorscheme from 'wal'
[[ -z "$VTE_VERSION" ]] && (wal -r &)

autoload -Uz promptinit 
promptinit
