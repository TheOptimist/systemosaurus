function config() {
  cd "${XDG_CONFIG_HOME}/$1"
}

function weather() {
  CITY="Ottawa"
  if [[ -v $1 ]]; then $LOCATION = "$1"; fi
  curl wttr.in/${LOCATION}?format=3
}

function checkip() {
  curl checkip.amazonaws.com
}

function guid() {
  if [ $(which pbcopy) ]; then
    uuidgen | tr -d '\r\n' | pbcopy
  fi
}

function kterm() {
  for server in "$@"; do
    # ktty is an alias defined elsewhere
    scp -q $(ktty) $server:~/kitty.terminfo
    ssh -q $server 'tic -xe xterm-kitty ~/kitty.terminfo'
    ssh -q $server 'sudo tic -xe xterm-kitty ~/kitty.terminfo'
    ssh -q $server 'rm ~/kitty.terminfo'
  done
}