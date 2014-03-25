# delete git branches that don't exist on a remote. only checks branch names.
cleanhouse() {
  read -n 1 -p "This will destructively delete branches. Are you sure? (y/n) " prompt
  echo
  if [ $prompt != y ]; then
    echo "aborting"
    return
  fi

  git fetch
  git branch |
  grep -vE '\*|master' |
  while read branch; do
    if [ $(git branch -r | grep -c $branch) = 0 ]; then
      git branch -d $branch
    fi
  done
}

if [ -n $(which hub) ]; then
  eval "$(hub alias -s)"
fi

if [ -n $(which gist) ]; then
  alias gist="gist -c -p"
fi
