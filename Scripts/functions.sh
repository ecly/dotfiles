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
