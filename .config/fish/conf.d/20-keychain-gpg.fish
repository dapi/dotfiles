status --is-interactive; or return

# SSH agent: use fixed symlink path that ~/.ssh/rc maintains on each login.
# This survives zellij/tmux reconnects — the symlink always points to the latest forwarded socket.
if set -q SSH_CONNECTION
    # Remote SSH session — use forwarded agent via symlink
    set -gx SSH_AUTH_SOCK ~/.ssh/agent.sock
    if command -q gpgconf
        gpgconf --kill gpg-agent >/dev/null 2>&1
    end
else if test (uname) = Darwin
    # Local macOS session — manage ssh-agent
    # Clean up dead symlink from previous session
    if test -L ~/.ssh/agent.sock; and not test -S ~/.ssh/agent.sock
        rm -f ~/.ssh/agent.sock
    end

    # Look for existing running agent
    set -l agent_sock
    if test -d /tmp
        # Find live sockets, verify they actually work
        for sock in (ls -t /tmp/ssh-*/agent.* 2>/dev/null)
            if test -S "$sock"
                # Verify agent responds before using it
                if SSH_AUTH_SOCK="$sock" ssh-add -l >/dev/null 2>&1
                    set agent_sock "$sock"
                    break
                end
            end
        end
    end

    if test -n "$agent_sock"
        set -gx SSH_AUTH_SOCK "$agent_sock"
    else
        # No live agent found — start a fresh one
        eval (ssh-agent -c)
    end

    # Update symlink for tmux/zellij persistence
    if test -n "$SSH_AUTH_SOCK"; and test -S "$SSH_AUTH_SOCK"
        ln -sf "$SSH_AUTH_SOCK" ~/.ssh/agent.sock
    end

    # Add keys from Keychain (macOS) or from file
    ssh-add -l >/dev/null 2>&1
    if test $status -ne 0
        # Try loading from macOS Keychain first, then fallback to file
        ssh-add --apple-load-keychain 2>/dev/null
        or ssh-add ~/.ssh/id_ed25519 2>/dev/null
        or true
    end

    # GPG agent (for commit signing)
    if command -q gpgconf
        gpgconf --launch gpg-agent >/dev/null 2>&1
    end
else if test (uname) = Linux
    # Local session — use systemd-managed agent.
    set -gx SSH_AUTH_SOCK /run/user/(id -u)/openssh_agent
end

# Tell pinentry which terminal to use.
set -gx GPG_TTY (tty)
