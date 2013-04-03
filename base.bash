if [ -n "$THORNCP_DOTFILES_DIR" ]; then
  echo "WARN: thorncp dotfiles have already been loaded. aborting"
  return
fi

export THORNCP_DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

thorncp-file() {
  [[ -z $1 ]] && return 1
  echo "$THORNCP_DOTFILES_DIR/$1"
}

include() {
  [[ -z $1 ]] && return 1
  [[ -f "$(thorncp-file $1)" ]] && source "$(thorncp-file $1)"
}

include "colors.sh"
include "git-completion.bash"
include "git-utils.bash"
include "environment.bash"
include "prompt.bash"
include "note.bash"
include "code.bash"
include "postgres.bash"
include "vim.bash"
include "cli_rage.sh"
