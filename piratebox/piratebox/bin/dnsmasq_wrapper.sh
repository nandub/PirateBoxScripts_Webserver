#!/bin/bash

. /etc/conf.d/dnsmasq

if [ "$1" == "start"]; then
    /usr/bin/dnsmasq "--user=${DNSMASQ_USER:-nobody}" \
    				 "--conf-file=${CONF_DNSMASQ}" \
    				 "--pid-file=${PIDFILE_DNSMASQ}" "${DNSMASQ_OPTS[@]}"
else
    kill `cat ${PIDFILE_DNSMASQ}`
fi