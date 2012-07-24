#!/bin/bash

. /opt/piratebox/conf/piratebox_env.conf

. /etc/conf.d/dnsmasq

checkconfig() {
  local testout

  if ! testout=$(/usr/bin/dnsmasq --test 2>&1); then
    echo "$testout"
    return 1
  fi

  return 0
}

pidfile=${PIDFILE_DNSMASQ}
if [[ -r $pidfile ]]; then
  read -r PID < "$pidfile"
  if [[ ! -d /proc/$PID ]]; then
    # stale pidfile
    unset PID
    rm -f "$pidfile"
  fi
fi

if [ "$1" == "start" ]; then
    if [[ -z $PID ]] && checkconfig &&
        /usr/bin/dnsmasq "--user=${DNSMASQ_USER:-nobody}" \
                          "--pid-file=$pidfile" \
                          "${DNSMASQ_OPTS[@]}"; then
        echo "dnsmasq started."
    else
        echo "dnsmasq failed to start."
    fi
else
    if [[ $PID ]] && kill "$PID" &> /dev/null; then
      # dnsmasq doesn't clean up after itself
        rm -f "$pidfile"
        echo "dnsmasq stopped."
    else
    	echo "dnsmasq failed to stop."
    fi
fi