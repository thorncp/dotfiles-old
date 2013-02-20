function pg_restart {
  launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
  launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
}

function pg_start {
  pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start
}

function pg_stop {
  pg_ctl -D /usr/local/var/postgres stop -s -m fast
}
