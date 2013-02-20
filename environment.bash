if [ -n "$(which mvim)" ]; then
  export EDITOR="mvim -v"
  alias v="mvim -v"
fi

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
