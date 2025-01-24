#!/bin/sh

PORT=${PORT:-"9999"}
TIMEOUT=${TIMEOUT:-"30"}
ACTIONS=${ACTIONS-}
API_KEY=${API_KEY-}
SECURE_KEY=${SECURE_KEY-}
MODE=${MODE-}

_LOG="[IP AUTODISCOVERY]"
if [ -z "$IP" ]; then
    echo "$_LOG IP isn't set, attempting autodiscovery"

    nslookup host.docker.internal > /dev/null
    if [ $? -eq 0 ]; then
        echo "$_LOG host.docker.internal detected, using it's IP"
        IP="$(nslookup -type=a host.docker.internal | awk '/Address/ {print $NF}' | awk 'END {print}')"
    else
        echo "$_LOG host.docker.internal isn't detected, using the default route"
        IP="$(hostname -i | awk '{print $NF}' | sed 's/\.[0-9]*$/.1/')"
    fi
fi

./run-iftop.sh &
exec ./sys_monitor_agent $IP $PORT $TIMEOUT --actions=$ACTIONS \
    --apikey=$API_KEY --securekey=$SECURE_KEY $MODE

