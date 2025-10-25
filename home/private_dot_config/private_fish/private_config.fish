if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Enable Linuxbrew completion.
if command -q brew
    set -l brew_prefix (brew --prefix)
    if test -d "$brew_prefix/share/fish/completions"
        set -p fish_complete_path "$brew_prefix/share/fish/completions"
    end
    if test -d "$brew_prefix/share/fish/vendor_completions.d"
        set -p fish_complete_path "$brew_prefix/share/fish/vendor_completions.d"
    end
end

fzf --fish | source
starship init fish | source
direnv hook fish | source
zoxide init fish | source

if command -q yazi
    function y
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
    end
end

# Clean up the temporary function
functions --erase _initialize_fish_tool
