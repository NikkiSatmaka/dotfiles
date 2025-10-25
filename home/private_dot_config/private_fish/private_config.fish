#!/usr/bin/env fish

if status is-interactive
  # Commands to run in interactive sessions can go here
end

fish_vi_key_bindings

fzf --fish | source
direnv hook fish | source
zoxide init fish | source

function y
  set tmp (mktemp -t "yazi-cwd.XXXXXX")
  yazi $argv --cwd-file="$tmp"
  if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
    builtin cd -- "$cwd"
  end
  rm -f -- "$tmp"
end
