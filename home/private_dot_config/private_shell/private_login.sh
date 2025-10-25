#!/usr/bin/env sh
# shellcheck shell=sh disable=SC1090,SC1091

# Phase 3: logins
for f in "$XDG_CONFIG_HOME/shell/login.d/"*.sh; do
  [ -r "$f" ] && . "$f"
done
