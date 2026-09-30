#!/usr/bin/env fish
# shellcheck shell=fish

if command -q omp
    omp completions fish | source
end
