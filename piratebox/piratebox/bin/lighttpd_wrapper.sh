#!/bin/bash

. /opt/piratebox/conf/piratebox_env.conf

pidfile=${PIDFILE_LIGHTTPD}

get_pid() {
    if [ -r "${pidfile}" ]; then
        cat "${pidfile}"
    else
        pgrep -f /usr/sbin/lighttpd-angel
    fi
}

test_config() {
	echo 'Checking configuration'
	if [ $(id -u) -ne 0 ]; then
		echo '(This script must be run as root)'
		exit 1
	fi

        if [ ! -r ${CONF_LIGHTTPD} ]; then
		echo '(${CONF_LIGHTTPD} not found)'
		exit 1
	fi

    /usr/sbin/lighttpd -t -f ${CONF_LIGHTTPD} >/dev/null 2>&1
	if [ $? -gt 0 ]; then
		echo '(error in ${CONF_LIGHTTPD})'
		exit 1
	fi
	echo "Done testing configuration"
}

if [ "$1" == "start" ]; then
    PID=$(get_pid)
	if [ -z "$PID" ]; then
		nohup /usr/sbin/lighttpd-angel -D -f ${CONF_LIGHTTPD} >>/var/log/lighttpd/lighttpd-angel.log 2>&1 &
		if [ $? -gt 0 ]; then
			echo "lighttpd failed to start."
		else
			echo $! > "${pidfile}"
       		echo "lighttpd started."
       	fi
    else
        echo "lighttpd failed to start."
    fi
else
    PID=$(get_pid)
    [ -n "$PID" ] && kill $PID &> /dev/null
    if [ $? -gt 0 ]; then
   		echo "lighttpd failed to stop."
    else
   		[ -f "${pidfile}" ] && rm -f "${pidfile}"
   		echo "lighttpd stopped."
    fi
fi