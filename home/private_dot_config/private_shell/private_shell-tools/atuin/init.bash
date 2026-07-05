#!/usr/bin/env sh
# shellcheck shell=bash disable=SC1090,SC1091,SC2034

command -v atuin >/dev/null 2>&1 &&
eval "$(atuin init bash)"
