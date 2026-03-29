status --is-interactive; or return

# Use systemd-managed ssh-agent socket (Linux only).
if test (uname) = Linux
    set -gx SSH_AUTH_SOCK /run/user/(id -u)/openssh_agent
end

# Prefer forwarded GPG agent over a locally spawned one during SSH sessions.
if set -q SSH_CONNECTION; and command -q gpgconf
    gpgconf --kill gpg-agent >/dev/null 2>&1
end

# Tell pinentry which terminal to use.
set -gx GPG_TTY (tty)
