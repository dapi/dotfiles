status --is-interactive; or return

# Activate mise-managed tools before other shell hooks.
if test -x "$HOME/.local/bin/mise"
    "$HOME/.local/bin/mise" activate fish | source
else if command -sq mise
    mise activate fish | source
end
