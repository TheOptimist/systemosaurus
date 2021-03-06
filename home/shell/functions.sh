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
