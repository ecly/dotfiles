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

function r() {
  if [ $# -eq 0 ]; then
    ranger .;
  else
    ranger "$@";
  fi;
}
