# Function shortcuts for opening folder/files with various tools
function c() {
  if [ $# -eq 0 ]; then
    code .;
  else
    code "$@";
  fi;
}

function v() {
  if [ $# -eq 0 ]; then
    nvim .;
  else
    nvim "$@";
  fi;
}

# Use rifle for files and ranger for everything else
function r() {
  if [ $# -eq 0 ]; then
    ranger .;
  else
    if [[ -d $1 ]]; then
        ranger "$1";
    elif [[ -f $1 ]]; then
        rifle "$1";
    fi
  fi;
}

# Use vim as a pager
# If no input check if stdin was redirected and use vim's '-' for it
function vless() {
  if [ $# -eq 0 ]; then
      if [ -t 0 ]; then
        echo "At least one file expected"
      else
        nvim --noplugin -u ~/.vimrc.less -
      fi
  else
    if [[ -d $1 ]]; then
        echo "$1 is a directory"
    elif [[ -f $1 ]]; then
        nvim --noplugin -u ~/.vimrc.less "$1";
    fi
  fi;
}

# Open pdf and unbind it from the terminal session
function pdf() {
  if [ $# -eq 0 ]; then
    echo "At least one file expected"
  else
    zathura $1 & disown
  fi;
}

# Open intellij and unbind it from the terminal session
function idea() {
  if [ $# -eq 0 ]; then
    echo "At least one file or folder expected"
  else
    idea.sh $1 & disown
  fi;
}

function cpc() {
  if [ $# -eq 0 ]; then
    echo "Need a branch name"
  elif [ $# -gt 1 ]; then
    echo "Single param expected"
  else
    OLDBRANCH=`git rev-parse --abbrev-ref HEAD`
    git checkout $1; git pull; git checkout $OLDBRANCH
  fi;
}

function weather() {
  if [ $# -eq 0 ]; then
    echo "Need a country or city name"
  elif [ $# -gt 1 ]; then
    echo "A single country or city is expected"
  else
    curl -s wttr.in/$1 | head -n -2
  fi;
}

function twitch() {
    streamlink -p mpv twitch.tv/$@ best
}
