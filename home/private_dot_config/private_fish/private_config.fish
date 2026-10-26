#!/usr/bin/env fish

set -q XDG_CONFIG_HOME; or set -gx XDG_CONFIG_HOME $HOME/.config
if test -r "$XDG_CONFIG_HOME/shell/env.fish"
    source "$XDG_CONFIG_HOME/shell/env.fish"
end

status is-interactive; or return

fish_vi_key_bindings
if test -r "$XDG_CONFIG_HOME/shell/interactive.fish"
    source "$XDG_CONFIG_HOME/shell/interactive.fish"
end

function y
  set -l tmp (mktemp -t "yazi-cwd.XXXXXX"); or return
  set -l result 0
  command yazi $argv --cwd-file="$tmp"; or set result $status
  set -l cwd
  if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
    builtin cd -- "$cwd"; or set result $status
  end
  command rm -f -- "$tmp"
  return $result
end

abbr --add nvitop uvx nvitop
