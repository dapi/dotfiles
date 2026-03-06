# Non-interactive sessions: keep startup minimal.
if not status --is-interactive
    set -g fish_greeting
    exit 0
end

# User snippets are loaded by fish from conf.d/.
zoxide init fish | source

if not set -q ZELLIJ; and set -q SSH_TTY; and test (uname) != "Darwin"
    set -l first_zellij_session (zellij list-sessions -s 2>/dev/null | head -n 1)
    if test -n "$first_zellij_session"
        zellij attach --index 0
    else
        zellij
    end

    if test "$ZELLIJ_AUTO_EXIT" = "true"
        kill $fish_pid
    end
end
