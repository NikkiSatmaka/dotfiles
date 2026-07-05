#!/usr/bin/env fish

if status is-interactive
  # Commands to run in interactive sessions can go here
end

fish_vi_key_bindings

for f in $XDG_CONFIG_HOME/shell/shell-tools/*/init.fish
    test -r $f
    and source $f
end

function y
  set tmp (mktemp -t "yazi-cwd.XXXXXX")
  command yazi $argv --cwd-file="$tmp"
  if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
    builtin cd -- "$cwd"
  end
  command rm -f -- "$tmp"
end

abbr --add nvitop uvx nvitop
