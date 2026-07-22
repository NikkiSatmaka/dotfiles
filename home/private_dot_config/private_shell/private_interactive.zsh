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

ssource "${ZDOTDIR:-$HOME/.config/zsh}/.zstyles"

# Set the root name of the plugins files (.txt and .zsh) antidote will use.
zsh_plugins="${ZDOTDIR:-$HOME/.config/zsh}/.zsh_plugins"

# Ensure the .zsh_plugins.txt file exists so you can add plugins.
[[ -f ${zsh_plugins}.txt ]] || touch ${zsh_plugins}.txt

# Lazy-load antidote from its functions directory.
fpath=("$(brew --prefix antidote)/share/antidote/functions" $fpath)
autoload -Uz antidote

# Generate a new static file whenever .zsh_plugins.txt is updated.
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
  antidote bundle <${zsh_plugins}.txt >|${zsh_plugins}.zsh
fi

# Source your static plugins file.
source ${zsh_plugins}.zsh

# Hotfix for `dtop` alias from omz:docker conflicting with `dtop` cli tools
alias dtop >/dev/null 2>&1 && unalias dtop

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh
ssource "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/.p10k.zsh"

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

for f in "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shell-tools/"*/init.zsh; do
  ssource "$f"
done
