autoload -Uz compinit promptinit
compinit
promptinit

# Utility function to determine whether command is executable or aliased.
_has() {
  return $( whence $1 >/dev/null )
}

# Enable desired plugins with oh my zsh
plugins=(git)
PROMPT='[%F{1}%n%f@%F{5}%m%f%F{3}%f]%F{6}~%f '

bindkey -v
bindkey '^R' history-incremental-search-backward

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
source "${HOME}/scripts/aliases.sh"

# Source aliases
source "${HOME}/scripts/functions.sh"

# Source completion for tmuxinator
source "${HOME}/.config/tmuxinator/tmuxinator.zsh"

# Used as directory for binaries for vim go plugin
export GOPATH="${HOME}/programming/go"
export GOBIN="${GOPATH}/bin"
export PATH=$GOBIN:$PATH

export PATH=~/.local/bin:$PATH

# Stop the lag in vi mode
export KEYTIMEOUT=1

# Set vim as editor, less as pager.
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"

# Don't log duplicate commands.
export HISTCONTROL=ignoredups

# installation directory
export OPAMROOT=~/opam-coq.8.6
export COQBIN=~/opam-coq.8.6/system/bin/

# node environment settings
export NODE_ENV="development"

# Opam setup
. /home/ecly/opam-coq.8.6/opam-init/init.zsh > /dev/null 2> /dev/null || true

# Import colorscheme from 'wal'
(cat ~/.cache/wal/sequences &)

# If folder fzf is present with pacman, source binds and completion
if [ -e /usr/share/fzf/key-bindings.zsh ]; then
    source /usr/share/fzf/key-bindings.zsh
    source /usr/share/fzf/completion.zsh
fi

# Use ag for fzf
# Uses same command for all binds - could make this for ALT_C
if _has fzf && _has rg; then
    export FZF_DEFAULT_COMMAND='rg --files --no-ignore --follow --glob "!.git/*"'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="cd ~/; rg --sort-files --files --null 2> /dev/null | xargs -0 dirname | uniq"

    # https://adamheins.com/blog/ctrl-p-in-the-terminal-with-fzf
    # This is the same functionality as fzf's ctrl-t, except that the file or
    # directory selected is now automatically cd'ed or opened, respectively.
    fzf-open-file-or-dir() {
      local cmd="command find -L . \
        \\( -path '*/\\.*' -o -fstype 'dev' -o -fstype 'proc' \\) -prune \
        -o -type f -print \
        -o -type d -print \
        -o -type l -print 2> /dev/null | sed 1d | cut -b3-"
      local out=$(eval $cmd | fzf-tmux --exit-0)

      if [ -f "$out" ]; then
        $EDITOR "$out" < /dev/tty
      elif [ -d "$out" ]; then
        cd "$out"
        zle reset-prompt
      fi
    }
    zle     -N   fzf-open-file-or-dir
    bindkey '^P' fzf-open-file-or-dir
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
