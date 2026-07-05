#!/usr/bin/env sh
# shellcheck shell=zsh

command -v zoxide >/dev/null 2>&1 &&
eval "$(zoxide init zsh)"
