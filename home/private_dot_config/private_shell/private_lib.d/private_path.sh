#!/usr/bin/env sh
# shellcheck shell=sh disable=SC1090,SC2015


path_prepend() {
  [ -d "$1" ] || return 0
  case ":$PATH:" in
    *":$1:"*) ;;                # If $1 already in PATH, skip
    *) PATH="$1:$PATH" ;;       # Otherwise prepend
  esac
}

path_append() {
  [ -d "$1" ] || return 0
  case ":$PATH:" in
    *":$1:"*) ;;                # If $1 already in PATH, skip
    *) PATH="$PATH:$1" ;;       # Otherwise append
  esac
}

path_remove() {
  PATH=$(printf '%s' "$PATH" | awk -vRS=: -vORS=: -vT="$1" '$0 != T' | sed 's/:$//')
}

# Usage: ssource file
ssource() {
  [ -r "$1" ] && . "$1" 2>/dev/null || :
}

# Function to find and initialize brew
init_brew() {
  for prefix in /opt/homebrew /home/linuxbrew/.linuxbrew "$HOME/.linuxbrew"; do
    if [ -x "$prefix/bin/brew" ]; then
      eval "$("$prefix/bin/brew" shellenv)"
      break
    fi
  done
}
