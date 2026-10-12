# Zsh-only file filters. Keep portable listing aliases in navigation.sh.
# Null glob qualifiers plus the count guard avoid listing the current directory
# when a filter matches nothing. Arguments to head/tail are passed at call time.
if (( $+commands[eza] )); then
  # Custom filters take precedence over aliases installed by plugins.
  unalias lad lsa lse lsnew lsold lsx lssuid lssmall lsbig 2>/dev/null
  function lad {
    emulate -L zsh
    local -a files=(.*(/N))
    (( ${#files} )) || return 0
    command eza -hd -- "${files[@]}" "$@"
  }
  function lsa {
    emulate -L zsh
    local -a files=(.*(.N))
    (( ${#files} )) || return 0
    command eza -ha -- "${files[@]}" "$@"
  }
  function lse {
    emulate -L zsh
    local -a files=(*(/^FN))
    (( ${#files} )) || return 0
    command eza -hldF -- "${files[@]}" "$@"
  }
  function lsnew {
    emulate -L zsh
    local -a files=(*(.N))
    (( ${#files} )) || return 0
    command eza -l --sort=modified -- "${files[@]}" | tail "$@"
  }
  function lsold {
    emulate -L zsh
    local -a files=(*(.N))
    (( ${#files} )) || return 0
    command eza -l --sort=modified -- "${files[@]}" | head "$@"
  }
  function lsx {
    emulate -L zsh
    local -a files=(*(*N))
    (( ${#files} )) || return 0
    command eza -l -- "${files[@]}" | head "$@"
  }
  function lssuid {
    emulate -L zsh
    local -a files=(*(s,SN))
    (( ${#files} )) || return 0
    command eza -l -- "${files[@]}" | head "$@"
  }
  function lssmall {
    emulate -L zsh
    local -a files=(*(.N))
    (( ${#files} )) || return 0
    command eza -l --sort=size -- "${files[@]}" | head "$@"
  }
  function lsbig {
    emulate -L zsh
    local -a files=(*(.N))
    (( ${#files} )) || return 0
    command eza -l --sort=size --reverse -- "${files[@]}" | head "$@"
  }
fi
