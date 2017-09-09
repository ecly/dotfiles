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
    vim .;
  else
    vim "$@";
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
function vless() {
  if [ $# -eq 0 ]; then
    echo "At least one file expected"
  else
    if [[ -d $1 ]]; then
        echo "$1 is a directory"
    elif [[ -f $1 ]]; then
        vim --noplugin -u ~/.vimrc.less "$1";
    fi
  fi;
}
