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
  yazi $argv --cwd-file="$tmp"
  if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
    builtin cd -- "$cwd"
  end
  rm -f -- "$tmp"
end

alias nvitop="uvx nvitop"
