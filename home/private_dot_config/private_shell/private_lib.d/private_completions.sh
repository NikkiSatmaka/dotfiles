#!/usr/bin/env sh

# Cache generated shell code without depending on a plugin's cached-eval API.
# A subshell keeps temporary variables out of the calling interactive shell.
cache_command_output() (
  cache=$1
  shift
  binary=$(command -v "$1") || return 0
  dir=${cache%/*}
  metadata="$dir/.metadata/${cache##*/}"
  identity="$binary|$*"
  previous=''
  if [ -r "$metadata" ]; then
    IFS= read -r previous < "$metadata" || :
  fi
  if [ "${SHELL_COMPLETIONS_REFRESH:-0}" != 1 ] &&
     [ -s "$cache" ] && [ ! "$binary" -nt "$metadata" ] &&
     [ "$identity" = "$previous" ]; then
    return 0
  fi

  command mkdir -p "$dir/.metadata" || return
  tmp=$(command mktemp "$dir/.metadata/.generate.XXXXXX") || return
  trap 'command rm -f -- "$tmp"' EXIT
  trap 'exit 1' HUP INT TERM
  if command "$@" >| "$tmp" && [ -s "$tmp" ]; then
    # Unchanged output must not invalidate compinit's directory-mtime cache.
    if [ ! -f "$cache" ] || ! command cmp -s "$tmp" "$cache"; then
      command mv -f -- "$tmp" "$cache" || return
    fi
    printf '%s\n' "$identity" >| "$metadata"
  else
    printf 'Could not generate completions: %s; keeping the previous cache.\n' "$*" >&2
    return 1
  fi
)
