if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Enable linuxbrew completion.
if command -v brew > /dev/null 2>&1
    if test -d (brew --prefix)"/share/fish/completions"
        set -p fish_complete_path (brew --prefix)/share/fish/completions
    end
    if test -d (brew --prefix)"/share/fish/vendor_completions.d"
        set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
    end
end

# Enable starship prompt.
if command -v starship >/dev/null 2>&1
    starship init fish | source
end
