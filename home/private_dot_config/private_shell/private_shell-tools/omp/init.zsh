#!/usr/bin/env sh
# shellcheck shell=zsh

if command -v omp >/dev/null 2>&1; then
  omp_cache="${XDG_CACHE_HOME:-$HOME/.cache}/shell/completions/omp.zsh"
  cache_command_output "$omp_cache" omp completions zsh
  [ ! -r "$omp_cache" ] || . "$omp_cache"
  unset omp_cache
fi
