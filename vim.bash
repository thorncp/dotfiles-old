update-vim-bundles() {
  ls -d ~/.vim/bundle/* |
  while read dir; do
    printf "$(basename $dir): "
    cd $dir
    git pull
  done
}

alias ve="$EDITOR $(thorncp-file .vimrc)"
