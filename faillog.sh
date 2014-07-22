faillog() {
  if [ -e $1 ]; then
    $EDITOR ~/faillog.md
    return 0
  fi

  echo "$(date +"%Y-%m-%d %H:%M:%S") - $*" >> ~/faillog.md
}
