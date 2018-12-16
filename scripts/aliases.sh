# ALIASES
alias dot='git --git-dir=$HOME/.dots.git/ --work-tree=$HOME' # dotfile handling
alias shutdown="systemctl poweroff"
alias {vi,vim}="nvim"
alias todo="nvim ~/Dropbox/IRL/todo.txt"
alias poly="nohup sh ~/.config/polybar/launch.sh > /dev/null 2>&1 &"
alias gsync="grive -p ~/GoogleDrive"
alias imgur="sh ~/scripts/imgur.sh"
alias mutt="sh ~/scripts/mutt.sh"

# .Xresources handling - reload, merge
alias xm="xrdb -merge ~/.Xresources"
alias xr="xrdb ~/.Xresources"

#Basically an ls replacement for tree
alias tree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'"

#A tree function for files as well
alias ftree="find | sed 's|[^/]*/|- |g'"

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
  colorflag="--color"
else # OS X `ls`
  colorflag="-G"
fi

# ask when deleting multiple
alias rm="rm -I"

# Basic colored ls
alias ls="ls ${colorflag}"

# List all files colorized in long format
alias l="ls -lF ${colorflag}"

# List all files colorized in long format, including dot files
alias la="ls -laF ${colorflag}"

# List only directories
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'"

# Some shorthand launching
alias t="tmux"
alias ta="tmux attach-session"
alias u="urxvt"

# All pagers except less bound to vless
alias {vl,more,most,view}="vless"

# Config editing binds
alias cfv="vim ~/.vimrc"
alias cfi="vim ~/.config/i3/config"
alias cfr="vim ~/.config/ranger/rc.conf"
alias cfm="vim ~/.muttrc"
alias cfp="vim ~/.config/polybar/config"
alias cfd="vim ~/.config/dunst/dunstrc"
alias cfx="vim ~/.Xresources"
alias cfz="vim ~/.zshrc"
alias cft="vim ~/.tmux.conf"

# Used for toggling colors for playing csgo
alias csgo="sh ~/scripts/vibrance.sh"

# Use i3lock when afk
alias afk="sh ~/scripts/lock.sh"

# Reload shell
alias reload="exec $SHELL -l"

# Used for grepping cars from the zipped
# Danish motorregister
alias cargrep="zgrep -B 10 -A 60 -m 1 -n"

# Get week number
alias week='date +%V'

# Sped up cd navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Creating scratch pad in case it was deleted (depends on i3 config)
alias scratch="urxvt -name scratch -e tmux & disown"

# Remove all local branches that 'gone' on the remote. Lanuguage dependent
# https://stackoverflow.com/questions/7726949/remove-local-branches-no-longer-on-remote/38404202#38404202
alias gprune= "git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -d"
