#!/usr/bin/env sh
# shellcheck shell=sh

alias ta='tmux attach'
alias tl='tmux ls'

if [ -n "$TMUX" ]; then # From inside tmux
  alias tf='tmux find-window'
  # Detach all other clients to this session
  alias mine='tmux detach -a'
  # Send command to other tmux window
  tt() {
    tmux send-keys -t .+ C-u && \
      tmux set-buffer "$*" && \
      tmux paste-buffer -t .+ && \
      tmux send-keys -t .+ Enter;
  }
  # Create new session (from inside one)
  tn() {
    _tn_name="${1:-$(basename "$PWD")}"
    TMUX=tmux new-session -d -s "$_tn_name"
    tmux switch-client -t "$_tn_name"
    tmux display-message "Session #S created"
    unset _tn_name
  }
else # From outside tmux
  # Start grouped session so I can be in two different windows in one session
  tdup() {
    _tdup_default_session="$(tmux display-message -p '#S')"
    tmux new-session -t "${1:-$_tdup_default_session}";
    unset _tdup_default_session
  }
fi
