#!/usr/bin/env sh
# shellcheck shell=bash disable=SC1090,SC1091,SC2034

# Reuse POSIX init
. "${XDG_CONFIG_HOME:-$HOME/.config}/shell/init.sh"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source  "${XDG_DATA_HOME:=$HOME/.local/share}/blesh/ble.sh" --attach=none

HISTCONTROL=ignoreboth:erasedups
shopt -s histappend # do not overwrite history
HISTSIZE=10000
HISTFILESIZE=10000
HISTDIR="${XDG_DATA_HOME:-$HOME/.local/share}/bash"
HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/bash/history"
[[ ! -d $HISTDIR ]] && command mkdir -p "$HISTDIR"

### SHOPT
shopt -s autocd  # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob
shopt -s expand_aliases # expand aliases
shopt -s checkwinsize   # checks term size when bash regains control

# Enable orbstack
ssource "${HOME}/.orbstack/shell/init.bash"

source <(fzf --bash)
eval "$(starship init bash)"
eval "$(direnv hook bash)"
eval "$(zoxide init bash)"
eval "$(atuin init bash)"

[[ ! ${BLE_VERSION-} ]] || ble-attach
