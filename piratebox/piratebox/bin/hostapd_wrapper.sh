#!/bin/bash

if [ "$1" == "start" ]; then
    /usr/bin/hostapd -B -P ${PIDFILE_HOSTAPN} ${CONF_APN} &>/dev/null
else
    kill `cat ${PIDFILE_HOSTAPN}`
fi