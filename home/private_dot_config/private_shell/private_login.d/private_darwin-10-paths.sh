#!/usr/bin/env bash
# shellcheck shell=bash

path_prepend "$(brew --prefix coreutils)"/libexec/gnubin
path_prepend "$(brew --prefix findutils)"/libexec/gnubin
path_prepend "$(brew --prefix ed)"/libexec/gnubin
path_prepend "$(brew --prefix gawk)"/libexec/gnubin
path_prepend "$(brew --prefix grep)"/libexec/gnubin
path_prepend "$(brew --prefix gnu-sed)"/libexec/gnubin
path_prepend "$(brew --prefix gnu-tar)"/libexec/gnubin
path_prepend "$(brew --prefix make)"/libexec/gnubin
