#!/usr/bin/env sh
# shellcheck shell=bash disable=SC1090,SC1091,SC2034

command -v aws >/dev/null 2>&1 &&
  complete -C '~/.local/share/mise/installs/aws-cli/latest/.mise-bins/aws_completer' aws
