#!/usr/bin/env fish
# shellcheck shell=fish

if command -q zoxide
    zoxide init fish |
        sed 's,\(string.*\) <\$__fish_data_dir/functions/cd.fish,status get-file functions/cd.fish | \1,' |
        source
end
