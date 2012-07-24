#!/bin/bash

. /opt/piratebox/conf/piratebox_env.conf

if [ "$1" == "start" ]; then
    /usr/bin/hostapd -B -P ${PIDFILE_HOSTAPN} ${CONF_APN} &>/dev/null
    if [ $? -gt 0 ]; then
      echo "hostapd failed to start."
    else
      echo "hostapd started."
    fi
else
	[ -f ${PIDFILE_HOSTAPN} ] && kill `cat ${PIDFILE_HOSTAPN}` &> /dev/null
    if [ $? -gt 0 ]; then
      echo "hostapd failed to stop."
    else
      echo "hostapd stopped."
    fi
fi