#!/usr/bin/env bash
# shellcheck shell=bash

init_brew
path_prepend "$HOME/.local/bin"
# path_prepend "$HOME/.local/sbin"
# path_prepend "$HOME/.emacs.d/bin"
path_prepend "$(brew --prefix rustup)/bin"
# path_prepend "${XDG_CONFIG_HOME:-$HOME/.config}/emacs/bin"
