#!/bin/sh
#
[ "${APPHOME}" = "" ] && export APPHOME=/app

do_signal_term()
{
    echo "PID($$) - Shutdown services due to SIGTERM received."
    sleep 1
    exit 0
}

#
# Main
#
trap do_signal_term 15 # Trap SIGTERM

# start main service
cd ${APPHOME}
node server.js &
nginx -g 'daemon off;' &

# Wait forever
while :; do
    [ -f /tmp/.pause ] && sleep 300 || sleep 30
done

exit 0
