# opens a date stamped file whose name is based on the args given
note() {
  if [ -e $1 ]; then
    echo "No name given"
    echo "Usage: note <name>"
    return 1
  fi

  concatted=$*
  trimmed=${concatted//[^a-zA-Z0-9]/-}
  file="$trimmed-$(date +"%Y-%m-%d").md"

  $EDITOR $file
}

tmp() {
  $EDITOR ~/tmp.md
}
