#!/bin/bash

set -euo pipefail
PIDFILES=($(compgen -G "/tmp/flutter*.pid"))

trap 'pkill -P $$; exit' SIGINT SIGTERM

if [[ "${1-}" != "" && ${#PIDFILES[@]} > 0 ]]; then
    echo $1
    PIDS=""
    for pf in ${PIDFILES[@]}; do
        PIDS+=$(cat $pf)
        PIDS+=" "
    done
    if [[ "$1" =~ \/assets\/ || "$1" =~ \/state\/ || "$1" =~ backend ]]; then
        echo "Flutter - Restarting ${PIDS}"
        kill -USR2 $PIDS
    else
        echo "Flutter - Reloading ${PIDS}"
        kill -USR1 $PIDS
    fi
fi