#!/bin/bash

pid_file=${PIDFILE_LIGHTTPD}

get_pid() {
        if [ -r "${pid_file}" ]; then
                cat "${pid_file}"
        else
                pgrep -f /usr/sbin/lighttpd
        fi
}

if [ "$1" == "start" ]; then
    /usr/sbin/lighttpd -f $CONF_LIGHTTPD 2>&1 &
else
    local PID=$(get_pid)
    [ -n "$PID" ] && kill $PID &> /dev/null
fi