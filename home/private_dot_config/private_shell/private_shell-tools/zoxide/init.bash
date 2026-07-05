#!/usr/bin/env sh
# shellcheck shell=bash disable=SC1090,SC1091,SC2034

command -v zoxide >/dev/null 2>&1 &&
eval "$(zoxide init bash)"
