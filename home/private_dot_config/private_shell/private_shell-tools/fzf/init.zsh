#!/usr/bin/env sh
# shellcheck shell=zsh

command -v fzf >/dev/null 2>&1 &&
source <(fzf --zsh)
