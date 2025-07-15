# Define a function to conditionally initialize shell tools
function _initialize_fish_tool
    set -l tool_name $argv[1]
    set -l init_command $argv[2]
    set -l init_type $argv[3] # "source" or "eval"

    if command -q $tool_name
        switch $init_type
            case "source"
                # Use string expansion directly for source, as 'eval' isn't needed
                # and can sometimes cause issues with output redirection.
                source $init_command
            case "eval"
                eval $init_command
            case "*"
                # Default to source if not specified or unknown
                source $init_command
        end
    end
end

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

_initialize_fish_tool "fzf" "(fzf --fish)" "source"
_initialize_fish_tool "starship" "(starship init fish)" "source"
_initialize_fish_tool "direnv" "(direnv hook fish)" "source"

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
