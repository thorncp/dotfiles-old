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
include "environment.bash"
include "prompt.bash"
include "note.bash"
include "code.bash"
