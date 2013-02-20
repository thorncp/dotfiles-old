if [ -n "$THORNCP_DOTFILES_DIR" ]; then
  echo "WARN: thorncp dotfiles have already been loaded. aborting"
  return
fi

export THORNCP_DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

include() {
  [[ -f "$THORNCP_DOTFILES_DIR/$1" ]] && source "$THORNCP_DOTFILES_DIR/$1"
}

include "colors.sh"
include "git-completion.bash"
include "prompt.bash"

if [ -n "$(which mvim)" ]; then
  export EDITOR="mvim -v"
  alias v="mvim -v"
fi

code() {
  cd ~/code/$1
}

_code() {
  # here be dragons
  # TODO: find/learn what utils will help me here

  local cur opts dir base
  cur="${COMP_WORDS[COMP_CWORD]}"

  # this is essentially a tweak of the dirname utility. it needs to treat a /
  # as a path element. example: `dirname project/` will return ".", but it is
  # more useful in this situation to return "project"
  if [[ "${cur}" == */* ]]; then
    dir="$(echo ${cur} | sed 's/\/[^\/]*$//')/"
  else
    dir=""
  fi

  # a tweak of the basename utility. it needs to treat a / as a path element.
  # example: `basename project/`, but it is more useful in this situation to
  # return an empty string
  base=$(echo ${cur} | sed 's/^\([^\/]*\/\)*//')

  opts=$(cd ~/code/${dir} ; ls -d */. | sed 's/\.//')
  COMPREPLY=($(compgen -P "${dir}" -W "${opts}" -- ${base}))
}
complete -o nospace -F _code code

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

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
