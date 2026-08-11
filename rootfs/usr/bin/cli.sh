#!/bin/bash

# Print banner (best-effort)
ha banner || true

# Start interactive bash with our rcfile as REPL; no user profiles
exec bash --noprofile --rcfile /etc/ha-cli/.repl_rc -i
