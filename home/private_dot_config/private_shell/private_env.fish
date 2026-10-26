#!/usr/bin/env fish

set -q XDG_CONFIG_HOME; or set -gx XDG_CONFIG_HOME $HOME/.config
test -r "$XDG_CONFIG_HOME/shell/env.sh"; or return 0

# Evaluate POSIX environment files in sh, then import data, never shell code.
# NUL delimiters preserve empty values, newlines, and embedded equals signs.
set -l phase env
status is-login; and set phase login
command sh -c '
    . "$1/shell/env.sh" || exit
    if [ "$2" = login ] && [ -r "$1/shell/login.sh" ]; then
        . "$1/shell/login.sh" || exit
    fi
    env -0
' sh "$XDG_CONFIG_HOME" "$phase" | while read --null --delimiter = --local name value
    switch "$name"
        case PWD SHLVL _
            continue
    end
    set -gx "$name" "$value"
end
set -l result $pipestatus[1]
# umask is process state, so it cannot be imported through the environment.
umask 0077
return $result
