#!/usr/bin/env bash
# shellcheck shell=bash

export ZVM_SYSTEM_CLIPBOARD_ENABLED=true
export FZF_DEFAULT_OPTS='--height 40% --tmux bottom,40% --layout reverse --border top'
export EDITOR=nvim
export PIP_REQUIRE_VIRTUALENV=true
export BUN_INSTALL="${XDG_DATA_HOME:-$HOME/.local/share}/bun"
export PNPM_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/pnpm"
