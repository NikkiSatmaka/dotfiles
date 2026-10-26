<div align="center">

# Dotfiles

My dotfiles for Linux, Windows, WSL, and macOS. I've used these operating systems at some point in my life. I'm currently using Windows and WSL, but I'm planning on returning to Linux as my daily OS in the near future.

[Deployment](#deploy-with-ease-and-efficiency) • [Bash](#bash) • [Zsh](#zsh) • [Vim/Neovim](#vimneovim) • [Doom Emacs](#doom-emacs) • [tmux](#tmux) • [Git](#git) • [Terminal emulators](#terminal-emulators) • [Other config](#other-config)

</div>

## Features

### Deploy with ease and efficiency

[*chezmoi*](https://www.chezmoi.io/) is used to bootstrap dotfiles.

## List of Apps
### Terminal
- [Alacritty](https://github.com/alacritty/alacritty)

## Shell setup

Zsh initializes fzf, mise, and zoxide through their Oh My Zsh plugins. Keep
their `shell-tools` initializers for Bash and Fish only. Zephyr owns completion
initialization and caching; it loads before plugins that call `compdef`.
Powerlevel10k uses its explicit theme entry point.

OMP's Zsh completion script uses z1's `cached-eval` cache (20 hours). Dynamic
completion requests still run OMP as needed. After upgrading OMP, invalidate
the generated script with `cached-eval --clear omp completions zsh`, then open
a new shell. Fish autoloads OMP completions on the first completion request.

`ssource` skips unreadable or missing optional files, but preserves diagnostics
and exit status when an existing file fails. Source required files directly.

Fish imports shared environment exports through a POSIX shell subprocess with
NUL-delimited output. Login shells also import `login.sh`. Fish aliases and
functions belong in native `.fish` files; POSIX `.sh` files are never sourced
directly by Fish. Tool integrations run only in interactive sessions.

tmux explicitly uses Zsh independently of the account's login shell. Chezmoi
renders its path at apply time, preferring Homebrew Zsh: `/opt/homebrew/bin/zsh`
then `/usr/local/bin/zsh` on macOS; `/home/linuxbrew/.linuxbrew/bin/zsh` then
`~/.linuxbrew/bin/zsh` on Linux. If neither exists, it uses `/bin/zsh`.
Homebrew's Zsh can remain installed as an Antidote dependency; it does not need
to become the login shell. The tmux config is a rendered file rather than a
symlink; reapply it after changing the template or installing/removing Zsh.

Preview and apply just the shell configuration, without bootstrap scripts or
external repository updates:

```sh
chezmoi apply --dry-run --verbose --exclude=scripts,externals ~/.config/shell ~/.config/zsh ~/.config/fish
chezmoi apply --exclude=scripts,externals ~/.config/shell ~/.config/zsh ~/.config/fish
```

`.chezmoiremove` removes the retired initializers on apply, including copies
left behind on other devices. Open a new terminal after applying.

Run the shell regression checks with:

```sh
PYTHONDONTWRITEBYTECODE=1 python3 -m unittest discover -s tests -v
```
