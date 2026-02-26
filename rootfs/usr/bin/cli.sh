#!/bin/bash

# Print banner (best-effort)
ha banner || true

# Set rcfile to drive an interactive Bash as our REPL
RC_FILE=/etc/ha-cli/.repl_rc

if command -v ha >/dev/null 2>&1; then
  completion_file_content=$(ha completion bash 2>/dev/null || true)
  if [ -n "$completion_file_content" ]; then
    echo "$completion_file_content" >/etc/bash_completion.d/ha 2>/dev/null || true
  fi
fi


# Start interactive bash with our rcfile; no user profiles
exec bash --noprofile --rcfile "$RC_FILE" -i
