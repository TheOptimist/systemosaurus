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

function swap_ssh_host() {
  if [[ -z "${1+x}" ]]; then
    echo "Hostname is mandatory"
    return 1
  fi
  local -r host="$1"
  local -r old_hostname="$( grep -w $host -A 3 ~/.ssh/config.local | awk '/HostName/ {print $2}' )"
  local -r new_hostname="$2"
  
  if [[ -n "${new_hostname+x}" ]]; then

    if [[ "$3" == "--dry-run" ]]; then
      sed "s/^HostName ${old_hostname}$/HostName ${new_hostname}/" ~/.ssh/config.local
    else
      local -r new_config="$(sed "s/HostName ${old_hostname}/HostName ${new_hostname}/" ~/.ssh/config.local)"
      if [[ $? ]]; then
        echo "${new_config}" > ~/.ssh/config.local
      fi
      
      local -r new_known_hosts="$(sed "/^$old_hostname/d" ~/.ssh/known_hosts)"
      if [[ $? ]]; then
        echo "${new_known_hosts}" > ~/.ssh/known_hosts
      fi
    fi

  fi
}