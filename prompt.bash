# red/green last process failure/success status
wrap_exit_status() {
  echo "\`if [[ \$? = '0' ]]; then echo '$IGreen'; else echo '$IRed'; fi\`$1$Color_Off"
}

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/$(parse_git_dirty)\1/"
}

export PS1="$(wrap_exit_status '\w') \$(~/.rvm/bin/rvm-prompt) $IYellow\$(parse_git_branch)$Color_Off\n\$ "
