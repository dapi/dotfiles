if test -n "$SSH_CONNECTION"
    # Устанавливаем TERM на основе LC_TERMINAL от клиента
    if test "$LC_TERMINAL" = "ghostty"
        if infocmp xterm-ghostty >/dev/null 2>&1
            set -x TERM xterm-ghostty
        end
    else if not infocmp $TERM >/dev/null 2>&1
        set -x TERM xterm-256color
    end
end
