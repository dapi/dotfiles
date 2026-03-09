status --is-interactive; or return

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
