status --is-interactive; or return

# Reuse ssh-agent keys across sessions.
if type -q keychain
    keychain --eval --quiet -Q id_ed25519.priv 2>/dev/null | source
end

# Tell pinentry which terminal to use.
set -gx GPG_TTY (tty)
