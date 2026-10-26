#!/usr/bin/env sh
# shellcheck shell=zsh

if (( $+commands[omp] )); then
  # z1 caches stable generated code for 20 hours. After an OMP update, refresh
  # immediately with: cached-eval --clear omp completions zsh
  if (( $+functions[cached-eval] )); then
    cached-eval omp completions zsh
  else
    eval "$(omp completions zsh)"
  fi
fi
