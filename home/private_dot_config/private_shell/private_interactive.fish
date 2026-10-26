#!/usr/bin/env fish
# shellcheck shell=fish

set -q XDG_CONFIG_HOME; or set -x XDG_CONFIG_HOME $HOME/.config

# Fish cannot source POSIX shell code. Shared exports are imported by env.fish;
# aliases, functions, and prompt customizations must use native Fish files.
for dir in lib.d alias.d functions.d post.d
    for f in $XDG_CONFIG_HOME/shell/$dir/*.fish
        test -r $f; and source $f
    end
end

for f in $XDG_CONFIG_HOME/shell/shell-tools/*/init.fish
    test -r $f; and source $f
end
