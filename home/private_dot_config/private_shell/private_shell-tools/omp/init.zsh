#!/usr/bin/env sh
# shellcheck shell=zsh

command -v omp >/dev/null 2>&1 &&
eval "$(omp completions zsh)"
