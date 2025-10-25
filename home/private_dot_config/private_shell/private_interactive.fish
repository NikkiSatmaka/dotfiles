#!/usr/bin/env fish
# shellcheck shell=fish

set -q XDG_CONFIG_HOME; or set -x XDG_CONFIG_HOME $HOME/.config

# Prefer fish-native files if present, else source .sh quietly
for dir in lib.d env.d alias.d functions.d post.d
    for f in $XDG_CONFIG_HOME/shell/$dir/*.fish
        test -r $f; and source $f
    end
    for f in $XDG_CONFIG_HOME/shell/$dir/*.sh
        test -r $f; and source $f ^/dev/null
    end
end
