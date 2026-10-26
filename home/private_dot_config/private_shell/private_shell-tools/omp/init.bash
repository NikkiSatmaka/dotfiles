#!/usr/bin/env sh
# shellcheck shell=bash disable=SC1090,SC1091,SC2034

if command -v omp >/dev/null 2>&1; then
  omp_cache="${XDG_CACHE_HOME:-$HOME/.cache}/shell/completions/omp.bash"
  cache_command_output "$omp_cache" omp completions bash
  [ ! -r "$omp_cache" ] || . "$omp_cache"
  unset omp_cache
fi
