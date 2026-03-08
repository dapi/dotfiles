status --is-interactive; or return

# Use systemd-managed ssh-agent socket (Linux only).
if test (uname) = Linux
    set -gx SSH_AUTH_SOCK /run/user/(id -u)/openssh_agent
end

# Tell pinentry which terminal to use.
set -gx GPG_TTY (tty)
