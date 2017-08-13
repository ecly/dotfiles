# ALIASES
alias shutdown="systemctl poweroff"
alias vi="vim"
alias pdf="zathura"
alias poly="nohup sh ~/.config/polybar/launch.sh > /dev/null 2>&1 &"
alias rm="rm -I" # ask when deleting multiple
alias gsync="grive -p ~/GoogleDrive"
alias imgur"sh ~/Scripts/imgur.sh"
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

# Basic colored ls
alias ls="ls ${colorflag}"

# List all files colorized in long format
alias l="ls -lF ${colorflag}"

# List all files colorized in long format, including dot files
alias la="ls -laF ${colorflag}"

# List only directories
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'"


# Config editing binds
alias cfv="vim ~/.vimrc"
alias cfi="vim ~/.config/i3/config"
alias cfr="vim ~/.config/ranger/rc.conf"
alias cfm="vim ~/.muttrc"
alias cfp="vim ~/.config/polybar/config"
alias cfd="vim ~/.config/dunst/dunstrc"

# Use i3lock when afk
alias afk="sh ~/Scripts/lock.sh"

# Reload shell
alias reload="exec $SHELL -l"

# Get week number
alias week='date +%V'

# Sped up cd navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
