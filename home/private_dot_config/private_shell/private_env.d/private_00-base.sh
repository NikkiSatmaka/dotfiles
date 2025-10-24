#!/usr/bin/env sh

export ENV="${XDG_CONFIG_HOME:-$HOME/.config}/shell/env.sh"
export BASH_ENV="${XDG_CONFIG_HOME:-$HOME/.config}/shell/env.sh"

umask 0077
