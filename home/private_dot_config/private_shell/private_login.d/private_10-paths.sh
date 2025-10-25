#!/usr/bin/env bash
# shellcheck shell=bash

init_brew
path_prepend "$HOME/.local/bin"
# path_prepend "$HOME/.local/sbin"
# path_prepend "$HOME/.emacs.d/bin"
# path_prepend "${XDG_CONFIG_HOME:-$HOME/.config}/emacs/bin"
# path_prepend "${XDG_DATA_HOME:-$HOME/.local/share}/cargo/bin"
# path_prepend "${XDG_DATA_HOME:-$HOME/.local/share}/gem/bin"
# path_prepend "${XDG_DATA_HOME:-$HOME/.local/share}/go/bin"
# path_prepend "${XDG_DATA_HOME:-$HOME/.local/share}/npm/bin"
# path_prepend "$PNPM_HOME"
# path_prepend "$ANDROID_HOME/platform-tools"
# path_prepend "$PYENV_ROOT/bin"
