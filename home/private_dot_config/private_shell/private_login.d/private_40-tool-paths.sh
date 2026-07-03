#!/usr/bin/env bash
# shellcheck shell=bash

path_prepend "${BUN_INSTALL:-$HOME/.local/share/bun}/bin"
path_prepend "${PNPM_HOME:-$HOME/.local/share/pnpm}/bin"
path_prepend "${CARGO_HOME:-$HOME/.local/share/cargo}/bin"
# path_prepend "${XDG_CONFIG_HOME:-$HOME/.config}/emacs/bin"
# path_prepend "${XDG_DATA_HOME:-$HOME/.local/share}/gem/bin"
# path_prepend "${XDG_DATA_HOME:-$HOME/.local/share}/go/bin"
# path_prepend "$ANDROID_HOME/platform-tools"
# path_prepend "$PYENV_ROOT/bin"
