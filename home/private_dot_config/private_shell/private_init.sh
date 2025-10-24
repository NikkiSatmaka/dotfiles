#!/usr/bin/env sh
# shellcheck shell=sh disable=SC1090,SC1091

# Ensure XDG defaults early
: "${XDG_CONFIG_HOME:=$HOME/.config}"
: "${XDG_CACHE_HOME:=$HOME/.cache}"
: "${XDG_DATA_HOME:=$HOME/.local/share}"

# Phase 1: core helpers for use in env.d
for f in "$XDG_CONFIG_HOME/shell/lib.d/"*.sh; do
  [ -r "$f" ] && . "$f"
done

# Phase 2: environment (can now use helpers)
for f in "$XDG_CONFIG_HOME/shell/env.d/"*.sh; do
  [ -r "$f" ] && . "$f"
done

# Phase 3: aliases
for f in "$XDG_CONFIG_HOME/shell/alias.d/"*.sh; do
  [ -r "$f" ] && . "$f"
done

# Phase 4: functions
for f in "$XDG_CONFIG_HOME/shell/functions.d/"*.sh; do
  [ -r "$f" ] && . "$f"
done

# Phase 5: post (prompt/completions that expect env & functions ready)
for f in "$XDG_CONFIG_HOME/shell/post.d/"*.sh; do
  [ -r "$f" ] && . "$f"
done
