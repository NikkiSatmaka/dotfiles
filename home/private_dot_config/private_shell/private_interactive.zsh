#!/usr/bin/env sh
# shellcheck shell=zsh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Reuse POSIX interactive
. "${XDG_CONFIG_HOME:-$HOME/.config}/shell/interactive.sh"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# source antidote
source "$(brew --prefix antidote)/share/antidote/antidote.zsh"
antidote load

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh
ssource "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/.p10k.zsh"

zstyle ':plugin:ez-compinit' 'use-cache' 'yes'
zstyle ":history-search-multi-word" highlight-color "fg=yellow,bold" # Color in which to highlight matched, searched text (default bg=17 on 256-color terminals)
zstyle ":history-search-multi-word" page-size "11"                    # Number of entries to show (default is $LINES/3)
zstyle ":plugin:history-search-multi-word" active "underline"        # Effect on active history entry. Try: standout, bold, bg=blue (default underline)
zstyle ":plugin:history-search-multi-word" check-paths "yes"         # Whether to check paths for existence and mark with magenta (default true)
zstyle ":plugin:history-search-multi-word" clear-on-cancel "no"      # Whether pressing Ctrl-C or ESC should clear entered query
zstyle ":plugin:history-search-multi-word" synhl "yes"

# Use incremental search
bindkey "^R" history-search-multi-word

setopt autocd
setopt interactivecomments

# Nicer history
HISTSIZE=10000
HISTDIR="${XDG_DATA_HOME:-$HOME/.local/share}/zsh"
HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/history"
[[ ! -d $HISTDIR ]] && command mkdir -p "$HISTDIR"
SAVEHIST=$HISTSIZE
setopt appendhistory
setopt sharehistory
setopt extendedhistory
setopt histignorespace

# Enable orbstack
ssource "${HOME}/.orbstack/shell/init.zsh"

source <(fzf --zsh)
eval "$(direnv hook zsh)"
eval "$(zoxide init zsh)"
eval "$(atuin init zsh)"
