# Optional zellij autostart on Linux.
if not set -q ZELLIJ; and test (uname) != "Darwin"
    if test "$ZELLIJ_AUTO_ATTACH" = "true"
        zellij attach -c --index 0
    else
        zellij
    end

    if test "$ZELLIJ_AUTO_EXIT" = "true"
        kill $fish_pid
    end
end
