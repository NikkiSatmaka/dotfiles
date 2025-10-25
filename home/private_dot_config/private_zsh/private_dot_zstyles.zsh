#!/usr/bin/env bash

# Zephyr features

# Use caching.
zstyle ':plugin:zephyr:plugin:*' 'use-cache' yes
zstyle ':plugin:ez-compinit' 'use-cache' 'yes'

zstyle ":plugin:history-search-multi-word" highlight-color "fg=yellow,bold"  # Color in which to highlight matched, searched text (default bg=17 on 256-color terminals)
zstyle ":plugin:history-search-multi-word" page-size "11"                    # Number of entries to show (default is $LINES/3)
zstyle ":plugin:history-search-multi-word" active "underline"                # Effect on active history entry. Try: standout, bold, bg=blue (default underline)
zstyle ":plugin:history-search-multi-word" check-paths "yes"                 # Whether to check paths for existence and mark with magenta (default true)
zstyle ":plugin:history-search-multi-word" clear-on-cancel "no"              # Whether pressing Ctrl-C or ESC should clear entered query
zstyle ":plugin:history-search-multi-word" synhl "yes"
