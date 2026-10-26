# Fish autoloads this only when completing omp, once per shell session.
if command -q omp
    omp completions fish | source
end
