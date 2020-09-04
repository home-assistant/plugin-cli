#!/bin/bash

cat /etc/welcome.txt

# Run CLI
COMMAND=""
while true; do
    echo -n $'\e[32mha > \e[0m'
    COMMAND="$(rlwrap -H /tmp/.cli_history sh -c 'read -r CMD && echo $CMD')"

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
