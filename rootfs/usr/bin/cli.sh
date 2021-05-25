#!/bin/bash

ha banner || true

# Run CLI
COMMAND=""
while true; do
    COMMAND="$(rlwrap -S $'\e[32mha > \e[0m' -H /tmp/.cli_history -o cat)"

    # Abort to host?
    if [ "$COMMAND" == "login" ]; then
        exit 10
    elif [ "$COMMAND" == "exit" ]; then
        exit
    fi

    echo "$COMMAND" | xargs ha
    echo ""
done
