#!/bin/bash

cat /etc/welcome.txt
echo "172.30.32.2 supervisor" >> /etc/hosts

# Set Token
# shellcheck disable=SC2155
export SUPERVISOR_TOKEN=$(cat /etc/machine-id)

# Run CLI
COMMAND=""
while true; do
    read -rp "ha > " COMMAND

    # Abort to host?
    if [ "$COMMAND" == "login" ]; then
        exit 10
    elif [ "$COMMAND" == "exit" ]; then
        exit
    fi

    # shellcheck disable=SC2086
    ha $COMMAND
    echo ""
done
