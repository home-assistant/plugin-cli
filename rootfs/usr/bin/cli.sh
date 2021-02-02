#!/bin/bash

ha banner | true

# Run CLI
COMMAND=""
while true; do
    # shellcheck disable=SC2016
    COMMAND="$(rlwrap -S $'\e[32mha > \e[0m' -H /tmp/.cli_history sh -c 'read -r CMD && echo $CMD')"

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
