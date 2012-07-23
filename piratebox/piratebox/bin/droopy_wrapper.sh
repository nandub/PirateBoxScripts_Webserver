#!/bin/bash

pid_file=${PIDFILE_DROOPY}

get_pid() {
        if [ -r "${pid_file}" ]; then
                cat "${pid_file}"
        else
                pgrep -f $PIRATEBOX/bin/droopy
        fi
}

if [ "$1" == "start" ]; then
    $PIRATEBOX/bin/droopy -H $HOST -d $UPLOADFOLDER -c "" -m "$DROOPY_TXT" $DROOPY_USERDIR  $DROOPY_PORT
else
    local PID=$(get_pid)
    [ -n "$PID" ] && kill $PID &> /dev/null
fi