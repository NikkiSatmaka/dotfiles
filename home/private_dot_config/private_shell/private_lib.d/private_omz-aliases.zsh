# Load cached aliases/functions derived from the installed upstream OMZ plugin.
load_omz_aliases() {
  local tool=$1 plugin='' dir cache metadata generator
  (( $+commands[$tool] )) || return 0
  for dir in $fpath; do
    if [[ -r "$dir/$tool.plugin.zsh" ]]; then
      plugin="$dir/$tool.plugin.zsh"
      break
    fi
  done
  if [[ -z $plugin ]]; then
    print -u2 -- "Cannot find the upstream OMZ plugin for $tool; rebuild the Antidote bundle."
    return 1
  fi
  cache="${XDG_CACHE_HOME:-$HOME/.cache}/shell/aliases/$tool.zsh"
  metadata="${cache:h}/.metadata/${cache:t}"
  generator="${XDG_CONFIG_HOME:-$HOME/.config}/shell/generate-omz-aliases.zsh"
  if [[ $plugin -nt $metadata || $generator -nt $metadata ]]; then
    SHELL_COMPLETIONS_REFRESH=1 cache_command_output "$cache" zsh -f "$generator" "$plugin"
  else
    cache_command_output "$cache" zsh -f "$generator" "$plugin"
  fi
  ssource "$cache"
}
