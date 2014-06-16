code() {
  if [ $# -eq 0 ]; then
    cd $(find ~/code -maxdepth 2 -type d | selecta)
  else
    cd $(find ~/code -maxdepth 2 -type d | selecta -s "$@")
  fi
  clear
}

if command -v python > /dev/null; then
  alias json='python -mjson.tool'
fi
