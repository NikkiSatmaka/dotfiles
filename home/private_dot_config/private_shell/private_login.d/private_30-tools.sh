#!/usr/bin/env bash
# shellcheck shell=bash

export ZVM_SYSTEM_CLIPBOARD_ENABLED=true
export FZF_DEFAULT_OPTS='--height 40% --popup bottom,40% --layout reverse --border top'
export EDITOR=nvim
export PIP_REQUIRE_VIRTUALENV=true
export BUN_INSTALL="${XDG_DATA_HOME:-$HOME/.local/share}/bun"
export PNPM_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/pnpm"
export RUSTUP_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/rustup"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export DOCKER_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/docker"

export CLAUDE_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/claude"
export CODEX_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/codex"
export COPILOT_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/copilot"
export GEMINI_CLI_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/gemini"
