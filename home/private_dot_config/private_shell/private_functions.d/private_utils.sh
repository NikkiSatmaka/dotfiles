#!/usr/bin/env bash
# shellcheck shell=bash disable=SC1090

mkcd() {
  mkdir -p "$1" && cd "$1" || return 1
}

copy_output() {
  if [ "$#" -eq 0 ]; then
    printf 'Usage: copy_output command [arguments...]\n' >&2
    return 2
  fi
  local tmp result=0
  tmp=$(mktemp -t "copy-output.XXXXXX") || return
  "$@" > "$tmp" || result=$?
  if [ "$result" -ne 0 ]; then
    command rm -f -- "$tmp"
    return "$result"
  fi
  if command -v pbcopy >/dev/null 2>&1; then
    pbcopy < "$tmp" || result=$?
  elif [ -n "${WAYLAND_DISPLAY:-}" ] && command -v wl-copy >/dev/null 2>&1; then
    wl-copy < "$tmp" || result=$?
  elif command -v xsel >/dev/null 2>&1; then
    xsel --clipboard --input < "$tmp" || result=$?
  elif command -v xclip >/dev/null 2>&1; then
    xclip -selection clipboard < "$tmp" || result=$?
  else
    printf 'No clipboard command found (pbcopy, wl-copy, xsel, xclip).\n' >&2
    result=127
  fi
  command rm -f -- "$tmp"
  return "$result"
}

y() {
  local tmp cwd='' result=0
  tmp=$(mktemp -t "yazi-cwd.XXXXXX") || return
  command yazi "$@" --cwd-file="$tmp" || result=$?
  IFS= read -r -d '' cwd <"$tmp" || :
  if [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && [ -d "$cwd" ]; then
    builtin cd -- "$cwd" || result=$?
  fi
  command rm -f -- "$tmp"
  return "$result"
}

n() {
  # Block nesting of nnn in subshells
  [ "${NNNLVL:-0}" -eq 0 ] || {
    echo "nnn is already running"
    return
  }

  # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
  # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
  # see. To cd on quit only on ^G, remove the "export" and make sure not to
  # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
  #      NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
  export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

  # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
  # stty start undef
  # stty stop undef
  # stty lwrap undef
  # stty lnext undef

  # The command builtin allows one to alias nnn to n, if desired, without
  # making an infinitely recursive alias
  command nnn "$@"

  [ ! -f "$NNN_TMPFILE" ] || {
    . "$NNN_TMPFILE"
    rm -f -- "$NNN_TMPFILE" >/dev/null
  }
}

sesh-connect() {
  sesh connect "$(
    sesh list --icons | fzf-tmux -p 80%,70% \
      --no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' \
      --header '  ^a all ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find' \
      --bind 'tab:down,btab:up' \
      --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
      --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t --icons)' \
      --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c --icons)' \
      --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z --icons)' \
      --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
      --bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list --icons)' \
      --preview-window 'right:55%' \
      --preview 'sesh preview {}'
  )"
}
