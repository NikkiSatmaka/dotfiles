#!/usr/bin/env fish
# shellcheck shell=fish

if command -q fzf
    fzf --fish | source
end
