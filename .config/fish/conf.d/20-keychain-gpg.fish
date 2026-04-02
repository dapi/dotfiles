status --is-interactive; or return

# SSH agent: use fixed symlink path that ~/.ssh/rc maintains on each login.
# This survives zellij/tmux reconnects — the symlink always points to the latest forwarded socket.
if set -q SSH_CONNECTION
    set -gx SSH_AUTH_SOCK ~/.ssh/agent.sock
    if command -q gpgconf
        gpgconf --kill gpg-agent >/dev/null 2>&1
    end
else if test (uname) = Darwin
    # Local macOS session — ensure gpg-agent is running so S.gpg-agent.extra
    # exists before SSH RemoteForward needs it.
    if command -q gpgconf
        gpgconf --launch gpg-agent >/dev/null 2>&1
    end
else if test (uname) = Linux
    # Local session — use systemd-managed agent.
    set -gx SSH_AUTH_SOCK /run/user/(id -u)/openssh_agent
end

# Tell pinentry which terminal to use.
set -gx GPG_TTY (tty)
