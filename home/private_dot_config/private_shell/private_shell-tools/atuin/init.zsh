#!/usr/bin/env sh
# shellcheck shell=zsh

command -v atuin >/dev/null 2>&1 &&
eval "$(atuin init zsh)"
