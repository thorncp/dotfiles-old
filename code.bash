# shortcut to cd into ~/code with ls-like tab completion
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
  # example: `basename project/` returns "project", but it is more useful in
  # this situation to return an empty string
  base=$(echo ${cur} | sed 's/^\([^\/]*\/\)*//')

  opts=$(cd ~/code/${dir} ; ls -d */. | sed 's/\.//')
  COMPREPLY=($(compgen -P "${dir}" -W "${opts}" -- ${base}))
}
complete -o nospace -F _code code
