#!/usr/bin/env sh

# Run at setup/tool-update time, not during ordinary shell startup.
config_home=${XDG_CONFIG_HOME:-$HOME/.config}
cache_home=${XDG_CACHE_HOME:-$HOME/.cache}
# shellcheck source=private_lib.d/private_completions.sh
. "$config_home/shell/lib.d/completions.sh" || exit

export SHELL_COMPLETIONS_REFRESH=1
result=0
generate() {
  target=$1
  shift
  command -v "$1" >/dev/null 2>&1 || return 0
  cache_command_output "$target" "$@" || result=1
}

zsh_dir="$cache_home/zsh/completions"
SHELL=zsh generate "$zsh_dir/_bun" bun completions
generate "$zsh_dir/_chezmoi" chezmoi completion zsh
generate "$zsh_dir/_docker" docker completion zsh
generate "$zsh_dir/_kubectl" kubectl completion zsh
generate "$zsh_dir/_podman" podman completion zsh
generate "$zsh_dir/_rustup" rustup completions zsh
generate "$zsh_dir/_cargo" rustup completions zsh cargo
generate "$zsh_dir/_uv" uv generate-shell-completion zsh
generate "$zsh_dir/_uvx" uvx --generate-shell-completion zsh
generate "$cache_home/shell/completions/omp.zsh" omp completions zsh
generate "$cache_home/shell/completions/omp.bash" omp completions bash
exit "$result"
