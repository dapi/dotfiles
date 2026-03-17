status --is-interactive; or return

# Auto-start zellij only for SSH sessions on Linux.
if set -q ZELLIJ; or not set -q SSH_TTY; or test (uname) = "Darwin"
    return
end

set -l first_zellij_session (zellij list-sessions --short 2>/dev/null | head -n 1)
if test -n "$first_zellij_session"
    zellij attach "$first_zellij_session"
else
    zellij
end

if test "$ZELLIJ_AUTO_EXIT" = "true"
    kill $fish_pid
end
