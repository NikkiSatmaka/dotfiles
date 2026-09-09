#!/usr/bin/env sh
# shellcheck shell=zsh

command -v aws >/dev/null 2>&1 &&
complete -C '~/.local/share/mise/installs/aws-cli/latest/.mise-bins/aws_completer' aws
