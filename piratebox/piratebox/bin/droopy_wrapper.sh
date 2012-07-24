#!/bin/bash

. /opt/piratebox/conf/piratebox_env.conf

pidfile=${PIDFILE_DROOPY}

get_pid() {
    if [ -r "${pidfile}" ]; then
        cat "${pidfile}"
    else
        pgrep -f $PIRATEBOX/bin/droopy
    fi
}

if [ "$1" == "start" ]; then
    $PIRATEBOX/bin/droopy -H $HOST -d $UPLOADFOLDER -c "" -m "$DROOPY_TXT" $DROOPY_USERDIR  $DROOPY_PORT &
    if [ $? -gt 0 ]; then
		echo "droopy failed to start."
	else
		echo $! > "${pidfile}"
      	echo "droopy started."
    fi
else
    PID=$(get_pid)
    [ -n "$PID" ] && kill $PID &> /dev/null
    if [ $? -gt 0 ]; then
   		echo "droopy failed to stop."
    else
   		[ -f "${pidfile}" ] && rm -f "${pidfile}"
   		echo "droopy stopped."
    fi
fi