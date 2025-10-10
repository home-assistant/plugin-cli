# CLI for the Home Assistant Operating System

This is for the Home Assistant Operating System and is the login shell.

## REPL behavior

- Interactive prompt is a Bash-based REPL (no rlwrap required) with history persisted to `/tmp/.cli_history`.
- You can type commands without the leading `ha`; e.g. `core info` is equivalent to `ha core info`.
- Type `login` to exit to the underlying OS shell, or `exit` to quit.

## Bash completion

- Tab completion is available inside the REPL.
- The REPL loads the official completion by evaluating `ha completion bash` at startup and wires Tab to use it.
- If `ha completion bash` isn't supported by the installed `ha` binary, the REPL runs without completion.

To inspect or use the completion outside the REPL, you can generate it directly:

```
ha completion bash
```

You can add it to your environment by evaluating it in your shell profile, for example:

```
eval "$(ha completion bash)"
```
