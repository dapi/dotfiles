if status is-interactive && command -sq direnv
    direnv hook fish | source
end
