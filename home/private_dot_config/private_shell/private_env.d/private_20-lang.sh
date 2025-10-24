#!/usr/bin/env bash
# shellcheck shell=bash

# These will already be set for GUI via env.conf; this ensures shells match too.
: "${LANG:=en_US.UTF-8}"
: "${LC_ALL:=en_US.UTF-8}"
export LANG LC_ALL
