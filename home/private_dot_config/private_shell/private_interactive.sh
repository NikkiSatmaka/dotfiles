#!/usr/bin/env sh
# shellcheck shell=sh disable=SC1090,SC1091

# Phase 4: aliases
for f in "$XDG_CONFIG_HOME/shell/alias.d/"*.sh; do
  [ -r "$f" ] && . "$f"
done

# Phase 5: functions
for f in "$XDG_CONFIG_HOME/shell/functions.d/"*.sh; do
  [ -r "$f" ] && . "$f"
done

# Phase 6: post (prompt/completions that expect env & functions ready)
for f in "$XDG_CONFIG_HOME/shell/post.d/"*.sh; do
  [ -r "$f" ] && . "$f"
done
