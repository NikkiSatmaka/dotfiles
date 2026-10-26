#!/usr/bin/env sh
# shellcheck shell=zsh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Reuse POSIX interactive
. "${XDG_CONFIG_HOME:-$HOME/.config}/shell/interactive.sh"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
ssource "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"

ssource "${ZDOTDIR:-$HOME/.config/zsh}/.zstyles.zsh"

# Set the root name of the plugins files (.txt and .zsh) antidote will use.
ZSH_PLUGINS="${ZDOTDIR:-$HOME/.config/zsh}/.zsh_plugins"

fpath=(${XDG_DATA_HOME:-$HOME/.local/share}/mise-completions/zsh $fpath)

# Generate a new static file whenever .zsh_plugins.txt is updated.
if [[ -r "${ZSH_PLUGINS}.txt" && ( ! -s "${ZSH_PLUGINS}.zsh" || ! "${ZSH_PLUGINS}.zsh" -nt "${ZSH_PLUGINS}.txt" ) ]]; then
  # Keep the previous bundle usable if Antidote cannot generate its replacement.
  () {
    local bundle_tmp

    if ! (( $+commands[antidote] )) && {
      ! (( $+functions[antidote] )) || [[ ${functions[antidote]} == *'builtin autoload -X'* ]]
    }; then
      # Resolve the autoload before opening any output file.
      [[ -n ${HOMEBREW_PREFIX:-} ]] && fpath=("${HOMEBREW_PREFIX}/opt/antidote/share/antidote/functions" $fpath)
      autoload -Uz antidote
      if ! autoload +X antidote; then
        print -u2 -- 'Antidote is unavailable; keeping the existing Zsh plugin bundle.'
        return
      fi
    fi

    bundle_tmp=$(command mktemp "${ZSH_PLUGINS}.zsh.XXXXXX") || return
    {
      if antidote bundle < "${ZSH_PLUGINS}.txt" >| "$bundle_tmp" && [[ -s "$bundle_tmp" ]]; then
        command mv -f -- "$bundle_tmp" "${ZSH_PLUGINS}.zsh"
      else
        print -u2 -- 'Antidote bundle generation failed or produced no output; keeping the existing Zsh plugin bundle.'
      fi
    } always {
      command rm -f -- "$bundle_tmp"
    }
  }
fi

# Source your static plugins file.
ssource "${ZSH_PLUGINS}.zsh"

# Load Zsh-specific aliases after the completion framework defines compdef.
for f in "${XDG_CONFIG_HOME:-$HOME/.config}/shell/alias.d/"*.zsh(N); do
  ssource "$f"
done

# Hotfix for `dtop` alias from omz:docker conflicting with `dtop` cli tools
alias dtop >/dev/null 2>&1 && unalias dtop

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh
ssource "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/.p10k.zsh"

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
