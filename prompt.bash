# red/green last process failure/success status
wrap_exit_status() {
  echo "\`if [[ \$? = '0' ]]; then echo '$IGreen'; else echo '$IRed'; fi\`$1$Color_Off"
}

function parse_git_branch {
  [ -e .git/HEAD ] && cat .git/HEAD | cut -d / -f3-
}

export PS1="$(wrap_exit_status '\w') $IYellow\$(parse_git_branch)$Color_Off\n\$ "
