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
else
    PID=$(get_pid)
    [ -n "$PID" ] && kill $PID &> /dev/null
fi