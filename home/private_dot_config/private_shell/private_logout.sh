#!/usr/bin/env bash

# when leaving the console, clear the screen to increase privacy
if [ "$SHLVL" = 1 ]; then
  if command -v clear_console >/dev/null 2>&1; then
    clear_console -q
  fi
fi
