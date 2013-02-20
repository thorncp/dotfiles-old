dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

install() {
  if [[ -f ~/$1 ]]; then
    printf "$1 exists, overwrite? (y/n) "
    read -n 1 reply
    echo

    if [ $reply == y ]; then
      backup="$1.$(date +"%Y-%m-%d-%H-%M-%S")"
      echo "Backing up to ~/$backup"
      mv ~/$1 ~/$backup
      ln -s $dir/$1 ~/$1
    fi
  else
    ln -s $dir/$1 ~/$1
  fi
}

install .vimrc
install .gitconfig

base="$dir/base.bash"
if grep -q "$base" ~/.bash_profile ; then
  echo ".bash_profile already sources $base"
else
  printf "Add source line to ~/.bash_profile? (y/n) "
  read -n 1 reply
  echo

  [[ $reply == y ]] && echo -e "\nsource $base" >> ~/.bash_profile
fi
