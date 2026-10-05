# shellcheck shell=bash

export ANSIBLE_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/ansible"
export ANSIBLE_GALAXY_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/ansible/galaxy_cache"
export ANSIBLE_LOCAL_TEMP="${XDG_CACHE_HOME:-$HOME/.cache}/ansible/tmp"
export ANSIBLE_REMOTE_TEMP="${XDG_CACHE_HOME:-$HOME/.cache}/ansible/tmp"
export ANSIBLE_SSH_CONTROL_PATH_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/ansible/cp"
export ANSIBLE_ASYNC_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/ansible_async"
