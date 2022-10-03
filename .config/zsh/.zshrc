# Set up completion
autoload -Uz compinit promptinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
promptinit
_comp_options+=(globdots) # Include hidden files.

# store history in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.cache/zsh/history"

# ensure this is set before antibody inits
CLOUDSDK_HOME="$HOME/.local/share/google-cloud-sdk"
source <(antibody init)

# configure default added keys for ssh-agent plugin
zstyle :omz:plugins:ssh-agent identities azure_devops_rsa bitbucket
# avoid problematic behavior with zsh-poetry plugin overrides
ZSH_POETRY_OVERRIDE_SHELL=0

antibody bundle < ~/.config/zsh/antibody_plugins.txt

PROMPT='[%F{1}%n%f@%F{5}%m%f%F{3}%f]%F{6}~%f '

# Setup vi mode
bindkey -v

# Change cursor with support for inside/outside tmux
function _set_cursor() {
    if [[ $TMUX = '' ]]; then
      echo -ne $1
    else
      echo -ne "\ePtmux;\e\e$1\e\\"
    fi
}

function _set_block_cursor() { _set_cursor '\e[2 q' }
function _set_beam_cursor() { _set_cursor '\e[6 q' }

function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
      _set_block_cursor
  else
      _set_beam_cursor
  fi
}
zle -N zle-keymap-select
# ensure beam cursor when starting new terminal
precmd_functions+=(_set_beam_cursor) #
# ensure insert mode and beam cursor when exiting vim
zle-line-init() { zle -K viins; _set_beam_cursor }

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

bindkey -v '^?' backward-delete-char

bindkey '^R' history-incremental-search-backward

autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Source colors generated by wal.
source "${HOME}/.cache/wal/colors.sh"

# Source aliases
source "${HOME}/.config/zsh/aliasrc"

# Source functions
source "${HOME}/.config/zsh/functionrc"

# Source completion for tmuxinator
source "${HOME}/.config/tmuxinator/tmuxinator.zsh"

# Source any machine local configuration
if [ -f "${HOME}/.profile" ]; then source "${HOME}/.profile"; fi

# Import colorscheme from 'wal'
(cat "$HOME/.cache/wal/sequences" &)

# If folder fzf is present with pacman, source binds and completion
if [ -e /usr/share/fzf/key-bindings.zsh ]; then
    source /usr/share/fzf/key-bindings.zsh
    source /usr/share/fzf/completion.zsh
fi

# NVM sourcing: https://aur.archlinux.org/packages/nvm
if [ -e /usr/share/nvm/init-nvm.sh ]; then
  source /usr/share/nvm/init-nvm.sh
fi

# Use ag for fzf
# Uses same command for all binds - could make this for ALT_C
# Utility function to determine whether command is executable or aliased.
_has() {
  return $( whence $1 >/dev/null )
}
if _has fzf && _has rg; then
    export FZF_DEFAULT_COMMAND='rg --files --follow --glob "!.git/*"'
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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/ecly/.local/share/google-cloud-sdk/path.zsh.inc' ]; then . '/home/ecly/.local/share/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/ecly/.local/share/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/ecly/.local/share/google-cloud-sdk/completion.zsh.inc'; fi

bindkey '^ ' autosuggest-accept # use ctrl+space to accept auto-suggestions

# Automatically load pyenv
if _has pyenv; then
    eval "$(pyenv init -)"
fi


