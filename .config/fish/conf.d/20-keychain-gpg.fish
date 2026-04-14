status --is-interactive; or return

function __ssh_agent_is_live --argument-names sock
    test -S "$sock"; or return 1
    SSH_AUTH_SOCK="$sock" ssh-add -l >/dev/null 2>&1
end

function __find_reusable_ssh_agent_sock_macos
    if set -q SSH_AUTH_SOCK; and __ssh_agent_is_live "$SSH_AUTH_SOCK"
        echo "$SSH_AUTH_SOCK"
        return 0
    end

    if __ssh_agent_is_live "$HOME/.ssh/agent.sock"
        echo "$HOME/.ssh/agent.sock"
        return 0
    end

    for sock in (begin
            find "$HOME/.ssh" -maxdepth 2 -type s -path "$HOME/.ssh/agent/*" -print0 2>/dev/null
            find /tmp -maxdepth 2 -path '/tmp/ssh-*/agent.*' -type s -print0 2>/dev/null
        end | xargs -0 stat -f '%m\t%N' 2>/dev/null | sort -rn | cut -f2-)
        if __ssh_agent_is_live "$sock"
            echo "$sock"
            return 0
        end
    end

    return 1
end

function __find_reusable_ssh_agent_sock_linux
    if set -q SSH_AUTH_SOCK; and __ssh_agent_is_live "$SSH_AUTH_SOCK"
        echo "$SSH_AUTH_SOCK"
        return 0
    end

    set -l systemd_sock "/run/user/"(id -u)"/openssh_agent"
    if __ssh_agent_is_live "$systemd_sock"
        echo "$systemd_sock"
        return 0
    end

    return 1
end

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

    set -l agent_sock (__find_reusable_ssh_agent_sock_macos)

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
    set -l agent_sock (__find_reusable_ssh_agent_sock_linux)
    if test -n "$agent_sock"
        set -gx SSH_AUTH_SOCK "$agent_sock"
    end
end

# Tell pinentry which terminal to use.
set -gx GPG_TTY (tty)
