#!/usr/bin/env zsh
# Executed only on cache misses/upstream changes, in an isolated child shell.
# Upstream completion generators write outside the interactive shell's fpath.
ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/shell/omz-generation"
mkdir -p "$ZSH_CACHE_DIR/completions" || exit
autoload -Uz is-at-least
typeset -a registrations before
compdef() { registrations+=("compdef ${(j: :)${(q)@}}") }
before=(${(k)functions})
source "$1" || exit
print -r -- "# Generated from $1; upstream owns these definitions."
if [[ -r ${1:h:h:h}/LICENSE.txt ]]; then
  while IFS= read -r line; do
    print -r -- "# $line"
  done < "${1:h:h:h}/LICENSE.txt"
fi
alias -L
for name in ${(k)functions}; do
  (( ${before[(Ie)$name]} )) || functions "$name"
done
(( $#registrations == 0 )) || print -rl -- $registrations
