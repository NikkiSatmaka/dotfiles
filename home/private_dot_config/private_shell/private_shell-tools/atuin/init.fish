#!/usr/bin/env fish
# shellcheck shell=fish

if command -q atuin
    atuin init fish | sed "s/-k up/up/g" | source
end
